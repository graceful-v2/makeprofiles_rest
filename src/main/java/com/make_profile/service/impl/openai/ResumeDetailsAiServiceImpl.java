package com.make_profile.service.impl.openai;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.make_profile.repository.user.UserRepository;
import org.apache.commons.io.FilenameUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.openai.ChatCompleitonResponse;
import com.make_profile.dto.openai.ChatCompletionRequest;
import com.make_profile.entity.candidates.CandidateEntity;
import com.make_profile.repository.candidates.CandidatesRepository;
import com.make_profile.service.candidates.CandidateService;
import com.make_profile.service.openai.ResumeDetailsAiService;
import com.make_profile.service.openai.ResumeJsonIntoStringService;

@Service
public class ResumeDetailsAiServiceImpl implements ResumeDetailsAiService {

    private static final Logger logger = LoggerFactory.getLogger(ResumeDetailsAiServiceImpl.class);

    @Autowired
    RestTemplate restTemplate;

    @Autowired
    ResumeJsonIntoStringService resumeJsonIntoStringService;

    @Autowired
    CandidateService candidateService;

    @Autowired
    CandidatesRepository candidatesRepository;

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    UserRepository userRepository;

    int count = 3;

    @Override
    public CandidateDto getUploadResumeDetialsFromAi(MultipartFile resume, String userName) {
        logger.debug("Service :: getUploadResumeDetialsFromAi :: Entered ");

        CandidateDto responseCandidateDto = null;
        try {

            String fileName = resume.getOriginalFilename() != "" || resume.getOriginalFilename() != null
                    ? resume.getOriginalFilename()
                    : resume.getName();
            String message = "";
            if (fileName.endsWith(".txt")) {
                message = extractTextFromPlainText(fileName);
            } else {
                message = convertFileToText(resume);
            }

            String candidateDto = """
                    {
                      id: "", name: "", mobileNumber: "", email: "", nationality: "", gender: "",
                      languagesKnown: "", isFresher: "", skills: "", linkedIn: "", dob: "", address: "",
                      maritalStatus: "", summary: "", careerObjective: "", fatherName:"",hobbies:"",
                      experiences: [
                        {
                          id: "", companyName: "", role: "", experienceYearStartDate: "",
                          experienceYearEndDate: "", currentlyWorking: false,
                          responsibilities: "", projects: [
                            {
                              projectName: "", projectSkills: "", projectRole: "",
                              projectDescription: ""
                            }
                          ]
                        }
                      ],
                      qualification: [
                        {
                          id: "", institutionName: "", department: "", qualificationStartYear: "",
                          qualificationEndYear: "", percentage: "", fieldOfStudy: ""
                        }
                      ],
                      certificates: [
                        {
                          id: "", courseName: "", courseStartDate: "",
                          courseEndDate: ""
                        }
                      ],
                      achievements: [
                        {
                          id: "", achievementsName: "", achievementsDate: ""
                        }
                      ],
                      diplomaEducation: [
                            {
                              id: "", diplomaInstitutionName: "", qualificationLevel: "", diplomaStartYear: "",
                              diplomaEndYear: "",percentage: ""
                            }
                          ],
                  schoolEducation: [
                    {
                      id: "", schoolName: "",  educationLevel: "", schoolStartYear: "",
                      schoolEndYear: "", percentage: ""
                    }
                  ],

                  strengths = "",
                  goals = "",
                  extraCurricularActivities="",
                      
                      strengths = "",
                      goals = "",
                      extraCurricularActivities="",
                    
                      candidateLogo: "", softSkills: "", coreCompentencies: "", score: "",
                      matches: false,
                      collegeProject: [
                        {
                          id: "", collegeProjectName: "", collegeProjectSkills: "",
                          collegeProjectDescription: ""
                        }
                      ]
                    }
                    """;

            String query = """
                    I will provide my resume content below, along with an example DTO format above.
                    
                    Please:
                    1. Enhance my resume by adding:
                       • A professional summary tailored to my profile.
                       • A career objective aligned with my experience and aspirations.
                       • Relevant skills inferred from my resume details.
                    2. Convert all date fields into Java LocalDate format (yyyy-MM-dd).
                    3. Ensure my mobile number is correctly extracted and included.
                    4. Ensure my name is mapped to the name field, and if my father’s name is present, map it separately to the fatherName field (not under name).
                    5.Experience & Projects:
                        • For every experience entry, if any project details related to that experience appear elsewhere in the resume, map them under the corresponding experience with correct duration.
                        • If experience entries are present, add additional responsibilities based on the nature of the job.
                        • If project entries are present, expand them with richer project descriptions, including impact, technologies used, and responsibilities.
                    6. Populate the provided DTO structure with the enhanced and corrected resume data.
                    7. Return the completed DTO as the output.
                    
                    """;

            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini",
                    candidateDto + query + message);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions",
                    chatRequest, ChatCompleitonResponse.class);

            responseCandidateDto = convertResponseString(response.getChoices().get(0).getMessage().getContent(), resume,
                    userName);

        } catch (Exception e) {
            logger.error("Service :: getUploadResumeDetialsFromAi :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getUploadResumeDetialsFromAi :: Exited ");
        return responseCandidateDto;
    }

    private CandidateDto convertResponseString(String response, MultipartFile content, String userName)
            throws Exception {

        logger.debug("Service :: convertResponseString :: Entered");

        CandidateDto responseCandidateDto = null;
        CandidateDto createCandidate = null;
        try {
            JsonObject jsonObject = null;
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
                System.out.println("JSON Object: " + jsonObject.toString());
            }
            responseCandidateDto = resumeJsonIntoStringService.resumeJsonToString(jsonObject);

            responseCandidateDto.setCreatedUserName(userName);

            if (Objects.nonNull(responseCandidateDto)) {
                createCandidate = candidateService.createCandidate(responseCandidateDto, userName);
            }
            responseCandidateDto = null;

        } catch (Exception e) {
            if (count > 0) {
                count--;
                getUploadResumeDetialsFromAi(content, userName);
            } else {
                logger.error("Service :: convertResponseString :: Exception " + e.getMessage());
            }
        }
        logger.debug("Service :: convertResponseString :: Exited ");
        return createCandidate;

    }

    private String extractTextFromPlainText(String filePath) throws IOException {
        return new String(Files.readAllBytes(Paths.get(filePath)));
    }

    private String convertFileToText(MultipartFile file) {
        logger.debug("Controller :: convertFileToText :: Entered");

        String text = null;
        try {
            String fileName = FilenameUtils.getExtension(file.getOriginalFilename());

            if (fileName.equalsIgnoreCase("pdf")) {
                // PDDocument pdfDocument =
                // Loader.loadPDF(file.getInputStream().readAllBytes());
                PDDocument pdfDocument = PDDocument.load(file.getInputStream().readAllBytes());

                PDFTextStripper pdfTextStripper = new PDFTextStripper();
                text = pdfTextStripper.getText(pdfDocument);
            } else if (fileName.equalsIgnoreCase("doc") || fileName.equalsIgnoreCase("docx")) {
                XWPFDocument wordDocument = new XWPFDocument(file.getInputStream());
                XWPFWordExtractor extractor = new XWPFWordExtractor(wordDocument);
                text = extractor.getText();
                extractor.close();
            }

        } catch (Exception e) {
            logger.error("Service :: convertFileToText :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertFileToText :: Exited");
        return text;
    }

    @Override
    public CandidateDto getResumeDetailsFromOpenAiForCandidate(MultipartFile resume) {

        logger.debug("Service :: getResumeDetailsFromOpenAiForCandidate :: Entered ");

        CandidateDto responseCandidateDto = null;
        try {

            String fileName = resume.getOriginalFilename() != "" || resume.getOriginalFilename() != null
                    ? resume.getOriginalFilename()
                    : resume.getName();
            String message = "";
            if (fileName.endsWith(".txt")) {
                message = extractTextFromPlainText(fileName);
            } else {
                message = convertFileToText(resume);
            }

            String candidateDto = """
                    {
                      id: "", name: "", mobileNumber: "", email: "", nationality: "", gender: "",
                      languagesKnown: "", isFresher: "", skills: "", linkedIn: "", dob: "", address: "",
                      maritalStatus: "", summary: "", careerObjective: "", fatherName:"",hobbies:"",
                      experiences: [
                        {
                          id: "", companyName: "", role: "", experienceYearStartDate: "",
                          experienceYearEndDate: "", currentlyWorking: false,
                          responsibilities: "", projects: [
                            {
                              projectName: "", projectSkills: "", projectRole: "",
                              projectDescription: ""
                            }
                          ]
                        }
                      ],
                      qualification: [
                        {
                          id: "", institutionName: "", department: "", qualificationStartYear: "",
                          qualificationEndYear: "", percentage: "", fieldOfStudy: ""
                        }
                      ],
                       diplomaEducation: [
                              {
                                id: "", diplomaInstitutionName: "", qualificationLevel: "", diplomaStartYear: "",
                                diplomaEndYear: "",percentage: ""
                              }
                            ],
                    schoolEducation: [
                      {
                        id: "", schoolName: "",  educationLevel: "", schoolStartYear: "",
                        schoolEndYear: "", percentage: ""
                      }
                    ],
    
                    strengths = "",
                    goals = "",
                    extraCurricularActivities="",
                      certificates: [
                        {
                          id: "", courseName: "", courseStartDate: "",
                          courseEndDate: ""
                        }
                      ],
                      achievements: [
                        {
                          id: "", achievementsName: "", achievementsDate: ""
                        }
                      ],
                      candidateLogo: "", softSkills: "", coreCompentencies: "", score: "",
                      matches: false,
                      collegeProject: [
                        {
                          id: "", collegeProjectName: "", collegeProjectSkills: "",
                          collegeProjectDescription: ""
                        }
                      ]
                    }
                    """;

            String query = """
                    I will provide my resume content below, along with an example DTO format above.
                    
                    Please:
                    1. Enhance my resume by adding:
                       • A professional summary tailored to my profile.
                       • A career objective aligned with my experience and aspirations.
                       • Relevant skills inferred from my resume details.
                    2. Convert all date fields into Java LocalDate format (yyyy-MM-dd).
                    3. Ensure my mobile number is correctly extracted and included.
                    4. Ensure my name is mapped to the name field, and if my father’s name is present, map it separately to the fatherName field (not under name).
                  5.Experience & Projects:
                        • For every experience entry, if any project details related to that experience appear elsewhere in the resume, map them under the corresponding experience with correct duration.
                        • If experience entries are present, add additional responsibilities based on the nature of the job.
                        • If project entries are present, expand them with richer project descriptions, including impact, technologies used, and responsibilities.
                    6. Populate the provided DTO structure with the enhanced and corrected resume data.
                    7. Return the completed DTO as the output.
                    
                    """;

            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini",
                    candidateDto + query + message);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions",
                    chatRequest, ChatCompleitonResponse.class);

            responseCandidateDto = convertResumeResponseString(response.getChoices().get(0).getMessage().getContent(),
                    resume);

        } catch (Exception e) {
            logger.error("Service :: getResumeDetailsFromOpenAiForCandidate :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getResumeDetailsFromOpenAiForCandidate :: Exited ");
        return responseCandidateDto;
    }

    @Override
    public List<String> validateAutoFillContentFromLogin(MultipartFile resume) {

        logger.debug("Service :: validateAutoFillContentFromLogin :: Entered");

        List<String> message = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        try {

            String fileName = resume.getOriginalFilename() != "" || resume.getOriginalFilename() != null
                    ? resume.getOriginalFilename()
                    : resume.getName();
            String content = "";
            if (fileName.endsWith(".txt")) {
                content = extractTextFromPlainText(fileName);
            } else {
                content = convertFileToText(resume);
            }

            sb.append("<ul>");

            String regex = "(\\+91[-\\s]?)?[0-9]{10,12}";
            String mobile = checkMobileAndEmailAredyExits(regex, content);

            if (Objects.nonNull(mobile)) {
                String mobileNumber = validateMobileNumber(mobile);

                if (userRepository.getUserByMobileNumber(mobileNumber) != 0) {
                    sb.append("<li>Mobile Number Already Exits ,Go Back To Home and SignIn </li>");
                }
            } else {
                sb.append("<li>Enter Your Mobile Number</li>");
            }

            String mailRegex = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}";
            String mailId = checkMobileAndEmailAredyExits(mailRegex, content);
            if (Objects.nonNull(mailId)) {
                if (userRepository.getUserByEmail(mailId) != 0) {
                    sb.append("<li>Mail Id Already Exits ,Go Back To Home and SignIn </li>");
                }
            } else {
                sb.append("<li>Enter Your Mail Id</li>");
            }


            if (sb.toString().contains("<li>")) {
                sb.append("<li>Check whether you have given skills and project details</li>");
                sb.append("</ul>");
                message.add(sb.toString());
            }


        } catch (Exception e) {
            logger.error("Service :: validateAutoFillContentFromLogin :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: validateAutoFillContentFromLogin :: Exited");
        return message;
    }


    private String validateMobileNumber(String num) {

        num = num == null ? "" : num.replace("+", "").replace("-", "").replace(" ", "");

        if (Pattern.compile("[a-zA-Z]+").matcher(num).find()) {

            num = num.replaceAll("[a-zA-Z]+", "");

        }
        if (num.length() > 9) {
            int size = num.length();
            num = num.substring(size - 10, size);
        }

        return num;
    }

    private String checkMobileAndEmailAredyExits(String regex, String content) {
        logger.debug("Service :: checkMobileAndEmailAredyExits :: Entered");

        String mobileOrEmail = null;
        try {
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(content);
            while (matcher.find()) {
                mobileOrEmail = matcher.group();
                break;
            }
        } catch (Exception e) {
            logger.error("Service :: checkMobileAndEmailAredyExits :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: checkMobileAndEmailAredyExits :: Exited");

        return mobileOrEmail;
    }

    private CandidateDto convertResumeResponseString(String response, MultipartFile content) throws Exception {

        logger.debug("Service :: convertResumeResponseString :: Entered");

        CandidateDto responseCandidateDto = null;

        try {
            JsonObject jsonObject = null;
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
                System.out.println("JSON Object: " + jsonObject.toString());
            }
            responseCandidateDto = resumeJsonIntoStringService.resumeJsonToString(jsonObject);

        } catch (Exception e) {
            if (count > 0) {
                count--;
                getResumeDetailsFromOpenAiForCandidate(content);
            } else {
                logger.error("Service :: convertResumeResponseString :: Exception " + e.getMessage());
            }
        }
        logger.debug("Service :: convertResumeResponseString :: Exited ");
        return responseCandidateDto;

    }

}
