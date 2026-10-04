package com.make_profile.controller.openai;

import java.util.List;
import java.util.Objects;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.make_profile.controller.BaseController;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.service.openai.MakeProfileOpenAiService;
import com.make_profile.utility.CommonConstants;

@RestController
@RequestMapping("/open-ai")
public class OpenAiController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(OpenAiController.class);

	@Autowired
	MakeProfileOpenAiService makeProfileOpenAiService;

	@PostMapping("/get-details")
	public ResponseEntity<?> makeProfileOpenAi(@RequestParam("content") String content) {
		logger.debug("Controller :: makeProfileOpenAi :: Entered");

		List<String> validateAutoFillContent = makeProfileOpenAiService.validateAutoFillContent(content,true);

		if (validateAutoFillContent.size() == 0) {
			CandidateDto makeProfileAi = makeProfileOpenAiService.makeProfileAi(content);

			if (makeProfileAi != null) {
				return new ResponseEntity<>(makeProfileAi, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(buildResponse(CommonConstants.MP_0015), HttpStatus.BAD_REQUEST);
			}
		}
		logger.debug("Controller :: makeProfileOpenAi :: Exited");
		return new ResponseEntity<>(validateAutoFillContent, HttpStatus.OK);

	}

	@PostMapping("/get-details-login")
	public ResponseEntity<?> getDetailsFromBeforeLogin(@RequestParam("content") String content ,@RequestParam("userIsActive") String userIsActive) {

		logger.debug("Controller :: getDetailsFromBeforeLogin :: Entered");

		boolean userActive = false;
		if(Objects.nonNull(userIsActive) && userIsActive.equals("true")){
			userActive = true;
		}

		List<String> validateAutoFillContent = makeProfileOpenAiService.validateAutoFillContent(content,userActive);

		if (validateAutoFillContent.size() == 0) {
			CandidateDto makeProfileAi = makeProfileOpenAiService.makeProfileAi(content);

			if (makeProfileAi != null) {
				return new ResponseEntity<>(makeProfileAi, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(buildResponse(CommonConstants.MP_0015), HttpStatus.BAD_REQUEST);
			}
		}

		logger.debug("Controller :: getDetailsFromBeforeLogin :: Exited");
		return new ResponseEntity<>(validateAutoFillContent, HttpStatus.OK);

	}

}
