package com.make_profile.service.openai;

import org.springframework.web.multipart.MultipartFile;

import com.make_profile.dto.candidates.CandidateDto;

import java.util.List;

public interface ResumeDetailsAiService {

	CandidateDto getUploadResumeDetialsFromAi(MultipartFile resume, String userName);

	CandidateDto getResumeDetailsFromOpenAiForCandidate(MultipartFile resume);

	List<String> validateAutoFillContentFromLogin(MultipartFile resume);


}
