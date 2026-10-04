package com.make_profile.service.candidates;

import com.make_profile.dto.candidates.CandidateAdditionalDetailsDto;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.candidates.CandidateImageDto;

public interface CandidateService {

	CandidateDto createCandidate(CandidateDto candidateDto, String username);

	CandidateDto getCandidateById(String id);

	byte[] uploadCandidateImage(CandidateImageDto candidateImageDto);

	byte[] getCandidateImage(Long candidateId);

	boolean saveAdditionalDetails(CandidateAdditionalDetailsDto candidateAdditionalDetailsDto);

	CandidateAdditionalDetailsDto getCandidateDetails(String mobile);

	boolean mobileExists(String mobileNumber);

	boolean checkCandidateExistDetails(CandidateDto candidateDto, String username);

	byte[] candidateResumeByteArray(CandidateDto candidateDto,boolean additionalDetails);

	void removeCandidateImage(Long candidateId);


}
