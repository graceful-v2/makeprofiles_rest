package com.make_profile.service.impl.candidates;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import org.springframework.util.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.entity.common.FieldCheckerDto;
import com.make_profile.entity.templates.TemplateAppliedEntity;
import com.make_profile.entity.templates.UsedTemplateEntity;
import com.make_profile.repository.templates.TemplateAppliedRepository;
import com.make_profile.repository.templates.TemplateRepository;
import com.make_profile.service.candidates.TemplateService;

@Service
public class TemplateServiceImpl implements TemplateService {

    private static final Logger logger = LoggerFactory.getLogger(TemplateServiceImpl.class);

    @Autowired
    TemplateRepository templateRepository;

    @Autowired
    TemplateAppliedRepository templateAppliedRepository;

    @Override
    public void saveCandidateDataInTemplate(UsedTemplateEntity usedTemplateEntity, CandidateDto candidateDto) {
        logger.debug("Service :: saveCandidateDataInTemplate :: Entered");

        try {

            List<TemplateAppliedEntity> templateAppliedEnity = new ArrayList<>();

            if (Objects.nonNull(candidateDto.getExperiences())) {

            }

            if (Objects.nonNull(candidateDto.getQualification())) {

            }

            if (Objects.nonNull(candidateDto.getAchievements())) {
            }

            if (Objects.nonNull(candidateDto.getCertificates())) {
            }

            if (Objects.nonNull(candidateDto.getCollegeProject()) && !CollectionUtils.isEmpty(candidateDto.getCollegeProject())) {

            }
        } catch (Exception e) {
            logger.error("Service :: saveCandidateDataInTemplate :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: saveCandidateDataInTemplate :: Exited");
    }

    @Override
    public FieldCheckerDto checkResumeTemplateFields(CandidateDto candidateDto) {


//		Long minSectionCount = 0L;
//		Long count = 0L;
//		Long remaningCount = 0L;

//		FieldCheckerDto fieldChecker = new FieldCheckerDto();
//		List<String> fields = new ArrayList<>();


			/*templateByName = templateRepository.getTemplateByName(candidateDto.getTemplateName());

			if (Objects.nonNull(templateByName)) {
				minSectionCount = templateByName.getMinSectionCount();

				if (Objects.nonNull(candidateDto.getQualification())
						&& !CollectionUtils.isEmpty(candidateDto.getQualification())) {
					count++;
				}
				if (Objects.nonNull(candidateDto.getSkills()) && !candidateDto.getSkills().isEmpty()) {
					count++;
				}
				if (Objects.nonNull(candidateDto.getExperiences())
						&& !CollectionUtils.isEmpty(candidateDto.getExperiences())) {
					count++;
				}
				if ((Objects.nonNull(candidateDto.getSoftSkills()) && !candidateDto.getSoftSkills().isEmpty())
						|| (Objects.nonNull(candidateDto.getCoreCompentencies())
								&& !candidateDto.getCoreCompentencies().isEmpty())) {
					count++;
				}

				if (Objects.nonNull(candidateDto.getCertificates())
						&& !CollectionUtils.isEmpty(candidateDto.getCertificates())) {
					count++;
				}
				if (Objects.nonNull(candidateDto.getAchievements())
						&& !CollectionUtils.isEmpty(candidateDto.getAchievements())) {
					count++;
				}

				remaningCount = minSectionCount - count;

				if (remaningCount > 0) {
					fieldChecker.setCount(remaningCount);
				}

				// for getting the Mandatory Sections
				List<String> section = Arrays.asList(templateByName.getMandatorySectionName().split(","));

				if (section.contains("experience")) {
					if ((Objects.isNull(candidateDto.getExperiences())
							|| CollectionUtils.isEmpty(candidateDto.getExperiences()))
							&& candidateDto.isFresher() == false) {
						fields.add("experience");
					}
				}

				if (section.contains("qualification")) {
					if (Objects.isNull(candidateDto.getQualification())
							|| CollectionUtils.isEmpty(candidateDto.getQualification())) {
						fields.add("qualification");
					}
				}
				if (section.contains("skills")) {
					if (Objects.isNull(candidateDto.getSkills()) || candidateDto.getSkills().isEmpty()) {
						fields.add("skills");
					}
				}
				if (section.contains("achievements")) {
					if (Objects.isNull(candidateDto.getAchievements())
							|| CollectionUtils.isEmpty(candidateDto.getAchievements())) {
						fields.add("achievements");
					}
				}

				if (section.contains("course")) {
					if (Objects.isNull(candidateDto.getCertificates())
							|| CollectionUtils.isEmpty(candidateDto.getCertificates())) {
						fields.add("course");
					}
				}

				if (section.contains("extraSkills")) {
					if ((Objects.isNull(candidateDto.getSoftSkills()) || candidateDto.getSoftSkills().isEmpty())
							|| (Objects.isNull(candidateDto.getCoreCompentencies())
									|| candidateDto.getCoreCompentencies().isEmpty())) {
						fields.add("extraSkills");
					}
				}

				fieldChecker.setFieldName(fields);
*/
//				fields = null;
//				minSectionCount = null;
//				count = null;
        return null;
    }


}
