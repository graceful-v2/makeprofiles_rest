package com.make_profile.repository.master;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_profile.entity.master.CreditHistoryEntity;
import com.make_profile.entity.master.ResumeTemplatesEntity;

import jakarta.transaction.Transactional;

@Repository
@Transactional
public interface CreditHistoryRepository extends JpaRepository<CreditHistoryEntity, Long> {

	@Query(value = "select * from credit_history where user_id = :userId  order by id desc  limit :skip , :limits ", nativeQuery = true)
	List<CreditHistoryEntity> findByUserId(@Param("userId") Long userId, @Param("skip") int skip,
			@Param("limits") int limits);

	@Query(value = "select count(*) from credit_history where user_id = :userId ", nativeQuery = true)
	Long getCoutnByUserId(@Param("userId") Long userId);
}
