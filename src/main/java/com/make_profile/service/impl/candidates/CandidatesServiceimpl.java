package com.make_profile.service.impl.candidates;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.make_profile.dto.candidates.*;
import com.make_profile.dto.master.ResumeTemplateDto;
import com.make_profile.dto.templates.TemplatePagesDto;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.service.candidates.FindResumePageCountService;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import io.micrometer.common.util.StringUtils;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.util.CollectionUtils;

import com.make_profile.entity.candidates.CandidateAdditionalDetailsEntity;
import com.make_profile.entity.candidates.CandidateEntity;
import com.make_profile.entity.candidates.CandidateImageEntity;
import com.make_profile.entity.history.candidates.CandidateHistoryEntity;
import com.make_profile.repository.candidates.CandidateAdditionalDetailsRepository;
import com.make_profile.repository.candidates.CandidateImageRepository;
import com.make_profile.repository.candidates.CandidatesRepository;
import com.make_profile.repository.common.EnvironmentRepository;
import com.make_profile.repository.history.candidates.CandidateHistoryRepository;
import com.make_profile.repository.templates.TemplateAppliedRepository;
import com.make_profile.repository.templates.UsedTemplateRepository;
import com.make_profile.repository.user.UserRepository;
import com.make_profile.service.candidates.CandidateService;
import com.make_profile.service.candidates.TemplateService;
import com.make_profile.utility.CommonConstants;
import com.make_profile.utility.CommonUtils;
import org.springframework.web.client.RestTemplate;

@Service
public class CandidatesServiceimpl implements CandidateService {

    private static final Logger logger = LoggerFactory.getLogger(CandidatesServiceimpl.class);

    @Autowired
    CandidatesRepository candidatesRepository;

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    UsedTemplateRepository usedTemplateRepository;

    @Autowired
    TemplateAppliedRepository templateAppliedRepository;

    @Autowired
    TemplateService templateService;

    @Autowired
    CandidateImageRepository candidateImageRepository;

    @Autowired
    CandidateHistoryRepository candidateHistoryRepository;

    @Autowired
    EnvironmentRepository environmentRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    CandidateAdditionalDetailsRepository candidateAdditionalDetailsRepository;

    @Autowired
    RestTemplate restTemplate;

    @Autowired
    private Configuration configuration;

    @Autowired
    FindResumePageCountService findResumePageCountService;


    @Override
    public CandidateDto createCandidate(CandidateDto candidateDto, String Username) {
        logger.debug("Service :: createCandidate :: Entered");

        CandidateDto candidateResponseDto = null;
        CandidateEntity candidateEntity = new CandidateEntity();
        CandidateEntity candidateByUserName = null;

        try {

            candidateByUserName = candidatesRepository.getCandidateByUserName(Username);

            if (Objects.nonNull(candidateByUserName)) {

                if (Objects.isNull(candidateDto.getMobileNumber())) {
                    candidateDto.setMobileNumber(candidateByUserName.getMobileNumber());
                }
                candidateEntity = modelMapper.map(candidateDto, CandidateEntity.class);
                candidateEntity.setId(candidateByUserName.getId());
                candidateEntity.setCreatedUserName(Username);
                candidateEntity.setModifiedDate(LocalDateTime.now());
                candidateEntity.setModifiedUser(candidateDto.getCreatedUser());
            } else {
                candidateEntity = modelMapper.map(candidateDto, CandidateEntity.class);
                candidateEntity.setCreatedUserName(Username);
                candidateEntity.setCreatedUser(candidateDto.getCreatedUser());
                candidateEntity.setCreatedDate(LocalDateTime.now());
                candidateEntity.setModifiedDate(LocalDateTime.now());
            }

            CandidateEntity ResponceCandidateEntity = candidatesRepository.save(candidateEntity);

            // save candidate in history
            saveCandidateInHistory(candidateDto, Username, ResponceCandidateEntity.getId());

            saveCandidateInHurecomv2(candidateDto);

            candidateResponseDto = modelMapper.map(ResponceCandidateEntity, CandidateDto.class);

            ResponceCandidateEntity = null;
            candidateEntity = null;
            candidateByUserName = null;

        } catch (Exception e) {
            logger.error("Service :: createCandidate :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: createCandidate :: Exited");
        return candidateResponseDto;
    }

    @Override
    public CandidateDto getCandidateById(String userName) {
        logger.debug("Service :: getCandidateById :: Entered");

        CandidateDto candidateResponseDto = null;
        CandidateEntity candidateEntity = null;
        try {
            candidateEntity = candidatesRepository.getCandidateByUserName(userName);
            if (Objects.nonNull(candidateEntity)) {
                candidateResponseDto = modelMapper.map(candidateEntity, CandidateDto.class);
            }
            candidateEntity = null;
        } catch (Exception e) {
            logger.error("Service :: getCandidateById :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getCandidateById :: Exited");
        return candidateResponseDto;
    }

    @Override
    public byte[] uploadCandidateImage(CandidateImageDto candidateImageDto) {
        logger.debug("Service :: uploadCandidateImage :: Entered");
        byte[] candidateImage = null;
        try {

            String environmentValueByKey = environmentRepository.getEnvironmentValueByKey(CommonConstants.IMAGE_LOCATION);

            CandidateImageEntity candidateImageEntity = candidateImageRepository.getImageByCandidateId(candidateImageDto.getCandidateId());

            if (Objects.nonNull(candidateImageEntity)) {
                Path targetLocation = Paths.get(candidateImageEntity.getFileLocation());
                CommonUtils.deleteFileFromServer(targetLocation);
            }

            Path targetLocation = Paths.get(environmentValueByKey).resolve(candidateImageDto.getCandidateId().toString());

            // copy the image to target location.
            String path = CommonUtils.moveImageFileToServer(candidateImageDto.getAttachment(), targetLocation);

            if (Objects.isNull(candidateImageEntity)) {
                candidateImageEntity = new CandidateImageEntity();
            }

            candidateImageEntity.setFileName(candidateImageDto.getAttachment().getOriginalFilename());
            candidateImageEntity.setFileLocation(path);
            candidateImageEntity.setCandidateId(candidateImageDto.getCandidateId());

            candidateImageRepository.save(candidateImageEntity);

            candidateImageEntity = null;

            candidateImage = getCandidateImage(candidateImageDto.getCandidateId());
        } catch (Exception e) {
            logger.error("Service :: uploadCandidateImage :: Exception :: " + e.getMessage());
            return null;
        }
        logger.debug("Service :: uploadCandidateImage :: Exited");
        return candidateImage;
    }

    @Override
    public byte[] getCandidateImage(Long candidateId) {
        logger.debug("Service :: getCandidateImage :: Entered");
        CandidateImageEntity imageByCandidateId = null;
        byte[] byteArray = null;
        try {
            imageByCandidateId = candidateImageRepository.getImageByCandidateId(candidateId);

            if (Objects.nonNull(imageByCandidateId)) {
                Path targetLocation = Paths.get(imageByCandidateId.getFileLocation());
                byteArray = CommonUtils.downloadFileFromServer(targetLocation);
            }

        } catch (Exception e) {
            logger.error("Service :: getCandidateImage :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getCandidateImage :: Exited");
        return byteArray;

    }

    public void saveCandidateInHistory(CandidateDto candidateDto, String Username, Long responseId) {
        logger.debug("Service :: saveCandidateInHistory :: Entered");

        CandidateHistoryEntity candidateHistoryEntity = new CandidateHistoryEntity();
        try {
            if (Objects.nonNull(candidateDto.getExperiences()) && !CollectionUtils.isEmpty(candidateDto.getExperiences())) {
                candidateDto.getExperiences().forEach(exp -> {
                    exp.setId(null);
                    if (Objects.nonNull(exp.getProjects()) && !CollectionUtils.isEmpty(exp.getProjects())) {
                        exp.getProjects().forEach(pro -> {
                            pro.setId(null);
                        });
                    }
                });
            }

            if (Objects.nonNull(candidateDto.getCollegeProject()) && !CollectionUtils.isEmpty(candidateDto.getCollegeProject())) {
                candidateDto.getCollegeProject().forEach(collegeProject -> {
                    collegeProject.setId(null);
                });
            }

            if (Objects.nonNull(candidateDto.getCertificates()) && !CollectionUtils.isEmpty(candidateDto.getCertificates())) {
                candidateDto.getCertificates().forEach(cer -> {
                    cer.setId(null);
                });
            }

            if (Objects.nonNull(candidateDto.getQualification()) && !CollectionUtils.isEmpty(candidateDto.getQualification())) {
                candidateDto.getQualification().forEach(qua -> {
                    qua.setId(null);
                });
            }

            if (Objects.nonNull(candidateDto.getAchievements()) && !CollectionUtils.isEmpty(candidateDto.getAchievements())) {
                candidateDto.getAchievements().forEach(ach -> {
                    ach.setId(null);
                });
            }

            // To save the candidate in history
            candidateHistoryEntity = modelMapper.map(candidateDto, CandidateHistoryEntity.class);

            candidateHistoryEntity.setCreatedUserName(Username);
            candidateHistoryEntity.setCreatedUser(candidateDto.getCreatedUser());
            candidateHistoryEntity.setCandidateId(responseId);
            candidateHistoryEntity.setCreatedDate(LocalDateTime.now());
            candidateHistoryEntity.setModifiedDate(LocalDateTime.now());
            candidateHistoryEntity.setModifiedUser(candidateDto.getCreatedUser());

            candidateHistoryEntity.setId(null);

            candidateHistoryRepository.save(candidateHistoryEntity);

        } catch (Exception e) {
            logger.error("Service :: saveCandidateInHistory :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: saveCandidateInHistory :: Exited");

    }

    public void saveCandidateInHurecomv2(CandidateDto candidateDto) {
        logger.debug("Service :: saveCandidateInHurecomv2 :: Entered");

        try {

            if (candidatesRepository.findCandidateByMobileNumber(candidateDto.getMobileNumber()) == 1) {

                candidatesRepository.UpdateCandidateInHurecomV2(candidateDto.getName(), candidateDto.getMobileNumber(), candidateDto.getSkills(), candidateDto.getEmail(), candidateDto.isFresher(), candidateDto.getGender());
            } else {

                String candidateQualification = null;
                if (Objects.nonNull(candidateDto.getQualification()) && !candidateDto.getQualification().isEmpty()) {
                    candidateQualification = candidateDto.getQualification().get(0).getDepartment() != null ? candidateDto.getQualification().get(0).getDepartment() : "NA";
                }

                candidatesRepository.saveCandidateInHurecomV2(candidateDto.getName(), candidateDto.getMobileNumber(), candidateDto.getSkills(), candidateDto.getEmail(), Optional.ofNullable(candidateDto.getGender()).orElse("Male"), Optional.ofNullable(candidateQualification).orElse("NA"), candidateDto.isFresher());

                candidateQualification = null;
            }

        } catch (Exception e) {
            logger.error("Service :: saveCandidateInHurecomv2 :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: saveCandidateInHurecomv2 :: Exited");
    }

    @Override
    public boolean saveAdditionalDetails(CandidateAdditionalDetailsDto candidateAdditionalDetailsDto) {
        logger.debug("Service :: saveAdditionalDetails :: Entered");

        boolean status = false;

        CandidateAdditionalDetailsEntity detailsEntity = null;
        CandidateAdditionalDetailsEntity additionalDetails = null;

        try {
            if (Objects.nonNull(candidateAdditionalDetailsDto)) {
                additionalDetails = candidateAdditionalDetailsRepository.getAdditionalDetailsByMobileNumber(candidateAdditionalDetailsDto.getMobileNumber());

                if (Objects.nonNull(additionalDetails)) {
                    detailsEntity = modelMapper.map(candidateAdditionalDetailsDto, CandidateAdditionalDetailsEntity.class);

                    detailsEntity.setId(additionalDetails.getId());

                    candidateAdditionalDetailsRepository.save(detailsEntity);

                    updateHurecomV2CandidateDetails(candidateAdditionalDetailsDto);
                } else {
                    detailsEntity = modelMapper.map(candidateAdditionalDetailsDto, CandidateAdditionalDetailsEntity.class);

                    candidateAdditionalDetailsRepository.save(detailsEntity);

                    updateHurecomV2CandidateDetails(candidateAdditionalDetailsDto);

                }
                status = true;
                additionalDetails = null;
                detailsEntity = null;
            }
        } catch (Exception e) {
            logger.error("Service :: saveAdditionalDetails :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: saveAdditionalDetails :: Exited");
        return status;
    }

    @Override
    public CandidateAdditionalDetailsDto getCandidateDetails(String mobile) {
        logger.debug("Service :: getCandidateDetails :: Entered");

        CandidateAdditionalDetailsEntity additionalDetails = null;
        CandidateAdditionalDetailsDto candidateAdditionalDetailsDto = null;
        try {
            additionalDetails = candidateAdditionalDetailsRepository.getAdditionalDetailsByMobileNumber(mobile);
            if (Objects.nonNull(additionalDetails)) {
                candidateAdditionalDetailsDto = modelMapper.map(additionalDetails, CandidateAdditionalDetailsDto.class);
            }

            additionalDetails = null;
        } catch (Exception e) {
            logger.error("Service :: getCandidateDetails :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getCandidateDetails :: Exited");
        return candidateAdditionalDetailsDto;
    }


    public void updateHurecomV2CandidateDetails(CandidateAdditionalDetailsDto candidateAdditionalDetailsDto) {
        logger.debug("Service :: updateHurecomV2CandidateDetails :: Entered");

        try {

            String mobileNumberById = candidatesRepository.getMobileNumberById(candidateAdditionalDetailsDto.getCandidateId());

            candidatesRepository.UpdateCandidateProfessionalDetailsInHurecomV2(

                    candidateAdditionalDetailsDto.getPreferredLocation() != null ? candidateAdditionalDetailsDto.getPreferredLocation() : "NA", candidateAdditionalDetailsDto.getRelevantExperience() != null ? candidateAdditionalDetailsDto.getRelevantExperience() : 0, candidateAdditionalDetailsDto.getTotalWorkExperience() != null ? candidateAdditionalDetailsDto.getTotalWorkExperience() : 0, candidateAdditionalDetailsDto.getCurrentCostToCompany() != null ? candidateAdditionalDetailsDto.getCurrentCostToCompany() : 0, candidateAdditionalDetailsDto.getExpectedCostToCompany() != null ? candidateAdditionalDetailsDto.getExpectedCostToCompany() : 0, candidateAdditionalDetailsDto.getCompanyName() != null ? candidateAdditionalDetailsDto.getCompanyName() : "NA", mobileNumberById, candidateAdditionalDetailsDto.getQualification() != null ? candidateAdditionalDetailsDto.getQualification() : "NA");

            mobileNumberById = null;

        } catch (Exception e) {
            logger.error("Service :: updateHurecomV2CandidateDetails :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: updateHurecomV2CandidateDetails :: Exited");

    }

    @Override
    public boolean mobileExists(String mobileNumber) {
        logger.debug("Service :: mobileExists :: Entered");

        try {
            logger.debug("Service :: mobileExists :: Exited");
            if (userRepository.getUserByMobileNumber(mobileNumber) == 0) {
                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
            logger.error("Service :: mobileExists :: Exception :: " + e.getMessage());
            return true;
        }
    }

    @Override
    public boolean checkCandidateExistDetails(CandidateDto candidateDto, String username) {
        logger.debug("Service :: checkCandidateExistDetails :: Entered");

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

            if (Objects.isNull(candidateDto.getSummary()) || Objects.isNull(candidateDto.getCareerObjective()) || candidateDto.getSummary().isEmpty() || candidateDto.getCareerObjective().isEmpty()) {
                status = false;
            }
            candidateEntity = null;
            existingCandidate = null;

        } catch (Exception e) {
            logger.error("Service :: checkCandidateExistDetails :: Exception :: " + e.getMessage());
        }
        return status;
    }


    @Override
    public byte[] candidateResumeByteArray(CandidateDto candidate, boolean additionalDetails) {
        logger.debug("Service :: candidateResumeByteArray :: Entered");

        Map<String, Object> variables = new HashMap<>();
        Template template = null;
        String imageLocation = null;
        String resumeHtmlCode = null;
        byte[] pdfBytes = null;
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

//                if (Objects.nonNull(candidate.getNationality()) && !candidate.getNationality().isEmpty()) {
//
//                    int firstIndex = candidate.getNationality().indexOf("(");
//                    int lastIndex = candidate.getNationality().indexOf(")");
//                    variables.put("nationality", candidate.getNationality().substring(firstIndex+1,lastIndex));
//                }

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


                if (Objects.nonNull(candidate.getStrengths()) && !candidate.getStrengths().isEmpty()) {
                    variables.put("strengths", removeSpecialCharacterFromContent(candidate.getStrengths()));
                }

                if (Objects.nonNull(candidate.getExtraCurricularActivities()) && !candidate.getExtraCurricularActivities().isEmpty()) {
                    variables.put("extraCurricularActivities", removeSpecialCharacterFromContent(candidate.getExtraCurricularActivities()));
                }

                if (Objects.nonNull(candidate.getHobbies()) && !candidate.getHobbies().isEmpty()) {
                    variables.put("hobbies", removeSpecialCharacterFromContent(candidate.getHobbies()));
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

                            qualification.setQualificationStartYear(Optional.ofNullable(school.getSchoolStartYear()).orElse(""));
                            qualification.setQualificationEndYear(Optional.ofNullable(school.getSchoolEndYear()).orElse(""));
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

                String response = findResumePageCountService.findResumePageCounts(resumeHtmlCode);

                if (Objects.nonNull(response) && StringUtils.isNotBlank(response)) {
                    pdfBytes = convertHtmlToPdf(response);
                } else {
                    pdfBytes = convertHtmlToPdf(resumeHtmlCode);
                }

                response = null;

            } else {
                throw new MakeProfileException(CommonConstants.MP_0007);
            }

        } catch (Exception e) {
            logger.error("Service :: candidateResumeByteArray :: Exception :: " + e.getMessage());
            return new byte[0];
        }
        logger.debug("Service :: candidateResumeByteArray :: Exited");
        return pdfBytes;


    }


    public byte[] convertHtmlToPdf(String html) throws Exception {
        logger.debug("Service :: convertHtmlToPdf :: Entered");

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {

            PdfRendererBuilder builder = new PdfRendererBuilder();
            builder.useDefaultPageSize(210, 297, PdfRendererBuilder.PageSizeUnits.MM);
            builder.withHtmlContent(html, new File(".").toURI().toString());
            builder.toStream(baos);
            builder.useFastMode();
            builder.run();

            byte[] pdfBytes = baos.toByteArray();
            logger.debug("Service :: convertHtmlToPdf :: Exited");
            return pdfBytes;
        } catch (Exception e) {
            logger.error("Service :: convertHtmlToPdf :: Exception :: " + e.getMessage());
            return null;
        }
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
    public void removeCandidateImage(Long candidateId) {
        logger.debug("Service :: removeCandidateImage :: Entered");
        CandidateImageEntity imageByCandidateId = null;

        try {
            imageByCandidateId = candidateImageRepository.getImageByCandidateId(candidateId);

            if (Objects.nonNull(imageByCandidateId)) {
                Path targetLocation = Paths.get(imageByCandidateId.getFileLocation());
                CommonUtils.deleteFileFromServer(targetLocation);
            }

            candidateImageRepository.deleteById(imageByCandidateId.getId());


        } catch (Exception e) {
            logger.error("Service :: removeCandidateImage :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: removeCandidateImage :: Exited");
    }
}
