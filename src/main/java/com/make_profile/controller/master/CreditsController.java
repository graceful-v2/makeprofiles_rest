package com.make_profile.controller.master;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.make_profile.controller.BaseController;
import com.make_profile.dto.WrapperDto;
import com.make_profile.dto.master.CreditHistoryDto;
import com.make_profile.dto.master.CreditsDto;
import com.make_profile.dto.master.ResumeTemplateDto;
import com.make_profile.service.master.CreditsService;

@RestController
@RequestMapping("/credits")
public class CreditsController extends BaseController {

	@Autowired
	CreditsService creditsService;

	private static final Logger logger = LoggerFactory.getLogger(CreditsController.class);

	@PostMapping
	public ResponseEntity<?> getcredits(@RequestBody ResumeTemplateDto resumeTemplateDto,
			@RequestHeader("userId") String userId) {
		logger.debug("Controller :: getcredits :: Entered");

		WrapperDto<ResumeTemplateDto> credits = creditsService.getCredits(resumeTemplateDto, Long.valueOf(userId));

		logger.debug("Controller :: getcredits :: Exited");

		return new ResponseEntity<>(credits, HttpStatus.OK);

	}

	@PostMapping("/redeem")
	public ResponseEntity<?> useCredits(@RequestBody ResumeTemplateDto resumeTemplateDto,
			@RequestParam("userId") String userId) {
		logger.debug("Controller :: useCredits :: Entered");

		boolean credits = creditsService.useCredit(resumeTemplateDto, Long.valueOf(userId));

		logger.debug("Controller :: useCredits :: Exited");

		return new ResponseEntity<>(credits, HttpStatus.OK);

	}

	@GetMapping("/get-available-credits")
	public ResponseEntity<?> getAvailableCredits(@RequestHeader("userId") String userId) {
		logger.debug("Controller :: getAvailableCredits :: Entered");

		Long availableCredits = creditsService.getAvailableCredits(Long.valueOf(userId));

		logger.debug("Controller :: getAvailableCredits :: Exited");

		return new ResponseEntity<>(availableCredits, HttpStatus.OK);

	}

	@PostMapping("/save-nickname")
	public ResponseEntity<?> saveNickName(@RequestBody ResumeTemplateDto resumeTemplateDto,
			@RequestHeader("userId") String userId) {

		logger.debug("Controller :: saveNickName :: Entered");

		boolean availableCredits = creditsService.updateNickName(resumeTemplateDto, Long.valueOf(userId));

		logger.debug("Controller :: saveNickName :: Exited");

		return new ResponseEntity<>(availableCredits, HttpStatus.OK);

	}

	@GetMapping("get-nicknames")
	public ResponseEntity<?> getNickNames(@RequestHeader("userId") String userId) {

		logger.debug("Controller :: getNickNames :: Entered");

		List<String> nickNames = creditsService.getNickNames(Long.valueOf(userId));

		logger.debug("Controller :: getNickNames :: Exited");

		return new ResponseEntity<>(nickNames, HttpStatus.OK);

	}

	@GetMapping("get-allcredits")
	public ResponseEntity<?> getOverallCredits(@RequestHeader("userId") String userId) {

		logger.debug("Controller :: getNickNames :: Entered");

		CreditsDto credits = creditsService.getOverallCredits(Long.valueOf(userId));

		logger.debug("Controller :: getNickNames :: Exited");

		return new ResponseEntity<>(credits, HttpStatus.OK);

	}

	@PostMapping("credit-history")
	public ResponseEntity<?> getCreditHistory(@RequestBody CreditHistoryDto creditHistoryDto,
			@RequestHeader("userId") String userId) {

		logger.debug("Controller :: getCreditHistory :: Entered");

		WrapperDto<CreditHistoryDto> credits = creditsService.getAllCredits(creditHistoryDto, Long.valueOf(userId));

		logger.debug("Controller :: getCreditHistory :: Exited");

		return new ResponseEntity<>(credits, HttpStatus.OK);
	}

}
