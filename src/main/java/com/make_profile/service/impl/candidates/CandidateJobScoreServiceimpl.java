package com.make_profile.service.impl.candidates;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.make_profile.dto.candidates.JobScoreDto;
import com.make_profile.dto.master.ResumeTemplateDto;
import com.make_profile.dto.openai.ChatCompleitonResponse;
import com.make_profile.dto.openai.ChatCompletionRequest;
import com.make_profile.entity.candidates.CandidateEntity;
import com.make_profile.entity.candidates.JobScoreEntity;
import com.make_profile.repository.candidates.CandidatesRepository;
import com.make_profile.repository.candidates.JobScoreRepository;
import com.make_profile.service.candidates.CandidateJobScoreService;
import com.make_profile.service.master.CreditsService;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Service
public class CandidateJobScoreServiceimpl implements CandidateJobScoreService {

	private static final Logger logger = LoggerFactory.getLogger(CandidateJobScoreServiceimpl.class);

	@PersistenceContext
	EntityManager entityManager;

	@Autowired
	RestTemplate restTemplate;

	@Autowired
	JobScoreRepository jobScoreRepository;

	@Autowired
	ModelMapper modelMapper;

	@Autowired
	CandidatesRepository candidatesRepository;

	@Autowired
	CreditsService creditsService;

	@Override
	public JobScoreDto checkCandidateJobScore(String jobId, String candidateId, String tenant,Long userId) {
		logger.debug("Service :: checkCandidateJobScore :: Entered");

		JobScoreDto jobScoreDto = null;
		CandidateEntity candidateEntity = null;
		String resumeContent = new String();
		String content = new String();
		try {

			candidateEntity = candidatesRepository.findById(Long.valueOf(candidateId)).get();

			if (Objects.nonNull(candidateEntity)) {

				resumeContent = convertcandidateEntityIntoString(candidateEntity);

				content = """
						   save the above job description content , i will give you the resume content below, can you give me the response as json format like this  {  Score:70% ,  Related: true }

						""";

				String jobDescription = getJobDescription(tenant, jobId);

				jobDescription = jobDescription.replaceAll("<p>|</p>|<strong>|</strong>", "");
				StringBuilder contentByPurpose = new StringBuilder(
						jobDescription + " \r\n " + " \r\n " + content + " \r\n ");

				ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini",
						contentByPurpose.toString() + resumeContent);

				ChatCompleitonResponse response = restTemplate.postForObject(
						"https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

				StringBuilder responseContent = new StringBuilder(
						response.getChoices().get(0).getMessage().getContent());

				String jsonString = responseContent.substring(responseContent.toString().indexOf('{'),
						responseContent.toString().lastIndexOf('}'));

				JobScoreEntity convertIntoJsonFormat = convertIntoJsonFormat(jsonString, candidateId, jobId, tenant);

				jobScoreDto = modelMapper.map(convertIntoJsonFormat, JobScoreDto.class);

				resumeContent = null;
				content = null;
				jobDescription = null;

				if (Objects.nonNull(jobScoreDto)) {
					
					ResumeTemplateDto resumeTemplateDto = new ResumeTemplateDto();
					resumeTemplateDto.setTemplateName("Applied Jobs");
					creditsService.useCredit(resumeTemplateDto, userId);
				}

			}

		} catch (Exception e) {
			logger.error("Service :: checkCandidateJobScore :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: checkCandidateJobScore :: Exited");
		return jobScoreDto;

	}

	public String getJobDescription(String tenant, String jobId) {
		logger.debug("Service :: getJobDescription :: Entered");
		String description = null;
		try {
			String jobDescriptionQuery = "select job_description from hurecom_" + tenant
					+ ".requirements where job_id = '" + jobId + "'";

			Query query = entityManager.createNativeQuery(jobDescriptionQuery);
			description = (String) query.getSingleResult();

			jobDescriptionQuery = null;
		} catch (Exception e) {
			logger.error("Service :: getJobDescription :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: getJobDescription :: Exited");
		return description;

	}

	public JobScoreEntity convertIntoJsonFormat(String jsonString, String candidateId, String jobId, String tenant) {
		logger.debug("Service :: convertIntoJsonFormat :: Entered");

		JsonObject jsonObject = null;
		JobScoreEntity jobScoreEntity = new JobScoreEntity();
		JobScoreEntity jobScore = null;
		try {
			JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
			if (jsonElement.isJsonObject()) {
				jsonObject = jsonElement.getAsJsonObject();

				jobScoreEntity.setScore(jsonObject.get("Score").getAsString());
				jobScoreEntity
						.setRelated(jsonObject.get("Related").getAsString().equalsIgnoreCase("true") ? true : false);
				jobScoreEntity.setCandidateId(Long.valueOf(candidateId));
				jobScoreEntity.setJobId(jobId);
				jobScoreEntity.setTenant(tenant);

				jobScore = jobScoreRepository.save(jobScoreEntity);
			}
			jobScoreEntity = null;
			jsonObject = null;
		} catch (Exception e) {
			logger.error("Service :: convertIntoJsonFormat :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: convertIntoJsonFormat :: Exited");
		return jobScore;
	}

	public String convertcandidateEntityIntoString(CandidateEntity candidateEntity) {
		logger.debug("Service :: convertcandidateEntityIntoString :: Extered");

		StringBuilder dtoString = new StringBuilder("candidateEntity: {");

		try {

			dtoString.append("id=").append(candidateEntity.getId()).append(", ");
			dtoString.append("name=").append(candidateEntity.getName()).append(", ");
			dtoString.append("mobileNumber=").append(candidateEntity.getMobileNumber()).append(", ");
			dtoString.append("email=").append(candidateEntity.getEmail()).append(", ");
			dtoString.append("nationality=").append(candidateEntity.getNationality()).append(", ");
			dtoString.append("gender=").append(candidateEntity.getGender()).append(", ");
			dtoString.append("languagesKnown=").append(candidateEntity.getLanguagesKnown()).append(", ");
			dtoString.append("isFresher=").append(candidateEntity.isFresher()).append(", ");
			dtoString.append("skills=").append(candidateEntity.getSkills()).append(", ");
			dtoString.append("linkedIn=").append(candidateEntity.getLinkedIn()).append(", ");
			dtoString.append("dob=").append(candidateEntity.getDob()).append(", ");
			dtoString.append("address=").append(candidateEntity.getAddress()).append(", ");
			dtoString.append("maritalStatus=").append(candidateEntity.getMaritalStatus()).append(", ");
			dtoString.append("experiences=").append(candidateEntity.getExperiences()).append(", ");
			dtoString.append("qualification=").append(candidateEntity.getQualification()).append(", ");
			dtoString.append("certificates=").append(candidateEntity.getCertificates()).append(", ");
			dtoString.append("achievements=").append(candidateEntity.getAchievements()).append(", ");
			dtoString.append("softSkills=").append(candidateEntity.getSoftSkills()).append(", ");
			dtoString.append("coreCompentencies=").append(candidateEntity.getCoreCompentencies()).append(", ");
			dtoString.append("collegeProject=").append(candidateEntity.getCollegeProject());

			dtoString.append("}");
		}

		catch (Exception e) {
			logger.error("Service :: convertcandidateEntityIntoString :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: convertcandidateEntityIntoString :: Exited");
		return dtoString.toString();
	}

	@Override
	public List<JobScoreDto> getCheckedJobScore(Long candidateId) {
		logger.debug("Service :: getCheckedJobScore :: Entered");

		List<JobScoreDto> checkScore = new ArrayList<>();

		try {
			List<JobScoreEntity> scoreByCandidateId = jobScoreRepository.getScoreByCandidateId(candidateId);

			if (Objects.nonNull(scoreByCandidateId) && !CollectionUtils.isEmpty(scoreByCandidateId)) {

				scoreByCandidateId.forEach(scrore -> {
					JobScoreDto scoreDto = new JobScoreDto();
					scoreDto = modelMapper.map(scrore, JobScoreDto.class);
					checkScore.add(scoreDto);
					scoreDto = null;
				});
			}

			scoreByCandidateId = null;

		} catch (Exception e) {
			logger.error("Service :: getCheckedJobScore :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: getCheckedJobScore :: Exited");
		return checkScore;

	}

}
