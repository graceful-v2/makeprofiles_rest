package com.make_profile.entity.candidates;

import jakarta.persistence.*;

@Entity
@Table(name = "candidate_school_education")
public class CandidateSchoolEducationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true, length = 100)
    private String schoolName;

    @Column(nullable = true, length = 100)
    private String educationLevel;

    @Column(nullable = true)
    private String schoolStartYear;

    @Column(nullable = true)
    private String schoolEndYear;

    @Column(nullable = true)
    private Double percentage;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
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
}
