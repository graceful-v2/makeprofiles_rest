package com.make_profile.service.impl.Template;

import com.make_profile.dto.templates.TemplatesDto;
import com.make_profile.dto.templates.TemplatesHeaderDto;
import com.make_profile.repository.templates.TemplateHeaderRepository;
import com.make_profile.repository.templates.TemplateRepository;
import com.make_profile.service.Template.TemplateSectionService;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TemplateSectionServiceImpl implements TemplateSectionService {

    private static final Logger logger = LoggerFactory.getLogger(TemplateSectionServiceImpl.class);

    @Autowired
    TemplateRepository templateRepository;

    @Autowired
    TemplateHeaderRepository templateHeaderRepository;


    @Autowired
    ModelMapper modelMapper;

    @Override
    public List<TemplatesHeaderDto> getTemplateDetails() {

        List<TemplatesHeaderDto> templateDtoList = new ArrayList<>();

        try {
            templateHeaderRepository.findAll().forEach(template -> {
                templateDtoList.add(modelMapper.map(template, TemplatesHeaderDto.class));
            });

        } catch (Exception e) {
            logger.error("Service :: convertHtmlToPdf :: Exception :: " + e.getMessage());
            return null;
        }
        return templateDtoList;
    }


}