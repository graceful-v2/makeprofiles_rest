package com.make_profile.service.impl.resume;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.make_profile.dto.resume.GeneratePdfResponseDto;
import com.make_profile.dto.templates.TemplatePagesDto;
import com.make_profile.entity.candidates.CandidateEntity;
import com.make_profile.repository.candidates.CandidatesRepository;
import com.make_profile.service.candidates.FindResumePageCountService;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.docx4j.convert.in.xhtml.XHTMLImporterImpl;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.util.CollectionUtils;

import com.make_profile.dto.candidates.CandidateAchievementsDto;
import com.make_profile.dto.candidates.CandidateCertificatesDto;
import com.make_profile.dto.candidates.CandidateCollegeProjectDto;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.candidates.CandidateExperienceDto;
import com.make_profile.dto.candidates.CandidateProjectDetailsDto;
import com.make_profile.dto.candidates.CandidateQualificationDto;
import com.make_profile.dto.master.ResponcePdfDto;
import com.make_profile.dto.master.ResumeTemplateDto;
import com.make_profile.entity.master.CreditsEntity;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.repository.candidates.CandidateImageRepository;
import com.make_profile.repository.master.CreditsRepository;
import com.make_profile.repository.user.UserRepository;
import com.make_profile.service.candidates.CheckResumePageCountService;
import com.make_profile.service.master.CreditsService;
import com.make_profile.service.openai.MakeProfileOpenAiService;
import com.make_profile.service.resume.CreateResumeTemplateService;
import com.make_profile.utility.CommonConstants;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Service
public class CreateResumeTemplateTemplateServiceImpl implements CreateResumeTemplateService {

    private static final Logger logger = LoggerFactory.getLogger(CreateResumeTemplateTemplateServiceImpl.class);

    @Autowired
    private Configuration configuration;

    @Autowired
    MakeProfileOpenAiService makeProfileOpenAiService;

    @Autowired
    CheckResumePageCountService checkResumePageCountService;

    @Autowired
    UserRepository userRepository;

    @Autowired
    CreditsRepository creditsRepository;

    @Autowired
    CandidateImageRepository candidateImageRepository;

    @Autowired
    CreditsService creditsService;

    @Autowired
    CandidatesRepository candidatesRepository;

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    FindResumePageCountService findResumePageCountService;

    @Override
    public ResponcePdfDto createResumeTemplate(CandidateDto candidate, String username, Long userId, boolean additionalDetails) throws MakeProfileException {
        logger.debug("Service :: createResumeTemplate :: Extered");

        Map<String, Object> variables = new HashMap<>();
        Template template = null;
        String imageLocation = null;
//		StringBuilder subject = new StringBuilder();

        byte[] convertHtmlToPdf = null;

        String resumeHtmlCode = null;

        ResponcePdfDto responcePdfDto = new ResponcePdfDto();
        try {
//			CandidateDto candidateDto = convertCandidateDtoIntoString(candidate);

            CreditsEntity findCreditsByUserId = creditsRepository.findCreditsByUserId(userId);

            if (Objects.nonNull(findCreditsByUserId) && Math.round(findCreditsByUserId.getCreditAvailable()) <= 0) {
                findCreditsByUserId = null;
                responcePdfDto = null;

                throw new MakeProfileException(CommonConstants.MP_0016);
            }
            findCreditsByUserId = null;

            if (Objects.nonNull(candidate)) {

                variables.put("phone", candidate.getMobileNumber());
                variables.put("name", candidate.getName());
                variables.put("email", candidate.getEmail());
                // variables.put("summary", candidateDto.getSummary());

                if (Objects.nonNull(candidate.getLinkedIn()) && !candidate.getLinkedIn().isEmpty()) {
                    variables.put("linkedin", candidate.getLinkedIn());
                }

                if (Objects.nonNull(candidate.getAddress()) && !candidate.getAddress().isEmpty()) {
                    variables.put("address", removeSpecialCharacterFromContent(candidate.getAddress()));
                }

                if (Objects.nonNull(candidate.getDob())) {
                    variables.put("dob", candidate.getDob());
                }

                if (Objects.nonNull(candidate.getGender()) && !candidate.getGender().isEmpty()) {
                    variables.put("gender", candidate.getGender());
                }

                if (Objects.nonNull(candidate.getLanguagesKnown()) && !candidate.getLanguagesKnown().isEmpty()) {
                    variables.put("languagesKnown", candidate.getLanguagesKnown());
                }

                if (Objects.nonNull(candidate.getFatherName()) && !candidate.getFatherName().isEmpty()) {
                    variables.put("fatherName", candidate.getFatherName());
                }

                if (Objects.nonNull(candidate.getMaritalStatus()) && !candidate.getMaritalStatus().isEmpty()) {
                    variables.put("maritalStatus", candidate.getMaritalStatus());
                }

                if (Objects.nonNull(candidate.getGoals()) && !candidate.getGoals().isEmpty()) {
                    variables.put("goals", removeSpecialCharacterFromContent(candidate.getGoals()));
                }

                if (Objects.nonNull(candidate.getStrengths()) && !candidate.getStrengths().isEmpty()) {
                    variables.put("strengths", removeSpecialCharacterFromContent(candidate.getStrengths()));
                }

                if (Objects.nonNull(candidate.getExtraCurricularActivities()) && !candidate.getExtraCurricularActivities().isEmpty()) {
                    variables.put("extraCurricularActivities", removeSpecialCharacterFromContent(candidate.getExtraCurricularActivities()));
                }

                if (Objects.nonNull(candidate.getHobbies()) && !candidate.getHobbies().isEmpty()) {
                    variables.put("hobbies", removeSpecialCharacterFromContent(candidate.getHobbies()));
                }

                if (Objects.nonNull(candidate.getNationality()) && !candidate.getNationality().isEmpty()) {

                    String nationality = candidate.getNationality();
                    int firstIndex = nationality.indexOf("(");
                    int lastIndex = nationality.indexOf(")");

                    if (firstIndex != -1 && lastIndex != -1 && lastIndex > firstIndex) {
                        variables.put("nationality", nationality.substring(firstIndex + 1, lastIndex));
                    } else {
                        variables.put("nationality", nationality); // safe fallback
                    }
                }



                if (candidate.isFresher()) {
                    variables.put("isFresher", candidate.isFresher());
                } else {

                    if (Objects.nonNull(candidate.getExperiences()) && !candidate.getExperiences().isEmpty()) {

                        List<CandidateExperienceDto> experienceList = new ArrayList<>();

                        candidate.getExperiences().forEach(exp -> {
                            CandidateExperienceDto experiences = new CandidateExperienceDto();

                            if (hasContent(exp.getRole())) {
                                experiences.setRole(removeSpecialCharacterFromContent(exp.getRole()));
                            }

                            if (hasContent(exp.getCompanyName())) {
                                experiences.setCompanyName(removeSpecialCharacterFromContent(exp.getCompanyName()));
                            }

                            experiences.setExperienceYearStartDate(exp.getExperienceYearStartDate());
                            experiences.setExperienceYearEndDate(exp.getExperienceYearEndDate());

                            if (hasContent(exp.getResponsibilities())) {
                                experiences.setResponsibilities(removeSpecialCharacterFromContent(exp.getResponsibilities()));
                            }

                            // Initialize project list for THIS experience only
                            List<CandidateProjectDetailsDto> projectsList = new ArrayList<>();

                            if (Objects.nonNull(exp.getProjects()) && !exp.getProjects().isEmpty()) {
                                exp.getProjects().forEach(project -> {
                                    CandidateProjectDetailsDto pro = new CandidateProjectDetailsDto();

                                    if (hasContent(project.getProjectRole())) {
                                        pro.setProjectRole(removeSpecialCharacterFromContent(project.getProjectRole()));
                                    }

                                    if (hasContent(project.getProjectName())) {
                                        pro.setProjectName(removeSpecialCharacterFromContent(project.getProjectName()));
                                    }

                                    if (hasContent(project.getProjectDescription())) {
                                        pro.setProjectDescription(removeSpecialCharacterFromContent(project.getProjectDescription()));
                                    }

                                    if (hasContent(project.getProjectSkills())) {
                                        pro.setProjectSkills(removeSpecialCharacterFromContent(project.getProjectSkills()));
                                    }

                                    projectsList.add(pro);
                                });
                            }

                            experiences.setProjects(projectsList);
                            experienceList.add(experiences);
                        });

                        variables.put("experiences", experienceList);
                    }
                }

                if (Objects.nonNull(candidate.getSkills()) && !candidate.getSkills().isEmpty()) {
                    variables.put("skills", removeSpecialCharacterFromContent(candidate.getSkills()));
                }

                if (Objects.nonNull(candidate.getCertificates()) && !CollectionUtils.isEmpty(candidate.getCertificates())) {

                    List<CandidateCertificatesDto> certificatesList = new ArrayList<>();

                    candidate.getCertificates().forEach(certificate -> {
                        CandidateCertificatesDto cer = new CandidateCertificatesDto();

                        if (hasContent(certificate.getCourseName())) {
                            cer.setCourseName(removeSpecialCharacterFromContent(certificate.getCourseName()));
                        }
                        cer.setCourseStartDate(certificate.getCourseStartDate());
                        cer.setCourseEndDate(certificate.getCourseEndDate());
                        certificatesList.add(cer);

                        cer = null;
                    });

                    variables.put("certificates", candidate.getCertificates());
                }

                if ((Objects.nonNull(candidate.getQualification()) && !CollectionUtils.isEmpty(candidate.getQualification())) || (Objects.nonNull(candidate.getSchoolEducation()) && !CollectionUtils.isEmpty(candidate.getSchoolEducation())) || Objects.nonNull(candidate.getDiplomaEducation()) && !CollectionUtils.isEmpty(candidate.getDiplomaEducation())) {

                    List<CandidateQualificationDto> educationList = new ArrayList<>();
                    if (Objects.nonNull(candidate.getQualification()) && !CollectionUtils.isEmpty(candidate.getQualification())) {

                        candidate.getQualification().forEach(quali -> {
                            CandidateQualificationDto qulification = new CandidateQualificationDto();

                            if (hasContent(quali.getInstitutionName())) {
                                qulification.setInstitutionName(removeSpecialCharacterFromContent(quali.getInstitutionName()));
                            }

                            if (hasContent(quali.getDepartment())) {
                                qulification.setDepartment(removeSpecialCharacterFromContent(quali.getDepartment()));
                            }

                            if (hasContent(quali.getFieldOfStudy())) {
                                qulification.setFieldOfStudy(removeSpecialCharacterFromContent(quali.getFieldOfStudy()));
                            }

                            qulification.setQualificationStartYear(quali.getQualificationStartYear());
                            qulification.setQualificationEndYear(quali.getQualificationEndYear());
                            qulification.setPercentage(quali.getPercentage());

                            educationList.add(qulification);
                            qulification = null;
                        });

                    }

                    if (Objects.nonNull(candidate.getSchoolEducation()) && !CollectionUtils.isEmpty(candidate.getSchoolEducation())) {

                        candidate.getSchoolEducation().forEach(school -> {
                            CandidateQualificationDto qualification = new CandidateQualificationDto();

                            if (hasContent(school.getSchoolName())) {
                                qualification.setInstitutionName(removeSpecialCharacterFromContent(school.getSchoolName()));
                            }

                            if (hasContent(school.getEducationLevel())) {
                                qualification.setDepartment(removeSpecialCharacterFromContent(school.getEducationLevel()));
                            }

                            qualification.setQualificationStartYear(school.getSchoolStartYear());
                            qualification.setQualificationEndYear(school.getSchoolEndYear());
                            qualification.setPercentage(school.getPercentage());

                            educationList.add(qualification);

                            qualification = null;
                        });
                    }


                    if (Objects.nonNull(candidate.getDiplomaEducation()) && !CollectionUtils.isEmpty(candidate.getDiplomaEducation())) {

                        candidate.getDiplomaEducation().forEach(school -> {
                            CandidateQualificationDto qualification = new CandidateQualificationDto();

                            if (hasContent(school.getDiplomaInstitutionName())) {
                                qualification.setInstitutionName(removeSpecialCharacterFromContent(school.getDiplomaInstitutionName()));
                            }

                            if (hasContent(school.getQualificationLevel())) {
                                qualification.setDepartment(removeSpecialCharacterFromContent(school.getQualificationLevel()));
                            }

                            qualification.setQualificationStartYear(school.getDiplomaStartYear());
                            qualification.setQualificationEndYear(school.getDiplomaEndYear());
                            qualification.setPercentage(school.getPercentage());

                            educationList.add(qualification);

                            qualification = null;
                        });
                    }

                    variables.put("education", educationList);


                }

                if (Objects.nonNull(candidate.getSoftSkills()) && !candidate.getSoftSkills().isEmpty()) {
                    variables.put("softSkills", removeSpecialCharacterFromContent(candidate.getSoftSkills()));
                }

                if (Objects.nonNull(candidate.getAchievements()) && !CollectionUtils.isEmpty(candidate.getAchievements())) {

                    List<CandidateAchievementsDto> achievementsList = new ArrayList<>();

                    candidate.getAchievements().forEach(achieve -> {
                        CandidateAchievementsDto achievements = new CandidateAchievementsDto();

                        if (hasContent(achieve.getAchievementsName())) {
                            achievements.setAchievementsName(removeSpecialCharacterFromContent(achieve.getAchievementsName()));

                        }
                        achievements.setAchievementsDate(achieve.getAchievementsDate());

                        achievementsList.add(achievements);
                        achievements = null;
                    });
                    variables.put("achievements", achievementsList);
                }

                if (Objects.nonNull(candidate.getCoreCompentencies()) && !candidate.getCoreCompentencies().isEmpty()) {
                    variables.put("competencies", removeSpecialCharacterFromContent(candidate.getCoreCompentencies()));
                }

                if (Objects.nonNull(candidate.getCollegeProject()) && !CollectionUtils.isEmpty(candidate.getCollegeProject())) {

                    List<CandidateCollegeProjectDto> candidateCollegeProjectList = new ArrayList<>();

                    candidate.getCollegeProject().forEach(project -> {
                        CandidateCollegeProjectDto collegeProject = new CandidateCollegeProjectDto();

                        if (hasContent(project.getCollegeProjectName())) {
                            collegeProject.setCollegeProjectName(removeSpecialCharacterFromContent(project.getCollegeProjectName()));
                        }

                        if (hasContent(project.getCollegeProjectSkills())) {
                            collegeProject.setCollegeProjectSkills(removeSpecialCharacterFromContent(project.getCollegeProjectSkills()));
                        }

                        if (hasContent(project.getCollegeProjectDescription())) {
                            collegeProject.setCollegeProjectDescription(removeSpecialCharacterFromContent(project.getCollegeProjectDescription()));
                        }
                        candidateCollegeProjectList.add(collegeProject);
                        collegeProject = null;
                    });
                    variables.put("collegeProject", candidateCollegeProjectList);
                }

                if (Objects.nonNull(candidate.getCareerObjective()) && !candidate.getCareerObjective().isEmpty()) {
                    variables.put("objective", removeSpecialCharacterFromContent(candidate.getCareerObjective()));
                }

                if (Objects.nonNull(candidate.getSummary()) && !candidate.getSummary().isEmpty()) {
                    variables.put("summary", removeSpecialCharacterFromContent(candidate.getSummary()));
                }

                // add photo to the resume

                imageLocation = candidateImageRepository.getImageLocationByCandidateId(candidate.getId());

                if (Objects.nonNull(imageLocation) && !imageLocation.isEmpty()) {

                    variables.put("profileImage", "data:image/png;base64,${base64Image}");
                }

                variables.put("calendarIcon", "${canlendarIcon}");
                variables.put("phoneIcon", "${phoneIcon}");
                variables.put("mailIcon", "${mailIcon}");


                if (additionalDetails) {
                    variables.put("addAdditionalDetails", true);

                } else {
                    variables.put("addAdditionalDetails", false);
                }

                template = configuration.getTemplate(candidate.getTemplateName() + ".ftl");

                resumeHtmlCode = FreeMarkerTemplateUtils.processTemplateIntoString(template, variables);

                // makeProfileOpenAiService.makeProfileAi(processTemplateIntoString);

                //commented Because preview the template in screen
//                resumeHtmlCode = checkResumePageCountService.getResumeHtmlCode(processTemplateIntoString, candidate,
//                        username, candidate.getTemplateName());

                if (Objects.isNull(resumeHtmlCode) || resumeHtmlCode.isEmpty()) {
                    throw new MakeProfileException(CommonConstants.MP_0007);
                }

                if (Objects.nonNull(imageLocation) && !imageLocation.isEmpty() && resumeHtmlCode.contains("${base64Image}")) {
                    String imagePath = "C:/make_profile/Image/" + candidate.getId() + "/" + imageLocation;
                    String base64Image = convertImageToBase64(imagePath);
                    resumeHtmlCode = resumeHtmlCode.replace("${base64Image}", base64Image);

                }

                if (resumeHtmlCode.contains("${canlendarIcon}")) {
                    resumeHtmlCode = resumeHtmlCode.replace("${canlendarIcon}", "data:image/png;base64," + convertImageToBase64(CommonConstants.CALENDARE_ICON_LOCATION));
                }

                if (resumeHtmlCode.contains("${phoneIcon}")) {
                    resumeHtmlCode = resumeHtmlCode.replace("${phoneIcon}", "data:image/png;base64," + convertImageToBase64(CommonConstants.PHONE_ICON_LOCATION));
                }

                if (resumeHtmlCode.contains("${mailIcon}")) {
                    resumeHtmlCode = resumeHtmlCode.replace("${mailIcon}", "data:image/png;base64," + convertImageToBase64(CommonConstants.MAIL_ICON_LOCATION));
                }

//                if (additionalDetails) {
//                    variables.put("addAdditionalDetails", true);
//                    if (getPageSize(candidate.getTemplateName()).equals("1")) {
//                        resumeHtmlCode = addPersonalDetails(resumeHtmlCode, candidate);
//                    } else {
//                        String personalDetails = addPersonalDetailsForTwoPageResume(resumeHtmlCode, candidate);
//
//                        if (checkHtmlContentContainsPersonalDetails(personalDetails)) {
//                            resumeHtmlCode = resumeHtmlCode.replaceAll("(?s)(</div>\\s*</body>)", personalDetails + " </div> </body>");
//                        }
//                    }
//                }
//                else{
//                    variables.put("addAdditionalDetails", false);
//                }

                String response = findResumePageCountService.findResumePageCounts(resumeHtmlCode);

                if (Objects.isNull(response)) {
                    convertHtmlToPdf = convertHtmlToPdf(resumeHtmlCode, candidate.getName() + ".pdf", candidate.getTemplateName(), candidate.getNickName(), userId);
                } else {
                    convertHtmlToPdf = convertHtmlToPdf(response, candidate.getName() + ".pdf", candidate.getTemplateName(), candidate.getNickName(), userId);
                }


                // convertHtmlToDocx(processTemplateIntoString, candidateDto.getName() +
                // ".docx");


                responcePdfDto.setResumePdf(convertHtmlToPdf);
                responcePdfDto.setCandidateName(candidate.getName());
            } else {
                throw new MakeProfileException(CommonConstants.MP_0007);

            }

        } catch (MakeProfileException e) {
            logger.error("Service :: getResumeHtmlCode :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: createResumeTemplate :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: createResumeTemplate :: Exited");
        return responcePdfDto;
    }

    public byte[] convertHtmlToPdf(String html, String outputPath, String templateName, String nickName, Long userId) throws Exception {
        logger.debug("Service :: convertHtmlToPdf :: Entered");

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {

            PdfRendererBuilder builder = new PdfRendererBuilder();
            builder.useDefaultPageSize(210, 297, PdfRendererBuilder.PageSizeUnits.MM);
            builder.withHtmlContent(html, new File(".").toURI().toString());
            builder.toStream(baos);
            builder.useFastMode();
            builder.run();

            byte[] pdfBytes = baos.toByteArray();

            builder = null;

            ResumeTemplateDto resumeTemplateDto = new ResumeTemplateDto();

            resumeTemplateDto.setTemplateName(templateName);

            creditsService.useCredit(resumeTemplateDto, userId);

            resumeTemplateDto = null;

            // TODO erase this after completing
            System.out.println("PDF generated successfully at: " + outputPath);

            logger.debug("Service :: convertHtmlToPdf :: Exited");
            return pdfBytes;
        } catch (Exception e) {
            logger.error("Service :: convertHtmlToPdf :: Exception :: " + e.getMessage());
            return null;
        }
    }

    public static void convertHtmlToDocx(String html, String outputPath) throws Exception {
        logger.debug("Service :: convertHtmlToDocx :: Extered");
        try {

            WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.createPackage();
            XHTMLImporterImpl xhtmlImporter = new XHTMLImporterImpl(wordMLPackage);
            wordMLPackage.getMainDocumentPart().getContent().addAll(xhtmlImporter.convert(html, null));
            wordMLPackage.save(new File(outputPath));

            System.out.println("Word file generated successfully: " + outputPath);
        } catch (Exception e) {
            logger.error("Service :: convertHtmlToDocx :: Exited" + e.getMessage());
        }
        logger.debug("Service :: convertHtmlToDocx :: Exited");
    }

    public CandidateDto convertCandidateDtoIntoString(CandidateDto candidateDto, String username, String jobFor) {
        logger.debug("Service :: convertCandidateDtoIntoString :: Extered");

        CandidateDto ResponseCandidateDetailsFromOpenAi = null;
        try {
            StringBuilder dtoString = new StringBuilder("CandidateDto: {");

            dtoString.append("id=").append(candidateDto.getId()).append(", ");
            dtoString.append("name=").append(candidateDto.getName()).append(", ");
            dtoString.append("mobileNumber=").append(candidateDto.getMobileNumber()).append(", ");
            dtoString.append("alternateMobileNumber=").append(candidateDto.getAlternateMobileNumber()).append(", ");
            dtoString.append("email=").append(candidateDto.getEmail()).append(", ");
            dtoString.append("nationality=").append(candidateDto.getNationality()).append(", ");
            dtoString.append("fatherName=").append(candidateDto.getFatherName()).append(", ");
            dtoString.append("gender=").append(candidateDto.getGender()).append(", ");
            dtoString.append("languagesKnown=").append(candidateDto.getLanguagesKnown()).append(", ");
            dtoString.append("hobbies=").append(candidateDto.getHobbies()).append(", ");
            dtoString.append("isFresher=").append(candidateDto.isFresher()).append(", ");
            dtoString.append("skills=").append(candidateDto.getSkills()).append(", ");
            dtoString.append("linkedIn=").append(candidateDto.getLinkedIn()).append(", ");
            dtoString.append("dob=").append(candidateDto.getDob()).append(", ");
            dtoString.append("address=").append(candidateDto.getAddress()).append(", ");
            dtoString.append("maritalStatus=").append(candidateDto.getMaritalStatus()).append(", ");
            dtoString.append("experiences=").append(candidateDto.getExperiences()).append(", ");
            dtoString.append("qualification=").append(candidateDto.getQualification()).append(", ");
            dtoString.append("schoolEducation=").append(candidateDto.getSchoolEducation());
            dtoString.append("diplomaEducation=").append(candidateDto.getDiplomaEducation());
            dtoString.append("certificates=").append(candidateDto.getCertificates()).append(", ");
            dtoString.append("achievements=").append(candidateDto.getAchievements()).append(", ");
            dtoString.append("softSkills=").append(candidateDto.getSoftSkills()).append(", ");
            dtoString.append("coreCompentencies=").append(candidateDto.getCoreCompentencies()).append(", ");
            dtoString.append("collegeProject=").append(candidateDto.getCollegeProject());


            dtoString.append("}");

            ResponseCandidateDetailsFromOpenAi = makeProfileOpenAiService.getSummaryFromAi(dtoString.toString(), username, candidateDto.getTemplateName(), jobFor);

            dtoString = null;
        } catch (Exception e) {
            logger.error("Service :: convertCandidateDtoIntoString :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertCandidateDtoIntoString :: Exited");
        return ResponseCandidateDetailsFromOpenAi;

    }

    public String convertImageToBase64(String imagePath) {
        logger.debug("Service :: convertImageToBase64 :: Entered");

        try {
            Path path = Paths.get(imagePath);

            if (!Files.exists(path)) {
                logger.error("Image not found at path: " + imagePath);
                return null;
            }

            if (!Files.isRegularFile(path)) {
                logger.error("Path is not a valid file: " + imagePath);
                return null;
            }

            byte[] imageBytes = Files.readAllBytes(path);

            logger.debug("Service :: convertImageToBase64 :: Exited");
            return Base64.getEncoder().encodeToString(imageBytes);

        } catch (Exception e) {
            logger.error("Service :: convertImageToBase64 :: Exception :: " + e.getMessage(), e);
            return null;
        }
    }


    @Override
    public CandidateDto getContent(CandidateDto candidateDto, String username, String jobFor) throws MakeProfileException {
        logger.debug("Service :: getContent :: Extered");

        CandidateDto candidate = null;
        try {
            candidate = convertCandidateDtoIntoString(candidateDto, username, jobFor);

            if (!CollectionUtils.isEmpty(candidateDto.getSchoolEducation())) {
                candidate.setSchoolEducation(candidateDto.getSchoolEducation());
            }

            if (!CollectionUtils.isEmpty(candidateDto.getDiplomaEducation())) {
                candidate.setDiplomaEducation(candidateDto.getDiplomaEducation());
            }

            if (Objects.nonNull(candidateDto.getGoals()) && !candidateDto.getGoals().isEmpty()) {
                candidate.setGoals(candidateDto.getGoals());
            }

            if (Objects.nonNull(candidateDto.getStrengths()) && !candidateDto.getStrengths().isEmpty()) {
                candidate.setStrengths(candidateDto.getStrengths());
            }

            if (Objects.nonNull(candidateDto.getExtraCurricularActivities()) && !candidateDto.getExtraCurricularActivities().isEmpty()) {
                candidate.setExtraCurricularActivities(candidateDto.getExtraCurricularActivities());
            }

            if (Objects.nonNull(candidateDto.isFresher()) && candidateDto.isFresher()) {
                candidate.setFresher(true);
            }

            if (Objects.nonNull(candidateDto.getId())) {
                candidate.setId(candidateDto.getId());
            }

            saveReponseInDb(candidateDto, candidate);

        } catch (Exception e) {
            logger.error("Service :: getContent :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getContent :: Exited");
        return candidate;
    }

    public void saveReponseInDb(CandidateDto candidateDto, CandidateDto candidate) {
        logger.debug("Service :: saveReponseInDb :: Extered");

        try {
            CandidateEntity candidateEntity = candidatesRepository.findById(candidateDto.getId()).get();
            if (Objects.nonNull(candidate.getSummary())) {
                candidateEntity.setSummary(candidate.getSummary());
            }
            if (Objects.nonNull(candidate.getCareerObjective())) {
                candidateEntity.setCareerObjective(candidate.getCareerObjective() != null ? candidate.getCareerObjective() : null);
            }

            if (Objects.nonNull(candidate.getSkills())) {
                candidateEntity.setSkills(candidate.getSkills());
            }

            candidatesRepository.save(candidateEntity);

            candidateEntity = null;
        } catch (Exception e) {
            logger.error("Service :: saveReponseInDb :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: saveReponseInDb :: Exited");

    }

    public String removeSpecialCharacterFromContent(String content) {
        logger.debug("Service :: removeSpecialCharacterFromContent :: Extered");

        String newContent = null;
        try {
            if (content.contains("&")) {
                newContent = content.replace("&", " ");
            } else {
                return content;
            }
        } catch (Exception e) {
            logger.error("Service :: removeSpecialCharacterFromContent :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: removeSpecialCharacterFromContent :: Exited");
        return newContent;

    }

    public boolean hasContent(String Content) {
        logger.debug("Service :: hasContent :: Extered");

        boolean status = false;
        try {
            if (Objects.nonNull(Content) && !Content.isEmpty()) {
                status = true;
            }
        } catch (Exception e) {
            logger.error("Service :: hasContent :: Exception :: " + e.getMessage());
        }
        return status;

    }

    public boolean checkCandidateDtoContentAlreadyExist(CandidateDto candidateDto) {
        logger.debug("Service :: checkCandidateDtoContentAlreadyExist :: Extered");

        boolean status = false;
        try {
            CandidateEntity candidateEntity = candidatesRepository.findById(candidateDto.getId()).get();
            CandidateDto existingCandidate = modelMapper.map(candidateEntity, CandidateDto.class);

            if (Objects.nonNull(candidateDto.getId())) {
                if (existingCandidate.equals(candidateDto)) {
                    status = true;
                } else {
                    status = false;
                }
            }
            candidateEntity = null;
            existingCandidate = null;
        } catch (Exception e) {
            logger.error("Service :: checkCandidateDtoContentAlreadyExist :: Exception :: " + e.getMessage());
        }
        return status;
    }


    private String addPersonalDetails(String resume, CandidateDto candidate) {

        StringBuilder sb = new StringBuilder();

        String personalDetailsHtml = "<div class=\"section\">\n" + "    <h2>Personal Details</h2>\n";

        if (Objects.nonNull(candidate.getFatherName()) && !candidate.getFatherName().isEmpty()) {
            sb.append("<p><strong>Father's Name:</strong> " + candidate.getFatherName() + "</p> \n");

        }

        if (Objects.nonNull(candidate.getMaritalStatus()) && !candidate.getMaritalStatus().isEmpty()) {
            sb.append("  <p><strong>Marital Status:</strong> " + candidate.getMaritalStatus() + "</p>\n");

        }

        if (Objects.nonNull(candidate.getGender()) && !candidate.getGender().isEmpty()) {
            sb.append("   <p><strong>Gender:</strong> " + candidate.getGender() + "</p>\n");

        }

        if (Objects.nonNull(candidate.getLanguagesKnown()) && !candidate.getLanguagesKnown().isEmpty()) {
            sb.append("   <p><strong>Language Known:</strong> " + Stream.of(candidate.getLanguagesKnown().split(",")).map(String::trim).collect(Collectors.joining(", ")) + "</p>\n");
        }

        if (Objects.nonNull(candidate.getHobbies()) && !candidate.getHobbies().isEmpty()) {
            sb.append("  <p><strong>Hobbies:</strong> " + Stream.of(candidate.getHobbies().split(",")).map(String::trim).collect(Collectors.joining(", ")) + "</p>\n");

        }


        if (Objects.nonNull(candidate.getNationality()) && !candidate.getNationality().isEmpty()) {

            String nationality = candidate.getNationality();
            int firstIndex = nationality.indexOf("(");
            int lastIndex = nationality.indexOf(")");

            if (firstIndex != -1 && lastIndex != -1 && lastIndex > firstIndex) {
                sb.append("   <p><strong>Nationality:</strong> ")
                        .append(nationality.substring(firstIndex + 1, lastIndex))
                        .append("</p>\n");
            } else {
                // fallback – print full value safely
                sb.append("   <p><strong>Nationality:</strong> ")
                        .append(nationality)
                        .append("</p>\n");
            }
        }


        sb.append("</div> ");

        String process = personalDetailsHtml + sb.toString();

        // Insert before right-column starts (end of left-column)
        return resume.replaceAll("(?s)</div>\\s*<div class=\"right-column\">", process + " </div>  <div class=\"right-column\">");

    }

    private String getPageSize(String templateName) {
        logger.debug("Service :: getPageSize :: Entered");

        ObjectMapper objectMapper = new ObjectMapper();
        String pages = null;
        try {
            InputStream is = getClass().getClassLoader().getResourceAsStream("resume_pages/template.json");

            if (is == null) {
                throw new IllegalArgumentException("Template file not found in resources.");
            }
            List<TemplatePagesDto> templates;
            templates = objectMapper.readValue(is, new TypeReference<List<TemplatePagesDto>>() {
            });
            pages = templates.stream().filter(t -> t.getTemplateName().equalsIgnoreCase(templateName)).findFirst().get().getPages();
            objectMapper = null;

        } catch (Exception e) {
            logger.error("Service :: getPageSize :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getPageSize :: Exited");
        return pages;

    }


    public String addPersonalDetailsForTwoPageResume(String htmlContent, CandidateDto candidateDto) {
        logger.debug("Service :: addPersonalDetailsForTwoPageResume :: Entered");

        Template template = null;
        String processTemplateIntoString = null;

        Map<String, Object> variables = new HashMap<>();
        try {

            if (Objects.nonNull(candidateDto.getFatherName())) {
                variables.put("fatherName", candidateDto.getFatherName());
            }

            if (Objects.nonNull(candidateDto.getGender())) {
                variables.put("gender", candidateDto.getGender());
            }

            if (Objects.nonNull(candidateDto.getMaritalStatus())) {
                variables.put("martialStatus", candidateDto.getMaritalStatus());
            }

            if (Objects.nonNull(candidateDto.getLanguagesKnown())) {
                variables.put("languageKnown", candidateDto.getLanguagesKnown());
            }

            if (Objects.nonNull(candidateDto.getHobbies())) {
                variables.put("hobbies", candidateDto.getHobbies());
            }

            if (Objects.nonNull(candidateDto.getAddress())) {
                variables.put("address", candidateDto.getAddress());
            }

            if (Objects.nonNull(candidateDto.getDob())) {
                variables.put("dob", candidateDto.getDob());
            }

            if (Objects.nonNull(candidateDto.getNationality())) {
                variables.put("nationality", candidateDto.getNationality());
            }

            template = configuration.getTemplate(candidateDto.getTemplateName().trim() + "Personal_Details.ftl");

            processTemplateIntoString = FreeMarkerTemplateUtils.processTemplateIntoString(template, variables);


        } catch (Exception e) {
            logger.error("Service :: addPersonalDetailsForTwoPageResume :: Exception :: " + e.getMessage());
        }

        return processTemplateIntoString;
    }

    public boolean checkHtmlContentContainsPersonalDetails(String htmlContent) {

        if (htmlContent.contains("Father Name") || htmlContent.contains("Martial Status") || htmlContent.contains("Language Known") || htmlContent.contains("Gender") || htmlContent.contains("Hobbies") || htmlContent.contains("Dob") || htmlContent.contains("Nationality") || htmlContent.contains("Address")) {
            return true;
        }

        return false;
    }


    @Override
    public GeneratePdfResponseDto generateResumeHtmlContent(CandidateDto candidate, String username, Long userId, boolean additionalDetails) throws MakeProfileException {
        logger.debug("Service :: generateResumeHtmlContent :: Extered");

        Map<String, Object> variables = new HashMap<>();
        Template template = null;
        String imageLocation = null;
        String resumeHtmlCode = null;

        GeneratePdfResponseDto generatePdfResponseDto = new GeneratePdfResponseDto();

        try {

            if (Objects.nonNull(candidate)) {

                variables.put("phone", candidate.getMobileNumber());
                variables.put("name", candidate.getName());
                variables.put("email", candidate.getEmail());
                // variables.put("summary", candidateDto.getSummary());

                if (Objects.nonNull(candidate.getLinkedIn()) && !candidate.getLinkedIn().isEmpty()) {
                    variables.put("linkedin", candidate.getLinkedIn());
                }

                if (Objects.nonNull(candidate.getAddress()) && !candidate.getAddress().isEmpty()) {
                    variables.put("address", removeSpecialCharacterFromContent(candidate.getAddress()));
                }

                if (Objects.nonNull(candidate.getDob())) {
                    variables.put("dob", candidate.getDob());
                }

                if (Objects.nonNull(candidate.getGender()) && !candidate.getGender().isEmpty()) {
                    variables.put("gender", candidate.getGender());
                }

                if (Objects.nonNull(candidate.getLanguagesKnown()) && !candidate.getLanguagesKnown().isEmpty()) {
                    variables.put("languagesKnown", candidate.getLanguagesKnown());
                }

                if (Objects.nonNull(candidate.getFatherName()) && !candidate.getFatherName().isEmpty()) {
                    variables.put("fatherName", candidate.getFatherName());
                }

                if (Objects.nonNull(candidate.getMaritalStatus()) && !candidate.getMaritalStatus().isEmpty()) {
                    variables.put("maritalStatus", candidate.getMaritalStatus());
                }

                if (Objects.nonNull(candidate.getGoals()) && !candidate.getGoals().isEmpty()) {
                    variables.put("goals", removeSpecialCharacterFromContent(candidate.getGoals()));
                }

                if (Objects.nonNull(candidate.getStrengths()) && !candidate.getStrengths().isEmpty()) {
                    variables.put("strengths", removeSpecialCharacterFromContent(candidate.getStrengths()));
                }

                if (Objects.nonNull(candidate.getExtraCurricularActivities()) && !candidate.getExtraCurricularActivities().isEmpty()) {
                    variables.put("extraCurricularActivities", removeSpecialCharacterFromContent(candidate.getExtraCurricularActivities()));
                }

                if (Objects.nonNull(candidate.getHobbies()) && !candidate.getHobbies().isEmpty()) {
                    variables.put("hobbies", removeSpecialCharacterFromContent(candidate.getHobbies()));
                }

                if (Objects.nonNull(candidate.getNationality()) && !candidate.getNationality().isEmpty()) {

                    String nationality = candidate.getNationality();
                    int firstIndex = nationality.indexOf("(");
                    int lastIndex = nationality.indexOf(")");

                    if (firstIndex != -1 && lastIndex != -1 && lastIndex > firstIndex) {
                        variables.put("nationality", nationality.substring(firstIndex + 1, lastIndex));
                    } else {
                        variables.put("nationality", nationality); // safe fallback
                    }
                }



                if (candidate.isFresher()) {
                    variables.put("isFresher", candidate.isFresher());
                } else {

                    if (Objects.nonNull(candidate.getExperiences()) && !candidate.getExperiences().isEmpty()) {

                        List<CandidateExperienceDto> experienceList = new ArrayList<>();

                        candidate.getExperiences().forEach(exp -> {
                            CandidateExperienceDto experiences = new CandidateExperienceDto();

                            if (hasContent(exp.getRole())) {
                                experiences.setRole(removeSpecialCharacterFromContent(exp.getRole()));
                            }

                            if (hasContent(exp.getCompanyName())) {
                                experiences.setCompanyName(removeSpecialCharacterFromContent(exp.getCompanyName()));
                            }

                            experiences.setExperienceYearStartDate(exp.getExperienceYearStartDate());
                            experiences.setExperienceYearEndDate(exp.getExperienceYearEndDate());

                            if (hasContent(exp.getResponsibilities())) {
                                experiences.setResponsibilities(removeSpecialCharacterFromContent(exp.getResponsibilities()));
                            }

                            // Initialize project list for THIS experience only
                            List<CandidateProjectDetailsDto> projectsList = new ArrayList<>();

                            if (Objects.nonNull(exp.getProjects()) && !exp.getProjects().isEmpty()) {
                                exp.getProjects().forEach(project -> {
                                    CandidateProjectDetailsDto pro = new CandidateProjectDetailsDto();

                                    if (hasContent(project.getProjectRole())) {
                                        pro.setProjectRole(removeSpecialCharacterFromContent(project.getProjectRole()));
                                    }

                                    if (hasContent(project.getProjectName())) {
                                        pro.setProjectName(removeSpecialCharacterFromContent(project.getProjectName()));
                                    }

                                    if (hasContent(project.getProjectDescription())) {
                                        pro.setProjectDescription(removeSpecialCharacterFromContent(project.getProjectDescription()));
                                    }

                                    if (hasContent(project.getProjectSkills())) {
                                        pro.setProjectSkills(removeSpecialCharacterFromContent(project.getProjectSkills()));
                                    }

                                    projectsList.add(pro);
                                });
                            }

                            experiences.setProjects(projectsList);
                            experienceList.add(experiences);
                        });

                        variables.put("experiences", experienceList);
                    }
                }

                if (Objects.nonNull(candidate.getSkills()) && !candidate.getSkills().isEmpty()) {
                    variables.put("skills", removeSpecialCharacterFromContent(candidate.getSkills()));
                }

                if (Objects.nonNull(candidate.getCertificates()) && !CollectionUtils.isEmpty(candidate.getCertificates())) {

                    List<CandidateCertificatesDto> certificatesList = new ArrayList<>();

                    candidate.getCertificates().forEach(certificate -> {
                        CandidateCertificatesDto cer = new CandidateCertificatesDto();

                        if (hasContent(certificate.getCourseName())) {
                            cer.setCourseName(removeSpecialCharacterFromContent(certificate.getCourseName()));
                        }
                        cer.setCourseStartDate(certificate.getCourseStartDate());
                        cer.setCourseEndDate(certificate.getCourseEndDate());
                        certificatesList.add(cer);

                        cer = null;
                    });

                    variables.put("certificates", candidate.getCertificates());
                }

                if ((Objects.nonNull(candidate.getQualification()) && !CollectionUtils.isEmpty(candidate.getQualification())) || (Objects.nonNull(candidate.getSchoolEducation()) && !CollectionUtils.isEmpty(candidate.getSchoolEducation())) || Objects.nonNull(candidate.getDiplomaEducation()) && !CollectionUtils.isEmpty(candidate.getDiplomaEducation())) {

                    List<CandidateQualificationDto> educationList = new ArrayList<>();
                    if (Objects.nonNull(candidate.getQualification()) && !CollectionUtils.isEmpty(candidate.getQualification())) {

                        candidate.getQualification().forEach(quali -> {
                            CandidateQualificationDto qulification = new CandidateQualificationDto();

                            if (hasContent(quali.getInstitutionName())) {
                                qulification.setInstitutionName(removeSpecialCharacterFromContent(quali.getInstitutionName()));
                            }

                            if (hasContent(quali.getDepartment())) {
                                qulification.setDepartment(removeSpecialCharacterFromContent(quali.getDepartment()));
                            }

                            if (hasContent(quali.getFieldOfStudy())) {
                                qulification.setFieldOfStudy(removeSpecialCharacterFromContent(quali.getFieldOfStudy()));
                            }

                            qulification.setQualificationStartYear(quali.getQualificationStartYear());
                            qulification.setQualificationEndYear(quali.getQualificationEndYear());
                            qulification.setPercentage(quali.getPercentage());

                            educationList.add(qulification);
                            qulification = null;
                        });

                    }

                    if (Objects.nonNull(candidate.getSchoolEducation()) && !CollectionUtils.isEmpty(candidate.getSchoolEducation())) {

                        candidate.getSchoolEducation().forEach(school -> {
                            CandidateQualificationDto qualification = new CandidateQualificationDto();

                            if (hasContent(school.getSchoolName())) {
                                qualification.setInstitutionName(removeSpecialCharacterFromContent(school.getSchoolName()));
                            }

                            if (hasContent(school.getEducationLevel())) {
                                qualification.setDepartment(removeSpecialCharacterFromContent(school.getEducationLevel()));
                            }

                            qualification.setQualificationStartYear(school.getSchoolStartYear());
                            qualification.setQualificationEndYear(school.getSchoolEndYear());
                            qualification.setPercentage(school.getPercentage());

                            educationList.add(qualification);

                            qualification = null;
                        });
                    }


                    if (Objects.nonNull(candidate.getDiplomaEducation()) && !CollectionUtils.isEmpty(candidate.getDiplomaEducation())) {

                        candidate.getDiplomaEducation().forEach(school -> {
                            CandidateQualificationDto qualification = new CandidateQualificationDto();

                            if (hasContent(school.getDiplomaInstitutionName())) {
                                qualification.setInstitutionName(removeSpecialCharacterFromContent(school.getDiplomaInstitutionName()));
                            }

                            if (hasContent(school.getQualificationLevel())) {
                                qualification.setDepartment(removeSpecialCharacterFromContent(school.getQualificationLevel()));
                            }

                            qualification.setQualificationStartYear(school.getDiplomaStartYear());
                            qualification.setQualificationEndYear(school.getDiplomaEndYear());
                            qualification.setPercentage(school.getPercentage());

                            educationList.add(qualification);

                            qualification = null;
                        });
                    }

                    variables.put("education", educationList);


                }

                if (Objects.nonNull(candidate.getSoftSkills()) && !candidate.getSoftSkills().isEmpty()) {
                    variables.put("softSkills", removeSpecialCharacterFromContent(candidate.getSoftSkills()));
                }

                if (Objects.nonNull(candidate.getAchievements()) && !CollectionUtils.isEmpty(candidate.getAchievements())) {

                    List<CandidateAchievementsDto> achievementsList = new ArrayList<>();

                    candidate.getAchievements().forEach(achieve -> {
                        CandidateAchievementsDto achievements = new CandidateAchievementsDto();

                        if (hasContent(achieve.getAchievementsName())) {
                            achievements.setAchievementsName(removeSpecialCharacterFromContent(achieve.getAchievementsName()));

                        }
                        achievements.setAchievementsDate(achieve.getAchievementsDate());

                        achievementsList.add(achievements);
                        achievements = null;
                    });
                    variables.put("achievements", achievementsList);
                }

                if (Objects.nonNull(candidate.getCoreCompentencies()) && !candidate.getCoreCompentencies().isEmpty()) {
                    variables.put("competencies", removeSpecialCharacterFromContent(candidate.getCoreCompentencies()));
                }

                if (Objects.nonNull(candidate.getCollegeProject()) && !CollectionUtils.isEmpty(candidate.getCollegeProject())) {

                    List<CandidateCollegeProjectDto> candidateCollegeProjectList = new ArrayList<>();

                    candidate.getCollegeProject().forEach(project -> {
                        CandidateCollegeProjectDto collegeProject = new CandidateCollegeProjectDto();

                        if (hasContent(project.getCollegeProjectName())) {
                            collegeProject.setCollegeProjectName(removeSpecialCharacterFromContent(project.getCollegeProjectName()));
                        }

                        if (hasContent(project.getCollegeProjectSkills())) {
                            collegeProject.setCollegeProjectSkills(removeSpecialCharacterFromContent(project.getCollegeProjectSkills()));
                        }

                        if (hasContent(project.getCollegeProjectDescription())) {
                            collegeProject.setCollegeProjectDescription(removeSpecialCharacterFromContent(project.getCollegeProjectDescription()));
                        }
                        candidateCollegeProjectList.add(collegeProject);
                        collegeProject = null;
                    });
                    variables.put("collegeProject", candidateCollegeProjectList);
                }

                if (Objects.nonNull(candidate.getCareerObjective()) && !candidate.getCareerObjective().isEmpty()) {
                    variables.put("objective", removeSpecialCharacterFromContent(candidate.getCareerObjective()));
                }

                if (Objects.nonNull(candidate.getSummary()) && !candidate.getSummary().isEmpty()) {
                    variables.put("summary", removeSpecialCharacterFromContent(candidate.getSummary()));
                }

                // add photo to the resume

                imageLocation = candidateImageRepository.getImageLocationByCandidateId(candidate.getId());

                if (Objects.nonNull(imageLocation) && !imageLocation.isEmpty()) {

                    variables.put("profileImage", "data:image/png;base64,${base64Image}");
                }

                variables.put("calendarIcon", "${canlendarIcon}");
                variables.put("phoneIcon", "${phoneIcon}");
                variables.put("mailIcon", "${mailIcon}");


                if (additionalDetails) {
                    variables.put("addAdditionalDetails", true);

                } else {
                    variables.put("addAdditionalDetails", false);
                }

                if (Objects.nonNull(candidate.getTemplateName())) {
                    template = configuration.getTemplate(candidate.getTemplateName() + ".ftl");
                } else {
                    throw new MakeProfileException(CommonConstants.MP_0007);
                }


                resumeHtmlCode = FreeMarkerTemplateUtils.processTemplateIntoString(template, variables);

                // makeProfileOpenAiService.makeProfileAi(processTemplateIntoString);

                //commented Because preview the template in screen
//                resumeHtmlCode = checkResumePageCountService.getResumeHtmlCode(processTemplateIntoString, candidate,
//                        username, candidate.getTemplateName());

                if (Objects.isNull(resumeHtmlCode) || resumeHtmlCode.isEmpty()) {
                    throw new MakeProfileException(CommonConstants.MP_0007);
                }

                if (Objects.nonNull(imageLocation) && !imageLocation.isEmpty() && resumeHtmlCode.contains("${base64Image}")) {
                    String imagePath = "C:/make_profile/Image/" + candidate.getId() + "/" + imageLocation;
                    String base64Image = convertImageToBase64(imagePath);
                    resumeHtmlCode = resumeHtmlCode.replace("${base64Image}", base64Image);

                }

                if (resumeHtmlCode.contains("${canlendarIcon}")) {
                    resumeHtmlCode = resumeHtmlCode.replace("${canlendarIcon}", "data:image/png;base64," + convertImageToBase64(CommonConstants.CALENDARE_ICON_LOCATION));
                }

                if (resumeHtmlCode.contains("${phoneIcon}")) {
                    resumeHtmlCode = resumeHtmlCode.replace("${phoneIcon}", "data:image/png;base64," + convertImageToBase64(CommonConstants.PHONE_ICON_LOCATION));
                }

                if (resumeHtmlCode.contains("${mailIcon}")) {
                    resumeHtmlCode = resumeHtmlCode.replace("${mailIcon}", "data:image/png;base64," + convertImageToBase64(CommonConstants.MAIL_ICON_LOCATION));
                }


                generatePdfResponseDto.setResumeContent(resumeHtmlCode);
                generatePdfResponseDto.setName(candidate.getName());

            } else {
                throw new MakeProfileException(CommonConstants.MP_0007);
            }

        } catch (MakeProfileException e) {
            logger.error("Service :: generateResumeHtmlContent :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: generateResumeHtmlContent :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: generateResumeHtmlContent :: Exited");
        return generatePdfResponseDto;
    }

}
