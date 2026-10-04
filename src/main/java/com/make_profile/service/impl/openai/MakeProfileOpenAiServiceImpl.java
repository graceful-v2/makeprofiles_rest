package com.make_profile.service.impl.openai;

import java.net.SocketTimeoutException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.master.CreditsDto;
import com.make_profile.dto.openai.ChatCompleitonResponse;
import com.make_profile.dto.openai.ChatCompletionRequest;
import com.make_profile.repository.user.UserRepository;
import com.make_profile.service.master.CreditsService;
import com.make_profile.service.openai.ConvertJsonIntoCandidateDtoService;
import com.make_profile.service.openai.ExtractResultFromOpenAiService;
import com.make_profile.service.openai.MakeProfileOpenAiService;
import com.make_profile.utility.CommonConstants;

@Service
public class MakeProfileOpenAiServiceImpl implements MakeProfileOpenAiService {

    private static final Logger logger = LoggerFactory.getLogger(MakeProfileOpenAiServiceImpl.class);

    @Autowired
    RestTemplate restTemplate;

    @Autowired
    ExtractResultFromOpenAiService extractResultFromOpenAiService;

    @Autowired
    ConvertJsonIntoCandidateDtoService convertJsonIntoCandidateDtoService;

    @Autowired
    CreditsService creditsService;

    @Autowired
    UserRepository userRepository;

    int count = 3;

    @Override
    public CandidateDto makeProfileAi(String selfIntro) {
        logger.debug("Service :: makeProfileAi :: Entered");

        try {

            String prompt = """
                    i will give you a self-introduction text.
                    From that text, carefully extract all the personal, educational, and professional details
                    and map them into the following DTO format.
                    
                    Important Rules:
                    - Fill each field only if the information is available in the text.
                    - Leave fields blank ("") if the information is not mentioned.
                    - Always map data to the correct field (e.g., mobileNumber → phone number, email → email,
                      qualification → education details, experiences → work details, etc.).
                    - Dates should be preserved in the format provided in the text.(dd/mm/yyyy)
                    - Skills should be split logically into `skills`, `softSkills`, or `coreCompentencies` where applicable.
                    - Multiple values (like languagesKnown, hobbies, skills) should be comma-separated.
                    - Projects, certificates, achievements, and collegeProject should be filled if mentioned, otherwise remain empty.
                    
                    ### DTO Format:
                    {
                      id: "", name: "", mobileNumber: "", email: "", nationality: "", gender: "",
                      fatherName:"", hobbies:"", languagesKnown: "", isFresher: "", skills: "",
                      linkedIn: "", dob: "", address: "", maritalStatus: "", summary: "", careerObjective: "",
                    
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
                    
                    ### Self-Introduction:
                    "%s"
                    
                    Now return the filled DTO JSON object with extracted details.
                    """;

            String finalPrompt = String.format(prompt, selfIntro);

            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", finalPrompt);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions",
                    chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: makeProfileAi :: Exited");

            return convertResponseString(response.getChoices().get(0).getMessage().getContent(), selfIntro);

        } catch (Exception e) {
            logger.error("Service :: makeProfileAi :: Exception :: " + e.getMessage());
            return null;
        }

    }

    private CandidateDto convertResponseString(String response, String content) throws Exception {
        logger.debug("Service :: convertResponseString :: Entered ");
        CandidateDto responseCandidateDto = null;
        try {
            JsonObject jsonObject = null;
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
            }
            responseCandidateDto = convertJsonIntoCandidateDtoService.jsonToString(jsonObject);
        } catch (Exception e) {
            if (count > 0) {
                count--;
                makeProfileAi(content);
            } else {
                logger.error("Service :: convertResponseString :: Exception :: " + e.getMessage());
            }
        }
        logger.debug("Service :: convertResponseString :: Exited");
        return responseCandidateDto;

    }

    @Override
    public CandidateDto getSummaryFromAi(String content, String username, String templateName, String jobFor) {
        logger.debug("Service :: getSummaryFromAi :: Entered");

        CandidateDto result = null;
        int retries = 3;

        while (retries-- > 0) {
            try {
                String dto = """
                        {
                          id: "", name: "", mobileNumber: "", email: "", nationality: "", gender: "",
                          fatherName:"", hobbies:"",languagesKnown: "", isFresher: "", skills: "",
                          linkedIn: "", dob: "", address: "",
                          maritalStatus: "", summary: "", careerObjective: "",
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
                            This is my DTO template. I will paste resume content below.
                        
                            Please:
                            1. Extract details from my resume and populate the DTO fields accurately.
                            2. Add a professional summary tailored to my profile, between 70 and 90 words, forming a cohesive narrative that balances present competencies with future ambitions. 
                               If the candidate is a fresher (i.e., jobFor contains any specific job role such as "Java Developer", "Web Developer", "UI/UX Designer", etc.), focus the summary on education, academic projects, internships, technical skills, and enthusiasm to begin a career in the %s field. 
                               If the candidate is experienced (i.e., jobFor equals "experience"), focus on achievements, domain expertise, leadership, problem-solving, and measurable career growth.
                            3. Add a career objective aligned with my experience and aspirations, between 70 and 90 words, forming a cohesive narrative that balances current abilities with future goals.
                               If the candidate is a fresher, make it forward-looking, emphasizing eagerness to learn, contribute, and grow in the %s field. 
                               If the candidate is experienced, align it with long-term professional development, innovation, and value creation within their industry.
                            4. Include relevant skills inferred from my resume details and also add additional key skills that are highly relevant and commonly required in the %s domain or job role.
                            5. Convert all date fields into Java LocalDate format (yyyy-MM-dd).
                            6. Ensure my mobile number is correctly captured and included.
                            7. Return only the completed DTO as the output.
                        """.formatted(jobFor, jobFor, jobFor)
                        + content;


                ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", dto + query);

                ChatCompleitonResponse response = restTemplate.postForObject(
                        "https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

                result = convertSummaryResponseString(response.getChoices().get(0).getMessage().getContent(), content,
                        username, templateName, jobFor);

                break;
            } catch (ResourceAccessException ex) {
                if (ex.getCause() instanceof SocketTimeoutException) {
                    logger.warn("Timeout occurred, retries left: " + retries);

                } else {
                    break;
                }
            } catch (Exception e) {
                logger.error("Service :: getSummaryFromAi :: Exception :: " + e.getMessage());
                break;
            }
        }
//		if (result == null) {
//			OpenAiTimeoutCredits(templateName, username);
//		}
        logger.debug("Service :: getSummaryFromAi :: Exited");
        return result;

    }

    private CandidateDto convertSummaryResponseString(String response, String content, String username,
                                                      String templateName, String jobFor) throws Exception {
        logger.debug("Service :: convertSummaryResponseString :: Entered ");

        CandidateDto responseCandidateDto = null;
        try {
            JsonObject jsonObject = null;
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
            }
            responseCandidateDto = convertJsonIntoCandidateDtoService.jsonToString(jsonObject);
        } catch (Exception e) {
            if (count > 0) {
                count--;
                getSummaryFromAi(content, username, templateName, jobFor);

            } else {
                logger.error("Service :: convertSummaryResponseString :: Exception :: " + e.getMessage());
            }
        }
        logger.debug("Service :: convertSummaryResponseString :: Exited");
        return responseCandidateDto;

    }

    public boolean OpenAiTimeoutCredits(String templateName, String userName) {
        logger.debug("Service :: OpenAiTimeoutCredits :: Entered");

        boolean status = false;
        CreditsDto creditsDto = new CreditsDto();
        try {
            creditsDto.setUserId(userRepository.getUserId(userName));
            creditsDto.setCreditAvailable(1.0);
            creditsDto.setPaymentDate(LocalDate.now());
//			creditsDto.setTemplateName(templateName);

            creditsService.addCredits(creditsDto);

            status = true;
        } catch (Exception e) {
            logger.debug("Service :: OpenAiTimeoutCredits :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: OpenAiTimeoutCredits :: Exited");
        return status;

    }

    @Override
    public List<String> validateAutoFillContent(String content, boolean isActiveUser) {
        logger.debug("Service :: validateAutoFillContent :: Entered");

        List<String> message = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        try {
            sb.append("<ul>");

            if (content.contains("Abc")) {
                sb.append("<li>Change Your Name</li>");
            }
            if (content.contains("XXXXX")) {
                sb.append("<li>Change Your College Name</li>");
            }
            if (content.contains("YYY")) {
                sb.append("<li>Change Your Company Name</li>");
            }
            if (content.contains("1234567891")) {
                sb.append("<li>Change Your Mobile Number</li>");
            }

            if (content.contains("abc@example.com")) {
                sb.append("<li>Change Your Email Address</li>");
            }

            if (content.contains("Male/Female")) {
                sb.append("<li>Change Your gender</li>");
            }

            if (content.contains("100%")) {
                sb.append("<li>Change Your Percentage</li>");
            }

            if (content.contains("period 29th January 1955 to 30th March 1963")) {
                sb.append("<li>Change Your College Years</li>");
            }

            if (content.contains("1st April 1963 to 31st March 1964")) {
                sb.append("<li>Change Your Experience Years</li>");
            }

            if (!isActiveUser) {
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
            }

            if (sb.toString().contains("<li>")) {
                sb.append("<li>Check whether you have given skills and project details</li>");
                sb.append("</ul>");
                message.add(sb.toString());
            }


        } catch (Exception e) {
            logger.error("Service :: validateAutoFillContent :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: validateAutoFillContent :: Exited");
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


}
