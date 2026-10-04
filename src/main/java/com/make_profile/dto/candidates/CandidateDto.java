package com.make_profile.dto.candidates;

import java.util.List;
import java.util.Objects;

import com.make_profile.entity.candidates.CandidateSchoolEducationEntity;


import com.make_profile.dto.BaseDto;

public class CandidateDto extends BaseDto {

    private Long id;

    private String name;

    private String mobileNumber;

    private String alternateMobileNumber;

    private String email;

    private String nationality;

    private String gender;

    private String languagesKnown;

    private boolean isFresher;

    private String skills;

    private String linkedIn;

    private String dob;

    private String address;

    private String maritalStatus;

    private List<CandidateExperienceDto> experiences;

    private List<CandidateQualificationDto> qualification;

    private List<CandidateCertificatesDto> certificates;

    private List<CandidateAchievementsDto> achievements;

    private String candidateLogo;

    private String softSkills;

    private String coreCompentencies;

    private String score;

    private boolean matches;

    private List<CandidateCollegeProjectDto> collegeProject;

    private String summary;

    private String careerObjective;

    private String templateName;

    private String createdUserName;

    private boolean coreCompentenciesMandatory;

    private boolean softSkillsMandatory;

    private boolean certificatesMandatory;

    private boolean achievementsMandatory;

    private String nickName;

    private String hobbies;

    private String fatherName;

    private List<CandidateSchoolEducationDto> schoolEducation;

    private List<CandidateDiplomaEducationDto> diplomaEducation;

    private String strengths;

    private String goals;

    private String extraCurricularActivities;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getAlternateMobileNumber() {
        return alternateMobileNumber;
    }


    public void setAlternateMobileNumber(String alternateMobileNumber) {
        this.alternateMobileNumber = alternateMobileNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public List<CandidateExperienceDto> getExperiences() {
        return experiences;
    }

    public void setExperiences(List<CandidateExperienceDto> experiences) {
        this.experiences = experiences;
    }

    public List<CandidateQualificationDto> getQualification() {
        return qualification;
    }

    public void setQualification(List<CandidateQualificationDto> qualification) {
        this.qualification = qualification;
    }

    public List<CandidateCertificatesDto> getCertificates() {
        return certificates;
    }

    public void setCertificates(List<CandidateCertificatesDto> certificates) {
        this.certificates = certificates;
    }

    public List<CandidateAchievementsDto> getAchievements() {
        return achievements;
    }

    public void setAchievements(List<CandidateAchievementsDto> achievements) {
        this.achievements = achievements;
    }

    public String getLinkedIn() {
        return linkedIn;
    }

    public void setLinkedIn(String linkedIn) {
        this.linkedIn = linkedIn;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getCandidateLogo() {
        return candidateLogo;
    }

    public void setCandidateLogo(String candidateLogo) {
        this.candidateLogo = candidateLogo;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public boolean isMatches() {
        return matches;
    }

    public void setMatches(boolean matches) {
        this.matches = matches;
    }

    public List<CandidateCollegeProjectDto> getCollegeProject() {
        return collegeProject;
    }

    public void setCollegeProject(List<CandidateCollegeProjectDto> collegeProject) {
        this.collegeProject = collegeProject;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getCareerObjective() {
        return careerObjective;
    }

    public void setCareerObjective(String careerObjective) {
        this.careerObjective = careerObjective;
    }

    public String getLanguagesKnown() {
        return languagesKnown;
    }

    public void setLanguagesKnown(String languagesKnown) {
        this.languagesKnown = languagesKnown;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getSoftSkills() {
        return softSkills;
    }

    public void setSoftSkills(String softSkills) {
        this.softSkills = softSkills;
    }

    public String getCoreCompentencies() {
        return coreCompentencies;
    }

    public void setCoreCompentencies(String coreCompentencies) {
        this.coreCompentencies = coreCompentencies;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public boolean isFresher() {
        return isFresher;
    }

    public void setFresher(boolean isFresher) {
        this.isFresher = isFresher;
    }

    public String getCreatedUserName() {
        return createdUserName;
    }

    public void setCreatedUserName(String createdUserName) {
        this.createdUserName = createdUserName;
    }

    public boolean isCoreCompentenciesMandatory() {
        return coreCompentenciesMandatory;
    }

    public void setCoreCompentenciesMandatory(boolean coreCompentenciesMandatory) {
        this.coreCompentenciesMandatory = coreCompentenciesMandatory;
    }

    public boolean isSoftSkillsMandatory() {
        return softSkillsMandatory;
    }

    public void setSoftSkillsMandatory(boolean softSkillsMandatory) {
        this.softSkillsMandatory = softSkillsMandatory;
    }

    public boolean isCertificatesMandatory() {
        return certificatesMandatory;
    }

    public void setCertificatesMandatory(boolean certificatesMandatory) {
        this.certificatesMandatory = certificatesMandatory;
    }

    public boolean isAchievementsMandatory() {
        return achievementsMandatory;
    }

    public void setAchievementsMandatory(boolean achievementsMandatory) {
        this.achievementsMandatory = achievementsMandatory;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getHobbies() {
        return hobbies;
    }

    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }

    public String getFatherName() {
        return fatherName;
    }

    public void setFatherName(String fatherName) {
        this.fatherName = fatherName;
    }

    public List<CandidateSchoolEducationDto> getSchoolEducation() {
        return schoolEducation;
    }

    public void setSchoolEducation(List<CandidateSchoolEducationDto> schoolEducation) {
        this.schoolEducation = schoolEducation;
    }

    public List<CandidateDiplomaEducationDto> getDiplomaEducation() {
        return diplomaEducation;
    }

    public void setDiplomaEducation(List<CandidateDiplomaEducationDto> diplomaEducation) {
        this.diplomaEducation = diplomaEducation;
    }

    public String getStrengths() {
        return strengths;
    }

    public void setStrengths(String strengths) {
        this.strengths = strengths;
    }

    public String getGoals() {
        return goals;
    }

    public void setGoals(String goals) {
        this.goals = goals;
    }

    public String getExtraCurricularActivities() {
        return extraCurricularActivities;
    }

    public void setExtraCurricularActivities(String extraCurricularActivities) {
        this.extraCurricularActivities = extraCurricularActivities;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CandidateDto that = (CandidateDto) o;
        return isFresher == that.isFresher &&
                Objects.equals(skills, that.skills) &&
                Objects.equals(experiences, that.experiences) &&
                Objects.equals(qualification, that.qualification) &&
                Objects.equals(collegeProject, that.collegeProject) &&
                Objects.equals(summary, that.summary) &&
                Objects.equals(careerObjective, that.careerObjective) &&
                Objects.equals(hobbies, that.hobbies);
    }


    @Override
    public int hashCode() {
        return Objects.hash(isFresher, skills, experiences, qualification, certificates, collegeProject, summary, careerObjective);
    }


    @Override
    public String toString() {
        return "CandidateDto{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", mobileNumber='" + mobileNumber + '\'' +
                ", alternateMobileNumber='" + alternateMobileNumber + '\'' +
                ", email='" + email + '\'' +
                ", nationality='" + nationality + '\'' +
                ", gender='" + gender + '\'' +
                ", languagesKnown='" + languagesKnown + '\'' +
                ", isFresher=" + isFresher +
                ", skills='" + skills + '\'' +
                ", linkedIn='" + linkedIn + '\'' +
                ", dob='" + dob + '\'' +
                ", address='" + address + '\'' +
                ", maritalStatus='" + maritalStatus + '\'' +
                ", experiences=" + experiences +
                ", qualification=" + qualification +
                ", certificates=" + certificates +
                ", achievements=" + achievements +
                ", softSkills='" + softSkills + '\'' +
                ", coreCompentencies='" + coreCompentencies + '\'' +
                ", strengths='" + strengths + '\'' +
                ", goals='" + goals + '\'' +
                ", extraCurricularActivities='" + extraCurricularActivities + '\'' +
                ", score='" + score + '\'' +
                ", matches=" + matches +
                ", collegeProject=" + collegeProject +
                ", summary='" + summary + '\'' +
                ", careerObjective='" + careerObjective + '\'' +
                ", templateName='" + templateName + '\'' +
                ", createdUserName='" + createdUserName + '\'' +
                ", coreCompentenciesMandatory=" + coreCompentenciesMandatory +
                ", softSkillsMandatory=" + softSkillsMandatory +
                ", certificatesMandatory=" + certificatesMandatory +
                ", achievementsMandatory=" + achievementsMandatory +
                ", nickName='" + nickName + '\'' +
                ", hobbies='" + hobbies + '\'' +
                ", fatherName='" + fatherName + '\'' +
                ", schoolEducation='" + schoolEducation + '\'' +
                ", diplomaEducation='" + diplomaEducation + '\'' +
                '}';
    }


}
