package com.make_profile.controller.master;

import com.make_profile.dto.WrapperDto;
import com.make_profile.dto.master.JobCategoryDto;
import com.make_profile.dto.master.ResumeTemplateDto;
import com.make_profile.service.master.JobCategoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/job-category")
public class JobCategoryController {

    @Autowired
    JobCategoryService jobCategoryService;


    private static final Logger logger = LoggerFactory.getLogger(JobCategoryController.class);

    @PostMapping
    public ResponseEntity<?> searchJobCategory(@RequestBody JobCategoryDto jobCategoryDto) {
        logger.debug("Controller :: searchJobCategory :: Entered");
        JobCategoryDto jobCategory = jobCategoryService.searchJobCategory(jobCategoryDto);

        logger.debug("Controller :: searchJobCategory :: Exited");

        return new ResponseEntity<>(jobCategory, HttpStatus.OK);

    }

}
