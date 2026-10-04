package com.make_profile.dto.candidates;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

public class CandidateExperienceDto {

    private Long id;

    private String companyName;

    private String role;

    private String experienceYearStartDate;

    private String experienceYearEndDate;

    private Boolean currentlyWorking;

    private String Responsibilities;

    private List<CandidateProjectDetailsDto> projects;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getExperienceYearStartDate() {
        return experienceYearStartDate;
    }

    public void setExperienceYearStartDate(String experienceYearStartDate) {
        this.experienceYearStartDate = experienceYearStartDate;
    }

    public String getExperienceYearEndDate() {
        return experienceYearEndDate;
    }

    public void setExperienceYearEndDate(String experienceYearEndDate) {
        this.experienceYearEndDate = experienceYearEndDate;
    }

    public Boolean getCurrentlyWorking() {
        return currentlyWorking;
    }

    public void setCurrentlyWorking(Boolean currentlyWorking) {
        this.currentlyWorking = currentlyWorking;
    }

    public List<CandidateProjectDetailsDto> getProjects() {
        return projects;
    }

    public void setProjects(List<CandidateProjectDetailsDto> projects) {
        this.projects = projects;
    }

    public String getResponsibilities() {
        return Responsibilities;
    }

    public void setResponsibilities(String responsibilities) {
        Responsibilities = responsibilities;
    }

    @Override
    public String toString() {
        return "{" + "id=" + id + ", companyName=" + companyName + ", role=" + role + ", experienceYearStartDate="
                + experienceYearStartDate + ", experienceYearEndDate=" + experienceYearEndDate + ", currentlyWorking="
                + currentlyWorking + ", Responsibilities=" + Responsibilities + ", projects=" + projects + +'}';
    }


    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        CandidateExperienceDto that = (CandidateExperienceDto) o;
        return
                Objects.equals(companyName, that.companyName) &&
                        Objects.equals(role, that.role) &&
                        Objects.equals(experienceYearStartDate, that.experienceYearStartDate) &&
                        Objects.equals(experienceYearEndDate, that.experienceYearEndDate) &&
                        Objects.equals(currentlyWorking, that.currentlyWorking) &&
                        isEqualString(Responsibilities, that.Responsibilities) &&
                        Objects.equals(projects, that.projects);

    }

    private static boolean isEqualString(String a, String b) {
        if ((a == null || a.isBlank()) && (b == null || b.isBlank())) {
            return true;
        }
        return Objects.equals(a, b);
    }


    @Override
    public int hashCode() {
        return Objects.hash(id, companyName, role, experienceYearStartDate, experienceYearEndDate, currentlyWorking, Responsibilities, projects);
    }
}
