package com.make_profile.entity.templates;

import com.make_profile.entity.candidates.CandidateCollegeProjectEntity;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "templates_header")
public class TemplateHeaderEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true, length = 50)
    private String templateHeaderName;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "template_header_id")
    private List<TemplateEntity> template;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<TemplateEntity> getTemplate() {
        return template;
    }

    public String getTemplateHeaderName() {
        return templateHeaderName;
    }

    public void setTemplateHeaderName(String templateHeaderName) {
        this.templateHeaderName = templateHeaderName;
    }

    public void setTemplate(List<TemplateEntity> template) {
        this.template = template;
    }
}
