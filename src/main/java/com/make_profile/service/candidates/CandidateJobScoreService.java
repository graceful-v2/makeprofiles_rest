package com.make_profile.service.candidates;

import java.util.List;

import com.make_profile.dto.candidates.JobScoreDto;

public interface CandidateJobScoreService {

	JobScoreDto checkCandidateJobScore(String jobId, String candidateid, String tenant,Long userId);

	List<JobScoreDto> getCheckedJobScore(Long candidateId);
}
