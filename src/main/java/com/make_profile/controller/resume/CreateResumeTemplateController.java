package com.make_profile.controller.resume;

import com.make_profile.dto.resume.GeneratePdfResponseDto;
import com.make_profile.service.resume.GeneratePdfListernerResponseService;
import com.make_profile.service.resume.GeneratePdfService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.make_profile.controller.BaseController;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.master.ResponcePdfDto;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.service.resume.CreateResumeTemplateService;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/resume")
public class CreateResumeTemplateController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(CreateResumeTemplateController.class);

    @Autowired
    CreateResumeTemplateService createResumeTemplateService;

    @Autowired
    GeneratePdfService generatePdfService;

    @Autowired
    GeneratePdfListernerResponseService generatePdfListernerResponseService;

    @PostMapping("/create")
    public ResponseEntity<?> createResumeTemplate(@RequestBody CandidateDto candidateDto, @RequestHeader("username") String username, @RequestHeader("userId") String userId, @RequestParam("additionalDetails") boolean additionalDetails) throws MakeProfileException {

        logger.debug("Controller :: createResumeTemplate :: Entered");

        ResponcePdfDto createResumeTemplate = createResumeTemplateService.createResumeTemplate(candidateDto, username, Long.valueOf(userId), additionalDetails);

        logger.debug("Controller :: createResumeTemplate :: Exited");

        return new ResponseEntity<>(createResumeTemplate, HttpStatus.OK);

    }

    @PostMapping("/get-content")
    public ResponseEntity<?> getContent(@RequestBody CandidateDto candidateDto, @RequestHeader("username") String username, @RequestParam("jobFor") String jobFor) throws MakeProfileException {

        logger.debug("Controller :: getContent :: Entered");

        CandidateDto createResumeTemplate = createResumeTemplateService.getContent(candidateDto, username, jobFor);

        logger.debug("Controller :: getContent :: Exited");

        return new ResponseEntity<>(createResumeTemplate, HttpStatus.OK);

    }


    @PostMapping("/generate-jobid")
    public ResponseEntity<?> generatingJobId(@RequestBody CandidateDto candidateDto, @RequestHeader("username") String username, @RequestHeader("userId") String userId, @RequestParam("additionalDetails") boolean additionalDetails, @RequestParam("jobId") String jobId) throws MakeProfileException {

        logger.debug("Controller :: generatingJobId :: Entered");

        GeneratePdfResponseDto generatingPdfJobId = generatePdfService.generatingJobIdForPdf(candidateDto, username, Long.valueOf(userId), additionalDetails, jobId);

        logger.debug("Controller :: generatingJobId :: Exited");

        return new ResponseEntity<>(generatingPdfJobId, HttpStatus.OK);

    }


    @GetMapping("/get-pdf-bytes")
    public ResponseEntity<?> generatePdfListernerResponse(@RequestParam("jobId") String jobId) {

        logger.debug("Controller :: generatePdfListernerResponse :: Entered");

        ResponcePdfDto responcePdf = generatePdfListernerResponseService.generatePdfBytesByRabbitMQ(jobId);

        logger.debug("Controller :: generatePdfListernerResponse :: Exited");

        return new ResponseEntity<>(responcePdf, HttpStatus.OK);

    }


    @GetMapping("/generate-resume")
    public ResponseEntity<?> generateResumeUsingByte(@RequestParam("jobId") String jobId, @RequestParam("templateName") String templateName, @RequestHeader("userId") String userId) throws MakeProfileException {

        logger.debug("Controller :: generateResumeUsingByte :: Entered");

        ResponcePdfDto responcePdf = generatePdfListernerResponseService.generateResumeUsingByte(jobId, templateName, Long.valueOf(userId));

        logger.debug("Controller :: generateResumeUsingByte :: Exited");

        return new ResponseEntity<>(responcePdf, HttpStatus.OK);

    }


    @PostMapping("/generate-pdf-jobid")
    public ResponseEntity<?> generatingPdfJobId(@RequestBody CandidateDto candidateDto, @RequestHeader("username") String username, @RequestHeader("userId") String userId, @RequestParam("additionalDetails") boolean additionalDetails, @RequestParam("jobId") String jobId) throws MakeProfileException {

        logger.debug("Controller :: generatingPdfJobId :: Entered");

        GeneratePdfResponseDto generatingPdfJobId = generatePdfService.generatingPdfJobId(candidateDto, username, Long.valueOf(userId), additionalDetails, jobId);

        logger.debug("Controller :: generatingPdfJobId :: Exited");

        return new ResponseEntity<>(generatingPdfJobId, HttpStatus.OK);

    }


    @GetMapping("/download-bytes")
    public ResponseEntity<?> downloadAsBytes(
            @RequestParam("jobId") String jobId) throws Exception {
        logger.debug("Controller :: downloadAsBytes :: Entered");

        ResponcePdfDto pdfByteArray = generatePdfService.downloadAsBytes(jobId);

        logger.debug("Controller :: downloadAsBytes :: Exited");

        return new ResponseEntity<>(pdfByteArray, HttpStatus.OK);
    }


}
