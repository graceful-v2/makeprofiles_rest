package com.make_profile.repository.master;

import com.make_profile.entity.master.JobSubSubCategoryEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface JobSubSubCategoryRepository extends JpaRepository<JobSubSubCategoryEntity, Long> {

    @Query(value = " select ssc.* FROM job_sub_subcategory ssc join job_subcategory sc on ssc.subcategory_id = sc.id  JOIN job_category c on sc.category_id = c.id WHERE lower(ssc.sub_subcategory_name) like lower(concat('%', :keyword, '%'))   OR lower(sc.subcategory_name) like lower(concat('%', :keyword, '%')) OR lower(c.category_name) like lower(concat('%', :keyword, '%')) ", nativeQuery = true)
    List<JobSubSubCategoryEntity> searchByKeyword(@Param("keyword") String keyword);

}
