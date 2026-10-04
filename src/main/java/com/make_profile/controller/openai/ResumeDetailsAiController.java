package com.make_profile.controller.openai;

import com.make_profile.controller.BaseController;
import com.make_profile.utility.CommonConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.candidates.CandidateResumeDto;
import com.make_profile.service.openai.ResumeDetailsAiService;

import java.util.List;

@RestController
@RequestMapping("/resume-ai")
public class ResumeDetailsAiController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ResumeDetailsAiController.class);

	@Autowired
	ResumeDetailsAiService resumeDetailsAiService;

	@PostMapping("/upload")
	public ResponseEntity<?> getResumeDetailsFromOpenAi(@ModelAttribute CandidateResumeDto candidateResumeDto) {

		logger.debug("Controller :: getResumeDetailsFromOpenAi :: Entered");

		CandidateDto uploadResumeDetialsFromAi = resumeDetailsAiService
				.getUploadResumeDetialsFromAi(candidateResumeDto.getResume(), candidateResumeDto.getUsername());

		logger.debug("Controller :: getResumeDetailsFromOpenAi :: Exited");

		return new ResponseEntity<>(uploadResumeDetialsFromAi, HttpStatus.OK);

	}

	@PostMapping("/upload-resume")
	public ResponseEntity<?> getResumeDetailsFromOpenAiForCandidate(
			@ModelAttribute CandidateResumeDto candidateResumeDto) {

		logger.debug("Controller :: getResumeDetailsFromOpenAiForCandidate :: Entered");

		CandidateDto resumeDetails = resumeDetailsAiService
				.getResumeDetailsFromOpenAiForCandidate(candidateResumeDto.getResume());

		logger.debug("Controller :: getResumeDetailsFromOpenAiForCandidate :: Exited");

		return new ResponseEntity<>(resumeDetails, HttpStatus.OK);

	}

	@PostMapping("/upload-ai-resume")
	public ResponseEntity<?> getResumeDetailsFromOpenAiWihtoutLogin(@ModelAttribute CandidateResumeDto candidateResumeDto) {

		logger.debug("Controller :: getResumeDetailsFromOpenAiWihtoutLogin :: Entered");

		List<String> validateAutoFillContent = resumeDetailsAiService.validateAutoFillContentFromLogin(candidateResumeDto.getResume());

		if(validateAutoFillContent.size() == 0) {
			CandidateDto uploadResumeDetialsFromAi = resumeDetailsAiService
					.getUploadResumeDetialsFromAi(candidateResumeDto.getResume(), candidateResumeDto.getUsername());

			if (uploadResumeDetialsFromAi != null) {
				return new ResponseEntity<>(uploadResumeDetialsFromAi, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(buildResponse(CommonConstants.MP_0015), HttpStatus.BAD_REQUEST);
			}
		}

		logger.debug("Controller :: getResumeDetailsFromOpenAiWihtoutLogin :: Exited");
		return new ResponseEntity<>(validateAutoFillContent, HttpStatus.OK);

	}
}
