package com.make_profile.service.impl.master;

import com.make_profile.dto.master.JobCategoryDto;
import com.make_profile.entity.master.CreditsEntity;
import com.make_profile.entity.master.JobCategoryEntity;
import com.make_profile.entity.master.JobSubCategoryEntity;
import com.make_profile.entity.master.JobSubSubCategoryEntity;
import com.make_profile.repository.master.JobCategoryRepository;
import com.make_profile.repository.master.JobSubCategoryRepository;
import com.make_profile.repository.master.JobSubSubCategoryRepository;
import com.make_profile.service.master.JobCategoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class JobCategoryServiveImpl implements JobCategoryService {

    private static final Logger logger = LoggerFactory.getLogger(JobCategoryServiveImpl.class);

    @Autowired
    JobCategoryRepository jobCategoryRepository;

    @Autowired
    JobSubCategoryRepository jobSubCategoryRepository;

    @Autowired
    JobSubSubCategoryRepository jobSubSubCategoryRepository;

    @Override
    public JobCategoryDto searchJobCategory(JobCategoryDto jobCategoryDto) {
        logger.debug("Service :: searchJobCategory :: Entered");
        List<JobSubSubCategoryEntity> jobSubSubCategoryEntity = null;
        JobCategoryDto JobCategoryDto = new JobCategoryDto();
        List<String> category = new ArrayList<>();

        try {
            jobSubSubCategoryEntity = jobSubSubCategoryRepository.searchByKeyword(jobCategoryDto.getSearchName());

            jobSubSubCategoryEntity.forEach(s -> {
                category.add(s.getSubCategory().getCategory().getCategoryName() + " - " + s.getSubCategory().getSubcategoryName() + " - " +
                        s.getSubSubcategoryName());
            });

            JobCategoryDto.setCategoryName(category);
        } catch (Exception e) {
            logger.error("Service :: searchJobCategory :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: searchJobCategory :: Exited");
        return JobCategoryDto;
    }
}
