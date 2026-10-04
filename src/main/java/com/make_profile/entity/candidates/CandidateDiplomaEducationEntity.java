package com.make_profile.entity.candidates;

import jakarta.persistence.*;

@Entity
@Table(name="candidate_diploma_education")
public class CandidateDiplomaEducationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true, length = 200)
    private String diplomaInstitutionName;

    @Column(nullable = true, length = 200)
    private String qualificationLevel;

    @Column(nullable = true)
    private String diplomaStartYear;

    @Column(nullable = true)
    private String diplomaEndYear;

    @Column(nullable = true)
    private Double percentage;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDiplomaInstitutionName() {
        return diplomaInstitutionName;
    }

    public void setDiplomaInstitutionName(String diplomaInstitutionName) {
        this.diplomaInstitutionName = diplomaInstitutionName;
    }

    public String getQualificationLevel() {
        return qualificationLevel;
    }

    public void setQualificationLevel(String qualificationLevel) {
        this.qualificationLevel = qualificationLevel;
    }

    public String getDiplomaStartYear() {
        return diplomaStartYear;
    }

    public void setDiplomaStartYear(String diplomaStartYear) {
        this.diplomaStartYear = diplomaStartYear;
    }

    public String getDiplomaEndYear() {
        return diplomaEndYear;
    }

    public void setDiplomaEndYear(String diplomaEndYear) {
        this.diplomaEndYear = diplomaEndYear;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }
}
