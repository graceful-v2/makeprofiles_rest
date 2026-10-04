package com.make_profile.service.impl.resume;

import com.make_profile.configuration.RabbitMQConfig;
import com.make_profile.dto.master.ResponcePdfDto;
import com.make_profile.dto.master.ResumeTemplateDto;
import com.make_profile.entity.master.CreditsEntity;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.repository.master.CreditsRepository;
import com.make_profile.service.master.CreditsService;
import com.make_profile.service.resume.GeneratePdfListernerResponseService;
import com.make_profile.utility.CommonConstants;
import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;


@Service
public class GeneratePdfListenerServiceImpl implements GeneratePdfListernerResponseService {

    private static final Logger logger = LoggerFactory.getLogger(GeneratePdfListenerServiceImpl.class);


    public static final Map<String, byte[]> generatedPdfs = new ConcurrentHashMap<>();

    @Autowired
    CreditsService creditsService;

    @Autowired
    CreditsRepository creditsRepository;


    @Override
    public ResponcePdfDto generatePdfBytesByRabbitMQ(String jobId) {
        logger.debug("Service :: generatePdfBytesByRabbitMQ :: Extered");

        byte[] responseByte = null;
        ResponcePdfDto responcePdf = new ResponcePdfDto();
        try {
            responseByte = generatedPdfs.get(jobId);

            responcePdf.setResumePdf(Optional.ofNullable(responseByte).orElse(new byte[0]));

        } catch (Exception e) {
            logger.error("Service :: generatePdfBytesByRabbitMQ :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: generatePdfBytesByRabbitMQ :: Exited");

        return responcePdf;
    }

    @Override
    public ResponcePdfDto generateResumeUsingByte(String jobId, String templateName, Long userId) throws MakeProfileException {
        logger.debug("Service :: generateResumeUsingByte :: Extered");

        byte[] responseByte = null;
        ResponcePdfDto responcePdf = new ResponcePdfDto();
        try {
            CreditsEntity findCreditsByUserId = creditsRepository.findCreditsByUserId(userId);

            if (Objects.nonNull(findCreditsByUserId) && Math.round(findCreditsByUserId.getCreditAvailable()) <= 0) {
                findCreditsByUserId = null;
                throw new MakeProfileException(CommonConstants.MP_0016);
            }
            findCreditsByUserId = null;
            Path file = Paths.get(CommonConstants.PDF_SAVED_LOCATION + jobId + ".pdf");

            if (Files.exists(file)) {
                byte[] pdfBytes = Files.readAllBytes(file);
                responcePdf.setResumePdf(pdfBytes);
            }

            // Remove credits for generating resume
            ResumeTemplateDto resumeTemplateDto = new ResumeTemplateDto();

            resumeTemplateDto.setTemplateName(templateName);
            creditsService.useCredit(resumeTemplateDto, userId);
            resumeTemplateDto = null;
        } catch (MakeProfileException e) {
            logger.error("Service :: generateResumeHtmlContent :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: generateResumeUsingByte :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: generateResumeUsingByte :: Exited");

        return responcePdf;
    }

    @RabbitListener(queues = "pdf_response_queues", ackMode = "MANUAL")
    public void receivePdfResponse(Message message, Channel channel) {

        logger.debug("Service :: receivePdfResponse :: Entered");
        try {
            System.out.println("rabbit mq lister correctly");
            String jobId = message.getMessageProperties().getHeader("jobId");
            if (Objects.isNull(jobId)) {
                logger.error("Service :: receivePdfResponse :: jobId is NULL");
                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
                return;
            }
//            byte[] pdfBytes = message.getBody();
//            if (Objects.isNull(pdfBytes)) {
//                logger.error("Service :: receivePdfResponse :: Empty PDF for jobId={}", jobId);
//                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
//                return;
//            }
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);

            logger.debug("Service :: receivePdfResponse :: Success for jobId={}", jobId);

        } catch (Exception e) {
            logger.error("Service :: receivePdfResponse :: Exception", e);
            try {
                channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, false);
            } catch (Exception ex) {
                logger.error("Service :: receivePdfResponse :: NACK failed", ex);
            }
        }
        logger.debug("Service :: receivePdfResponse :: Exited");
    }


}
