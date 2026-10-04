package com.make_profile.service.resume;

import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.master.ResponcePdfDto;
import com.make_profile.dto.resume.GeneratePdfResponseDto;
import com.make_profile.exception.MakeProfileException;

public interface GeneratePdfService {

    GeneratePdfResponseDto generatingJobIdForPdf(CandidateDto candidate, String username, Long userId, boolean additionalDetails,String jobId) throws MakeProfileException;

    GeneratePdfResponseDto generatingPdfJobId(CandidateDto candidate, String username, Long userId, boolean additionalDetails,String jobId) throws MakeProfileException;

    ResponcePdfDto downloadAsBytes(String jobId);
}