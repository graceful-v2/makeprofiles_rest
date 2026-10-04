package com.make_profile.service.openai;

import java.util.List;

import com.make_profile.dto.candidates.CandidateDto;

public interface MakeProfileOpenAiService {

	CandidateDto makeProfileAi(String content);

	CandidateDto getSummaryFromAi(String Content, String username, String templateName,String jobFor);

	List<String> validateAutoFillContent(String Content, boolean IsActiveUser);

}
