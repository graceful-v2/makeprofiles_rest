package com.make_profile.service.master;

import java.util.List;

import com.make_profile.dto.WrapperDto;
import com.make_profile.dto.master.CreditHistoryDto;
import com.make_profile.dto.master.CreditsDto;
import com.make_profile.dto.master.ResumeTemplateDto;

public interface CreditsService {

	WrapperDto<ResumeTemplateDto> getCredits(ResumeTemplateDto resumeTemplateDto, Long userId);

	boolean addCredits(CreditsDto creditsDto);

	boolean useCredit(ResumeTemplateDto resumeTemplateDto, Long userId);

	Long getAvailableCredits(Long userId);

	boolean updateNickName(ResumeTemplateDto resumeTemplateDto, Long userId);

	List<String> getNickNames(Long userId);

	CreditsDto getOverallCredits(Long userId);

	WrapperDto<CreditHistoryDto> getAllCredits(CreditHistoryDto creditHistoryDto, Long userId);

}
