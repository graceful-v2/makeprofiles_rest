package com.make_profile.controller.openai;

import com.make_profile.dto.candidates.AiResponseDto;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.master.AiResponsibilityDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.make_profile.dto.candidates.ResumeContentDto;
import com.make_profile.dto.candidates.SummaryResponseDto;
import com.make_profile.service.openai.GetResumeContentFromAiService;

@RestController
@RequestMapping("/content")
public class GetResumeContentFromAiController {

    private static final Logger logger = LoggerFactory.getLogger(GetResumeContentFromAiController.class);

    @Autowired
    GetResumeContentFromAiService getResumeContentFromAiService;

    @GetMapping("/openai")
    public ResponseEntity<?> getResumeContent(@RequestParam("content") String content) {

        logger.debug("Controller :: getResumeContent :: Entered");

        ResumeContentDto resumeContent = getResumeContentFromAiService.getResumeContent(content);

        logger.debug("Controller :: getResumeContent :: Exited");
        return new ResponseEntity<>(resumeContent, HttpStatus.OK);
    }

    @GetMapping("/get-content")
    public ResponseEntity<?> getSummaryContent() {

        logger.debug("Controller :: getSummaryContent :: Entered");

        SummaryResponseDto responseContent = getResumeContentFromAiService.getSummaryContent();

        logger.debug("Controller :: getSummaryContent :: Exited");
        return new ResponseEntity<>(responseContent, HttpStatus.OK);
    }

    @PostMapping("/get-ai-content")
    public ResponseEntity<?> getAiContent(@RequestBody SummaryResponseDto summaryResponseDto, @RequestParam("key") String key, @RequestParam("operation") String operation) {

        logger.debug("Controller :: getAiContent :: Entered");

        SummaryResponseDto aiContent = getResumeContentFromAiService.getAiContent(summaryResponseDto.getSummary(), key, operation);

        logger.debug("Controller :: getAiContent :: Exited");
        return new ResponseEntity<>(aiContent, HttpStatus.OK);
    }

    @PostMapping("/get-ai-project-content")
    public ResponseEntity<?> getProjectContentFromAi(@RequestBody SummaryResponseDto content, @RequestParam("operation") String operation) {

        logger.debug("Controller :: getProjectContentFromAi :: Entered");

        SummaryResponseDto aiContent = getResumeContentFromAiService.getProjectContentFromAi(content.getSummary(), operation);

        logger.debug("Controller :: getProjectContentFromAi :: Exited");
        return new ResponseEntity<>(aiContent, HttpStatus.OK);
    }


    @PostMapping("/get-ai-exp-content")
    public ResponseEntity<?> getExperienceContentFromAi(@RequestBody SummaryResponseDto content, @RequestParam("operation") String operation) {

        logger.debug("Controller :: getExperienceContentFromAi :: Entered");

        SummaryResponseDto aiContent = getResumeContentFromAiService.getExperienceContentFromAi(content.getSummary(), operation);

        logger.debug("Controller :: getExperienceContentFromAi :: Exited");
        return new ResponseEntity<>(aiContent, HttpStatus.OK);
    }

    @PostMapping("/get-skills-from-ai")
    public ResponseEntity<?> getSkillsFromAi(@RequestBody CandidateDto candidateDto) {

        logger.debug("Controller :: getSkillsFromAi :: Entered");

        AiResponseDto aiContent = getResumeContentFromAiService.getSkillsFromAi(candidateDto);

        logger.debug("Controller :: getSkillsFromAi :: Exited");
        return new ResponseEntity<>(aiContent, HttpStatus.OK);
    }


    @GetMapping("/get-suggested-skills")
    public ResponseEntity<?> getSuggestedSkillsFromOpenAi(@RequestParam("skills") String skills) {

        logger.debug("Controller :: getSuggestedSkillsFromOpenAi :: Entered");

        AiResponseDto suggestedSkills = getResumeContentFromAiService.getSuggestedSkillsFromOpenAi(skills);

        logger.debug("Controller :: getSuggestedSkillsFromOpenAi :: Exited");
        return new ResponseEntity<>(suggestedSkills, HttpStatus.OK);
    }

    @PostMapping("/get-suggested-responsibility")
    public ResponseEntity<?> getSuggestedResponsibilitiesFromOpenAi(@RequestBody AiResponsibilityDto aiResponsibilityDto) {

        logger.debug("Controller :: getSuggestedResponsibilitiesFromOpenAi :: Entered");

        AiResponsibilityDto suggestedSkills = getResumeContentFromAiService.getSuggestedResponsibilitiesFromOpenAi(aiResponsibilityDto);

        logger.debug("Controller :: getSuggestedResponsibilitiesFromOpenAi :: Exited");
        return new ResponseEntity<>(suggestedSkills, HttpStatus.OK);
    }

}
