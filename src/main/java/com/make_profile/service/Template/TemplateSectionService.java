package com.make_profile.service.Template;

import com.make_profile.dto.templates.TemplatesDto;
import com.make_profile.dto.templates.TemplatesHeaderDto;

import java.util.List;

public interface TemplateSectionService {

    List<TemplatesHeaderDto> getTemplateDetails();
}
