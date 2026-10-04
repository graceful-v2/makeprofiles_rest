package com.make_profile.dto.templates;


import java.util.List;

public class TemplatesHeaderDto {


    private Long id;

    private String templateHeaderName;

    private List<TemplatesDto> template;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTemplateHeaderName() {
        return templateHeaderName;
    }

    public void setTemplateHeaderName(String templateHeaderName) {
        this.templateHeaderName = templateHeaderName;
    }

    public List<TemplatesDto> getTemplate() {
        return template;
    }

    public void setTemplate(List<TemplatesDto> template) {
        this.template = template;
    }
}
