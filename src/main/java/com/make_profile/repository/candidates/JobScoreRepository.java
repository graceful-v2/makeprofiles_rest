package com.make_profile.repository.candidates;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_profile.entity.candidates.JobScoreEntity;

import jakarta.transaction.Transactional;

@Repository
@Transactional
public interface JobScoreRepository extends JpaRepository<JobScoreEntity, Long> {

	@Query(value = "select * from job_score where candidate_id = :candidateId ", nativeQuery = true)
	List<JobScoreEntity> getScoreByCandidateId(@Param("candidateId") Long candidateId);

}
