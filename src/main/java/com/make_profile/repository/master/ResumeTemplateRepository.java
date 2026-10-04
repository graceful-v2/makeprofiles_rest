package com.make_profile.repository.master;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_profile.entity.master.ResumeTemplatesEntity;

import jakarta.transaction.Transactional;

@Repository
@Transactional
public interface ResumeTemplateRepository extends JpaRepository<ResumeTemplatesEntity, Long> {

	@Query(value = " select * from resume_template where template_name <> 'Applied Jobs'  and credit_id =(select id from credits where user_id = :userId ) order by id desc  limit :skip , :limits ", nativeQuery = true)
	List<ResumeTemplatesEntity> findTemplateByCreditId(@Param("userId") Long userId, @Param("skip") int skip,
			@Param("limits") int limits);
	
	@Query(value = "select count(*) from resume_template where template_name <> 'Applied Jobs' and credit_id =(select id from credits where user_id = :userId ) ", nativeQuery = true)
	Long getCoutnByCreditId(@Param("userId") Long userId);
	
	@Modifying
	@Query(value = "update resume_template set nick_name = :nickName where id =:id ", nativeQuery = true)
	 void updateNickName(@Param("id") Long id,@Param("nickName") String nickName);

}
