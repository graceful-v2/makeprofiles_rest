package com.make_profile.dto.candidates;

import java.util.List;

public class AiResponseDto {

    private Long id;

    private List<String> skills;

    private List<String> softSkills;

    private List<String> coreCompentencies;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<String> getCoreCompentencies() {
        return coreCompentencies;
    }

    public void setCoreCompentencies(List<String> coreCompentencies) {
        this.coreCompentencies = coreCompentencies;
    }

    public List<String> getSoftSkills() {
        return softSkills;
    }

    public void setSoftSkills(List<String> softSkills) {
        this.softSkills = softSkills;
    }

    public List<String> getSkills() {
        return skills;
    }

    public void setSkills(List<String> skills) {
        this.skills = skills;
    }
}
