package com.make_profile.service.impl.resume;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.make_profile.configuration.RabbitMQConfig;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.master.GeneratePdfDto;
import com.make_profile.dto.master.ResponcePdfDto;
import com.make_profile.dto.resume.GeneratePdfResponseDto;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.service.resume.CreateResumeTemplateService;
import com.make_profile.service.resume.GeneratePdfService;

import com.make_profile.utility.CommonConstants;
import io.micrometer.common.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageProperties;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;
import java.util.UUID;

@Service
public class GeneratePdfServiceImpl implements GeneratePdfService {

    private static final Logger logger = LoggerFactory.getLogger(GeneratePdfServiceImpl.class);


    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    CreateResumeTemplateService createResumeTemplateService;

    @Override
    public GeneratePdfResponseDto generatingJobIdForPdf(CandidateDto candidate, String username, Long userId, boolean additionalDetails, String oldJobId) throws MakeProfileException {
        logger.debug("Service :: generatingJobIdForPdf :: Entered");
        String jobId = null;
        String jobIdToString = null;

        GeneratePdfResponseDto jobIdResponse = new GeneratePdfResponseDto();
        try {
            if (Objects.nonNull(oldJobId) && !oldJobId.isEmpty() ) {
                GeneratePdfListenerServiceImpl.generatedPdfs.remove(oldJobId);
            }

            GeneratePdfResponseDto candidateDetails = createResumeTemplateService.generateResumeHtmlContent(candidate, username, userId, additionalDetails);

            jobId = UUID.randomUUID().toString();

            GeneratePdfDto job = new GeneratePdfDto();
            job.setJobId(jobId);
            job.setHtmlContent(candidateDetails.getResumeContent());

            ObjectMapper objectMapper = new ObjectMapper();
            jobIdToString = objectMapper.writeValueAsString(job);

//            rabbitTemplate.convertAndSend(RabbitMQConfig.PDF_JOB_QUEUE, jobIdToString);

            jobIdResponse.setJobId(jobId);
            jobIdResponse.setName(candidateDetails.getName());

            jobIdToString = null;

        } catch (MakeProfileException e) {
            logger.error("Service :: getResumeHtmlCode :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: generatingJobIdForPdf :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: generatingJobIdForPdf :: Exited");
        return jobIdResponse;
    }

    @Override
    public GeneratePdfResponseDto generatingPdfJobId(CandidateDto candidate, String username, Long userId, boolean additionalDetails, String oldJobId) throws MakeProfileException {
        logger.debug("Service :: generatingPdfJobId :: Entered");
        String pdfobId = null;
        String jobIdToString = null;

        GeneratePdfResponseDto jobIdResponse = new GeneratePdfResponseDto();
        try {
            if (Objects.nonNull(oldJobId) && !oldJobId.isEmpty() ) {
                GeneratePdfListenerServiceImpl.generatedPdfs.remove(oldJobId);
            }

            GeneratePdfResponseDto candidateDetails = createResumeTemplateService.generateResumeHtmlContent(candidate, username, userId, additionalDetails);

            if(Objects.nonNull(candidateDetails) && Objects.nonNull(candidateDetails.getResumeContent()) && !candidateDetails.getResumeContent().isEmpty()){

            pdfobId = UUID.randomUUID().toString();
            GeneratePdfDto job = new GeneratePdfDto();
            job.setJobId(pdfobId);
            job.setHtmlContent(candidateDetails.getResumeContent());

            ObjectMapper objectMapper = new ObjectMapper();
            jobIdToString = objectMapper.writeValueAsString(job);

            rabbitTemplate.convertAndSend("pdf_request_queue", jobIdToString);

            jobIdResponse.setJobId(pdfobId);
            jobIdResponse.setName(candidateDetails.getName());

            }

            jobIdToString = null;

        } catch (MakeProfileException e) {
            logger.error("Service :: generatingPdfJobId :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: generatingPdfJobId :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: generatingPdfJobId :: Exited");
        return jobIdResponse;
    }

    @Override
    public ResponcePdfDto downloadAsBytes(String jobId) {
        logger.debug("Service :: downloadAsBytes :: Entered");

        ResponcePdfDto responcePdf = new ResponcePdfDto();
        try {
            Path file = Paths.get(CommonConstants.PDF_SAVED_LOCATION  + jobId + ".pdf");

            if (Files.exists(file)) {
                byte[] pdfBytes = Files.readAllBytes(file);
                responcePdf.setResumePdf(pdfBytes);
            }

        } catch (Exception e) {
            logger.error("Service :: downloadAsBytes :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: downloadAsBytes :: Exited");
        return responcePdf;
    }

}
