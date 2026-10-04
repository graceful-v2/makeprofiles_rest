package com.make_profile.repository.master;

import com.make_profile.entity.master.JobCategoryEntity;
import com.make_profile.entity.master.JobSubCategoryEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface JobSubCategoryRepository extends JpaRepository<JobSubCategoryEntity,Long> {

    @Query(value = " select s.* from job_subcategory s join job_category c on s.category_id = c.id WHERE lower(s.subcategory_name) like lower(CONCAT('%', :categoryName, '%')) OR lower(c.category_name) like lower(CONCAT('%', :categoryName, '%')) ", nativeQuery = true)
    List<JobSubCategoryEntity> searchJobCategory(@Param("categoryName") String categoryName);
}
