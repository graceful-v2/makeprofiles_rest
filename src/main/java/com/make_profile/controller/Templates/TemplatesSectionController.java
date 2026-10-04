package com.make_profile.controller.Templates;

import com.make_profile.dto.templates.TemplatesDto;
import com.make_profile.dto.templates.TemplatesHeaderDto;
import com.make_profile.service.Template.TemplateSectionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/templates")
public class TemplatesSectionController {

    private static final Logger logger = LoggerFactory.getLogger(TemplatesSectionController.class);

    @Autowired
    TemplateSectionService templateService;

    @GetMapping("/get-all")
    public ResponseEntity<?> getAllTemplates( )  {

        logger.debug("Controller :: getAllTemplates :: Entered");

        List<TemplatesHeaderDto> templateDetails = templateService.getTemplateDetails();

        logger.debug("Controller :: getAllTemplates :: Exited");

        return new ResponseEntity<>(templateDetails, HttpStatus.OK);

    }
}
