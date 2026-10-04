package com.make_profile.service.candidates;

 import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.exception.MakeProfileException;

public interface CheckResumePageCountService {

	String getResumeHtmlCode(String resume, CandidateDto candidateId, String username, String templateName) throws MakeProfileException;

}
