package com.make_profile.dto.candidates;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

public class CandidateSchoolEducationDto {


    private Long id;

    private String schoolName;

    private String educationLevel;

    private String schoolStartYear;

    private String schoolEndYear;

    private Double percentage;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
    }

    public String getSchoolStartYear() {
        return schoolStartYear;
    }

    public void setSchoolStartYear(String schoolStartYear) {
        this.schoolStartYear = schoolStartYear;
    }

    public String getSchoolEndYear() {
        return schoolEndYear;
    }

    public void setSchoolEndYear(String schoolEndYear) {
        this.schoolEndYear = schoolEndYear;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }

    @Override
    public String toString() {
        return "{" + "id=" + id + ", schoolName='" + schoolName + ", educationLevel='" + educationLevel + ", schoolStartYear='" + schoolStartYear + ", schoolEndYear='" + schoolEndYear + ", percentage=" + percentage + '}';
    }
}
