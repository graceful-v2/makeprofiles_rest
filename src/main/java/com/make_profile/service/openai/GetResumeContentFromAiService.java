package com.make_profile.service.openai;

import com.make_profile.dto.candidates.AiResponseDto;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.candidates.ResumeContentDto;
import com.make_profile.dto.candidates.SummaryResponseDto;
import com.make_profile.dto.master.AiResponsibilityDto;

public interface GetResumeContentFromAiService {

    ResumeContentDto getResumeContent(String name);

    SummaryResponseDto getSummaryContent();

    SummaryResponseDto getAiContent(String content, String key, String operation);

    SummaryResponseDto getProjectContentFromAi(String content, String operation);

    SummaryResponseDto getExperienceContentFromAi(String content, String operation);

    AiResponseDto getSkillsFromAi(CandidateDto  candidateDto);

    AiResponseDto  getSuggestedSkillsFromOpenAi(String skills);

    AiResponsibilityDto getSuggestedResponsibilitiesFromOpenAi(AiResponsibilityDto aiResponseDto);




}
