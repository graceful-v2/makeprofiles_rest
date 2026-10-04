package com.make_profile.dto.candidates;

public class CandidateDiplomaEducationDto {

    private Long id;

    private String diplomaInstitutionName;

    private String qualificationLevel;

    private String diplomaStartYear;

    private String diplomaEndYear;

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

    @Override
    public String toString() {
        return "{" + "id=" + id + ", diplomaInstitutionName='" + diplomaInstitutionName + ", qualificationLevel='" + qualificationLevel + ", diplomaStartYear='" + diplomaStartYear + ", diplomaEndYear='" + diplomaEndYear + ", percentage=" + percentage + '}';
    }
}
