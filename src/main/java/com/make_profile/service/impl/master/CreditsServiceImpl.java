package com.make_profile.service.impl.master;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.make_profile.dto.WrapperDto;
import com.make_profile.dto.master.CreditHistoryDto;
import com.make_profile.dto.master.CreditsDto;
import com.make_profile.dto.master.ResumeTemplateDto;
import com.make_profile.entity.master.CreditHistoryEntity;
import com.make_profile.entity.master.CreditsEntity;
import com.make_profile.entity.master.ResumeTemplatesEntity;
import com.make_profile.repository.master.CreditHistoryRepository;
import com.make_profile.repository.master.CreditsRepository;
import com.make_profile.repository.master.ResumeTemplateRepository;
import com.make_profile.service.master.CreditsService;

@Service
public class CreditsServiceImpl implements CreditsService {

	private static final Logger logger = LoggerFactory.getLogger(CreditsServiceImpl.class);

	@Autowired
	CreditsRepository creditsRepository;

	@Autowired
	ModelMapper modelMapper;

	@Autowired
	CreditHistoryRepository creditHistoryRepository;

	@Autowired
	ResumeTemplateRepository resumeTemplateRepository;

	// TODO candidate comes from login
	@Override
	public WrapperDto<ResumeTemplateDto> getCredits(ResumeTemplateDto resumeTemplateDto, Long userId) {
		logger.debug("Service :: getCredits :: Entered");

		WrapperDto<ResumeTemplateDto> wrapperDto = new WrapperDto<ResumeTemplateDto>();

		List<ResumeTemplateDto> resumeTemplateDtoList = new ArrayList<>();
		List<ResumeTemplatesEntity> resumeTemplatesEntityList = new ArrayList<>();
		try {
			int multiplyExact = Math.multiplyExact((resumeTemplateDto.getPage() - 1), resumeTemplateDto.getLimit());

			resumeTemplatesEntityList = resumeTemplateRepository.findTemplateByCreditId(userId, multiplyExact,
					resumeTemplateDto.getLimit());

			if (Objects.nonNull(resumeTemplatesEntityList) && !CollectionUtils.isEmpty(resumeTemplatesEntityList)) {

				resumeTemplatesEntityList.forEach(template -> {
					resumeTemplateDtoList.add(modelMapper.map(template, ResumeTemplateDto.class));
				});
			}
			resumeTemplatesEntityList = null;

			wrapperDto.setResults(resumeTemplateDtoList);

			wrapperDto.setTotalRecords(
					Optional.ofNullable(resumeTemplateRepository.getCoutnByCreditId(userId)).orElse(0L));

		} catch (Exception e) {
			logger.error("Service :: getCredits :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: getCredits :: Exited");
		return wrapperDto;
	}

	// TODO candidate comes from login
	@Override
	public boolean addCredits(CreditsDto creditsDto) {

		logger.debug("Service :: addCredits :: Entered");

		boolean status = false;
		CreditsEntity findCreditesByUserId = new CreditsEntity();
		CreditsEntity creditEntity = null;
		try {
			findCreditesByUserId = creditsRepository.findCreditsByUserId(creditsDto.getUserId());
			if (Objects.nonNull(findCreditesByUserId)) {
				findCreditesByUserId.setUserId(creditsDto.getUserId());

				findCreditesByUserId
						.setCreditAvailable(Optional.ofNullable(findCreditesByUserId.getCreditAvailable()).orElse(0.0)
								+ Double.valueOf(creditsDto.getCreditAvailable()));
				findCreditesByUserId.setId(findCreditesByUserId.getId());
				findCreditesByUserId.setPaymentDate(LocalDate.now());

				creditEntity = creditsRepository.save(findCreditesByUserId);

				findCreditesByUserId = null;
				status = true;
			} else {
				CreditsEntity newCredits = new CreditsEntity();

				newCredits.setUserId(creditsDto.getUserId());
				newCredits.setCreditAvailable(Double.valueOf(creditsDto.getCreditAvailable()));
				newCredits.setPaymentDate(LocalDate.now());

				creditEntity = creditsRepository.save(newCredits);

				newCredits = null;
				status = true;
			}

			creditEntity = null;

		} catch (Exception e) {
			logger.error("Service :: addCredits :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: addCredits :: Exited");
		return status;
	}

	// TODO candidate comes from login
	@Override
	public boolean useCredit(ResumeTemplateDto resumeTemplateDto, Long userId) {
		logger.debug("Service :: useCredit :: Entered");

		CreditsEntity findCreditesByUserId = null;
		List<ResumeTemplatesEntity> resumeTemplate = new ArrayList<>();
		ResumeTemplatesEntity resumeTemplatesEntity = new ResumeTemplatesEntity();
		boolean status = false;
		try {
			findCreditesByUserId = creditsRepository.findCreditsByUserId(userId);

			if (Objects.nonNull(findCreditesByUserId) && findCreditesByUserId.getCreditAvailable() >= 1.0) {

				findCreditesByUserId.setUserId(userId);
				findCreditesByUserId.setCreditAvailable(findCreditesByUserId.getCreditAvailable() - Double.valueOf(1));
				findCreditesByUserId.setCreditUsed(
						Optional.ofNullable(findCreditesByUserId.getCreditUsed()).orElse(0.0) + Double.valueOf(1));
				findCreditesByUserId.setId(findCreditesByUserId.getId());

				// Save Template Name
				resumeTemplatesEntity.setCreatedDate(LocalDateTime.now());
				resumeTemplatesEntity.setNickName("Template " + findCreditesByUserId.getTemplates().size());
				resumeTemplatesEntity.setTemplateName(resumeTemplateDto.getTemplateName());
				resumeTemplate.add(resumeTemplatesEntity);

				findCreditesByUserId.getTemplates().add(resumeTemplatesEntity);

				creditsRepository.save(findCreditesByUserId);

				saveCreditHistory(resumeTemplateDto, "Template " + findCreditesByUserId.getTemplates().size(), userId);

				status = true;
			}

			resumeTemplate = null;
			findCreditesByUserId = null;
			resumeTemplatesEntity = null;
		} catch (Exception e) {
			logger.error("Service :: useCredit :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: useCredit :: Exited");
		return status;
	}

	@Override
	public Long getAvailableCredits(Long userId) {
		logger.debug("Service :: getAvailableCredits :: Entered");

		Double availableCredits = null;
		Long available = null;
		try {
			availableCredits = creditsRepository.getAvailableCreditsByNickName(userId);

			if (Objects.nonNull(availableCredits)) {
				available = Math.round(availableCredits);
			} else {
				available = 0L;
			}
		} catch (Exception e) {
			logger.error("Service :: getAvailableCredits :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: getAvailableCredits :: Exited");
		return available;
	}

	public void saveCreditHistory(ResumeTemplateDto resumeTemplateDto, String nickName, Long userId) {
		logger.debug("Service :: saveCreditHistory :: Entered");

		try {
			CreditHistoryEntity creditHistoryEntity = new CreditHistoryEntity();

			creditHistoryEntity.setUserId(userId);
			creditHistoryEntity.setTemplateName(resumeTemplateDto.getTemplateName());
			creditHistoryEntity.setUsedCredit(1.0);
			creditHistoryEntity.setCreatedDate(LocalDateTime.now());
			creditHistoryEntity.setNickName(nickName);
			creditHistoryEntity.setUsedType(
					resumeTemplateDto.getTemplateName().equals("Applied Jobs") ? "Apply job" : "Creating Resume");

			creditHistoryRepository.save(creditHistoryEntity);

			creditHistoryEntity = null;
		} catch (Exception e) {
			logger.error("Service :: saveCreditHistory :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: saveCreditHistory :: Exited");
	}

	@Override
	public boolean updateNickName(ResumeTemplateDto resumeTemplateDto, Long userId) {
		logger.debug("Service :: saveNickName :: Entered");

		boolean status = false;

		try {
			resumeTemplateRepository.updateNickName(resumeTemplateDto.getId(), resumeTemplateDto.getNickName());

			status = true;

		} catch (Exception e) {
			logger.error("Service :: saveNickName :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: saveNickName :: Exited");
		return status;
	}

	@Override
	public List<String> getNickNames(Long userId) {
		logger.debug("Service :: getNickNames :: Entered");
		try {
			logger.debug("Service :: getNickNames :: Exited");
			return creditsRepository.getTemplateNameByUserId(userId).get();
		} catch (Exception e) {
			logger.error("Service :: getNickNames :: Exception :: " + e.getMessage());
			return null;
		}

	}

	@Override
	public CreditsDto getOverallCredits(Long userId) {
		logger.debug("Service :: getOverallCredits :: Entered");

		CreditsDto creditsDto = new CreditsDto();
		try {
			creditsDto.setCreditAvailable(creditsRepository.getOverallCredit(userId));

		} catch (Exception e) {
			logger.error("Service :: getOverallCredits :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: getOverallCredits :: Exited");
		return creditsDto;
	}

	@Override
	public WrapperDto<CreditHistoryDto> getAllCredits(CreditHistoryDto creditHistoryDto, Long userId) {
		logger.debug("Service :: getAllCredits :: Entered");

		WrapperDto<CreditHistoryDto> wrapperDto = new WrapperDto<CreditHistoryDto>();

		List<CreditHistoryDto> creditHistoryDtoList = new ArrayList<>();
		List<CreditHistoryEntity> creditHistoryEntityList = new ArrayList<>();
		try {
			int multiplyExact = Math.multiplyExact((creditHistoryDto.getPage() - 1), creditHistoryDto.getLimit());
			creditHistoryEntityList = creditHistoryRepository.findByUserId(userId, multiplyExact,
					creditHistoryDto.getLimit());

			if (Objects.nonNull(creditHistoryEntityList) && !CollectionUtils.isEmpty(creditHistoryEntityList)) {
				creditHistoryEntityList.forEach(entity -> {
					creditHistoryDtoList.add(modelMapper.map(entity, CreditHistoryDto.class));
				});
			}
			creditHistoryEntityList = null;

			wrapperDto.setResults(creditHistoryDtoList);

			wrapperDto
					.setTotalRecords(Optional.ofNullable(creditHistoryRepository.getCoutnByUserId(userId)).orElse(0L));

		} catch (Exception e) {
			logger.error("Service :: getAllCredits :: Exception :: " + e.getMessage());
		}
		logger.debug("Service :: getAllCredits :: Exited");
		return wrapperDto;
	}

}
