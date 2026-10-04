package com.make_profile.controller.candidates;

import java.util.List;

import com.make_profile.dto.master.CheckJobScoreDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.make_profile.dto.candidates.JobScoreDto;
import com.make_profile.service.candidates.CandidateJobScoreService;

@RestController
@RequestMapping("/score-check")
public class CandidateJobScoreController {

    private static final Logger logger = LoggerFactory.getLogger(CandidateJobScoreController.class);

    @Autowired
    CandidateJobScoreService candidateJobScoreService;

    @PostMapping("/get-score")
    public ResponseEntity<?> checkCandidateJobScore(@RequestBody CheckJobScoreDto checkJobScoreDto, @RequestHeader("userid") Long userid) {
        logger.debug("Controller :: checkCandidateJobScore :: Entered");

        JobScoreDto checkCandidateJobScore = candidateJobScoreService.checkCandidateJobScore(checkJobScoreDto.getJobId(), checkJobScoreDto.getCandidateId(), checkJobScoreDto.getTenant(), userid);

        logger.debug("Controller :: checkCandidateJobScore :: Exited");

        return new ResponseEntity<>(checkCandidateJobScore, HttpStatus.OK);

    }

    @GetMapping("/get-checked-score")
    public ResponseEntity<?> getCheckedJobScore(@RequestParam("candidateId") String candidateId) {
        logger.debug("Controller :: getCheckedJobScore :: Entered");

        List<JobScoreDto> checkedJobScore = candidateJobScoreService.getCheckedJobScore(Long.valueOf(candidateId));

        logger.debug("Controller :: getCheckedJobScore :: Exited");

        return new ResponseEntity<>(checkedJobScore, HttpStatus.OK);

    }
}
