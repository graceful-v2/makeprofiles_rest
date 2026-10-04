package com.make_profile.repository.master;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_profile.entity.master.CreditsEntity;

import jakarta.transaction.Transactional;

@Repository
@Transactional
public interface CreditsRepository extends JpaRepository<CreditsEntity, Long> {

	@Query(value = "select * from credits where candidate_id = :candidateId", nativeQuery = true)
	CreditsEntity findCreditsByCandidateId(@Param("candidateId") Long candidateId);

	@Query(value = "select * from credits where user_id = :userId", nativeQuery = true)
	CreditsEntity findCreditsByUserId(@Param("userId") Long userId);

	@Query(value = "select * from credits where user_id = :userId limit :skip,:limits ", nativeQuery = true)
	List<CreditsEntity> findCreditsByUserIdAsList(@Param("userId") Long userId, @Param("skip") int skip,
			@Param("limits") int limits);

	@Query(value = "select * from credits where user_id = :userId and template_name = :templateName", nativeQuery = true)
	CreditsEntity findCreditsByUserIdAndTemplateName(@Param("userId") Long userId,
			@Param("templateName") String templateName);

	@Query(value = "select credit_available from  credits where user_id = :userId and template_name = :templateName ", nativeQuery = true)
	Double getAvailableCreditsByTemplateName(@Param("userId") Long userId, @Param("templateName") String templateName);

	@Query(value = "select nick_name from credits where user_id = :userId", nativeQuery = true)
	Optional<List<String>> getTemplateNameByUserId(@Param("userId") Long userId);

	@Query(value = "select * from credits where user_id = :userId and nick_name = :nickName", nativeQuery = true)
	CreditsEntity findCreditsByUsingNickName(@Param("userId") Long userId, @Param("nickName") String nickName);

	@Query(value = "select credit_available from  credits where user_id = :userId ", nativeQuery = true)
	Double getAvailableCreditsByNickName(@Param("userId") Long userId);

	@Query(value = "select count(*) from credits where user_id = :userId ", nativeQuery = true)
	Long findCreditsByUserIdAsListCount(@Param("userId") Long userId);

	@Query(value = "select sum(credit_available) from credits where user_id = :userId ", nativeQuery = true)
	Double getOverallCredit(@Param("userId") Long userId);

}
