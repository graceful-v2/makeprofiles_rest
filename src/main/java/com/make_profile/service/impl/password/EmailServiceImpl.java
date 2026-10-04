package com.make_profile.service.impl.password;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import com.make_profile.entity.password.UpdateUserPasswordEntity;
import com.make_profile.repository.password.UpdateUserPasswordRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import com.make_profile.dto.EmailDto;
import com.make_profile.service.password.EmailService;

import freemarker.template.Configuration;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailServiceImpl implements EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

    @Autowired
    Configuration configuration;

    @Autowired
    JavaMailSender javaMailSender;

    @Autowired
    UpdateUserPasswordRepository updateUserPasswordRepository;

    @Override
    public boolean sendEmail(EmailDto emailDto) throws Exception {
        logger.debug("Service :: sendEmail :: Entered");

        boolean status = false;

        String[] to = null;
        String[] cc = null;
        String[] bcc = null;
        try {
            if (Objects.nonNull(emailDto.getToAddressList()) && !emailDto.getToAddressList().isEmpty()) {
                to = emailDto.getToAddressList().stream().toArray(String[]::new);
            }

            if (Objects.nonNull(emailDto.getCcList()) && !emailDto.getCcList().isEmpty()) {
                cc = emailDto.getCcList().stream().toArray(String[]::new);
            }

            if (Objects.nonNull(emailDto.getBccList()) && !emailDto.getBccList().isEmpty()) {
                bcc = emailDto.getBccList().stream().toArray(String[]::new);
            }

            MimeMessage message = javaMailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
                    StandardCharsets.UTF_8.name());

            helper.setTo(to);
            helper.setCc(cc != null ? cc : new String[]{});
            helper.setBcc(bcc != null ? bcc : new String[]{});
            helper.setSubject(emailDto.getSubject());
            helper.setText(emailDto.getMessage(), true);

            javaMailSender.send(message);
            status = true;
        } catch (Exception e) {
            logger.error("Service :: sendEmail :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: sendEmail :: Exited");
        return status;
    }

    @Override
    public boolean sendPasswordEmail(EmailDto emailDto, Long userId) throws Exception {
        logger.debug("Service :: sendPasswordEmail :: Entered");

        boolean status = false;

        String[] to = null;
        String[] cc = null;
        String[] bcc = null;
        try {
            if (Objects.nonNull(emailDto.getToAddressList()) && !emailDto.getToAddressList().isEmpty()) {
                to = emailDto.getToAddressList().stream().toArray(String[]::new);
            }

            MimeMessage message = javaMailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
                    StandardCharsets.UTF_8.name());

            helper.setTo(to);
            helper.setCc(new String[]{});
            helper.setBcc(new String[]{});
            helper.setSubject(emailDto.getSubject());
            helper.setText(emailDto.getMessage(), true);

            String messageId = "<" + UUID.randomUUID().toString() + "@makeprofiles.com>";
            message.setHeader("Message-ID", messageId);

            javaMailSender.send(message);

            saveMessageIdInDB(messageId, userId, emailDto.getToAddressList().stream().findFirst().get());

            status = true;
        } catch (Exception e) {
            logger.error("Service :: sendPasswordEmail :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: sendPasswordEmail :: Exited");
        return status;
    }

    @Override
    public boolean updateEmailPassword(EmailDto emailDto, Long userId) throws Exception {
        logger.debug("Service :: updateEmailPassword :: Entered");

        boolean status = false;

        String[] to = null;
        String[] cc = null;
        String[] bcc = null;
        try {
            if (Objects.nonNull(emailDto.getToAddressList()) && !emailDto.getToAddressList().isEmpty()) {
                to = emailDto.getToAddressList().stream().toArray(String[]::new);
            }

            MimeMessage message = javaMailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
                    StandardCharsets.UTF_8.name());

            helper.setTo(to);
            helper.setCc(new String[]{});
            helper.setBcc(new String[]{});
            helper.setSubject("Re: " + emailDto.getSubject());
            helper.setText(emailDto.getMessage(), true);

            UpdateUserPasswordEntity updatePasswordByUserId = updateUserPasswordRepository.findUpdatePasswordByUserId(userId);

            message.setHeader("In-Reply-To", updatePasswordByUserId.getMessageId());
            message.setHeader("References", updatePasswordByUserId.getMessageId());

            javaMailSender.send(message);

            //Update status in the DB
            updatePasswordByUserId.setUpdated(true);

            updateUserPasswordRepository.save(updatePasswordByUserId);

            updatePasswordByUserId = null;

            status = true;
        } catch (Exception e) {
            logger.error("Service :: updateEmailPassword :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: updateEmailPassword :: Exited");
        return status;
    }

    public void saveMessageIdInDB(String messageid, Long userId, String email) {
        logger.debug("Service :: saveMessageIdInDB :: Entered");

        try {

            UpdateUserPasswordEntity updateUserPassword = new UpdateUserPasswordEntity();

            updateUserPassword.setMessageId(messageid);
            updateUserPassword.setMailId(email);
            updateUserPassword.setUserId(userId);
            updateUserPassword.setUpdated(false);

            updateUserPasswordRepository.save(updateUserPassword);
            updateUserPassword = null;

        } catch (Exception e) {
            logger.error("Service :: saveMessageIdInDB :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: saveMessageIdInDB :: Exited");

    }


}