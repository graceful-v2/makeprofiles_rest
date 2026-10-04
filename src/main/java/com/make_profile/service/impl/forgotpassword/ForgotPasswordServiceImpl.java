package com.make_profile.service.impl.forgotpassword;

import java.time.LocalDateTime;

import java.util.*;

import com.make_profile.dto.password.UpdateUserPasswordDto;
import com.make_profile.entity.password.UpdateUserPasswordEntity;
import com.make_profile.repository.password.UpdateUserPasswordRepository;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.make_profile.configuration.PasswordEncryptor;
import com.make_profile.dto.EmailDto;
import com.make_profile.dto.password.PasswordResetTokenDto;
import com.make_profile.entity.password.PasswordResetTokenEntity;
import com.make_profile.entity.user.UserEntity;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.repository.password.PasswordResetTokenRepository;
import com.make_profile.repository.user.UserRepository;
import com.make_profile.service.forgotpassword.ForgotPasswordService;
import com.make_profile.service.password.EmailService;
import com.make_profile.utility.CommonUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import jakarta.servlet.http.HttpServletRequest;

@Service
public class ForgotPasswordServiceImpl implements ForgotPasswordService {

    private static final Logger logger = LoggerFactory.getLogger(ForgotPasswordServiceImpl.class);

    @Autowired
    Configuration configuration;

    @Autowired
    UserRepository userRepository;

    @Autowired
    CommonUtils commonUtils;

    @Autowired
    PasswordEncryptor passwordEncoder;

    @Autowired
    PasswordResetTokenRepository passwordResetTokenRepository;

    @Autowired
    EmailService emailService;

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    UpdateUserPasswordRepository updateUserPasswordRepository;

    @Override
    public PasswordResetTokenDto sendPasswordResetToken(PasswordResetTokenDto passwordResetTokenDto, HttpServletRequest request) throws Exception {
        logger.debug("Service :: sendPasswordResetToken :: Entered");

        PasswordResetTokenDto resetTokenDto = null;
        EmailDto emailDto = new EmailDto();
        List<String> toAddressList = new ArrayList<>();
        List<String> ccAddressList = new ArrayList<>();
        Map<String, String> variables = new HashMap<>();
        Template template = null;
        try {

            UserEntity userEntity = userRepository.findByEmail(passwordResetTokenDto.getEmail());

            if (Objects.isNull(userEntity)) {
                throw new MakeProfileException("User not found");
            }
            String otp = commonUtils.generateOtp();
            PasswordResetTokenEntity passwordResetTokenEntity = new PasswordResetTokenEntity();
            passwordResetTokenEntity.setOtp(otp);
            passwordResetTokenEntity.setExpiryDate(LocalDateTime.now().plusMinutes(10));
            passwordResetTokenEntity.setUserId(userEntity);
            passwordResetTokenRepository.save(passwordResetTokenEntity);

            variables.put("recipientName", userEntity.getName());
            variables.put("otp", otp);

            template = configuration.getTemplate("reset_password_mail.ftl");

            String htmlBody = FreeMarkerTemplateUtils.processTemplateIntoString(template, variables);

            toAddressList.add(userEntity.getEmail());
            emailDto.setToAddressList(toAddressList);
            emailDto.setCcList(ccAddressList);
            emailDto.setSubject("Make Profiles - Reset Password");
            emailDto.setMessage(htmlBody);
            emailService.sendEmail(emailDto);

            resetTokenDto = modelMapper.map(passwordResetTokenEntity, PasswordResetTokenDto.class);
            otp = null;
        } catch (Exception e) {
            logger.error("Service :: sendPasswordResetToken :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: sendPasswordResetToken :: Exited");
        return resetTokenDto;
    }

    @Override
    public boolean verifyOtp(PasswordResetTokenDto passwordResetTokenDto) {
        logger.debug("Service :: verifyOtp :: Entered");

        boolean status = false;
        UserEntity userEntity = null;

        userEntity = userRepository.findByEmail(passwordResetTokenDto.getEmail());
        try {
            PasswordResetTokenEntity byUserId = passwordResetTokenRepository.findLastUserId(userEntity.getId());
            if (byUserId.getOtp().equals(passwordResetTokenDto.getOtp()) && !byUserId.getExpiryDate().isBefore(LocalDateTime.now())) {
                status = true;
                passwordResetTokenRepository.deleteById(byUserId.getId());
            }
        } catch (Exception e) {
            logger.error("Service :: verifyOtp :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: verifyOtp :: Exited");
        return status;
    }

    @Override
    public boolean updatPassword(PasswordResetTokenDto passwordResetTokenDto) {
        logger.debug("Service :: updatPassword :: Entered");

        boolean status = false;
        try {
            UserEntity userEntity = userRepository.findByEmail(passwordResetTokenDto.getEmail());

            if (userEntity != null) {
                userEntity.setPassword(passwordEncoder.encryptPassword(passwordResetTokenDto.getPassword()));
                userRepository.save(userEntity);
                status = true;
            }
        } catch (Exception e) {
            logger.error("Service :: updatPassword :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: updatPassword :: Exited");
        return status;
    }

    @Override
    public boolean sendCredentialsToUserMail(Long userId) {
        logger.debug("Service :: sendCredentialsToUserMail :: Entered");

        boolean status = false;
        try {
            UserEntity userEntity = userRepository.findById(userId).get();
            String password = passwordEncoder.decryptPassword(userEntity.getPassword());

            EmailDto emailDto = new EmailDto();
            emailDto.setSubject("Your make profile account has been created");

            String changePasswordLink = "https://www.makeprofiles.com/update-user-password/" + userEntity.getUserName();


            String message = """
                    Dear %s,<br><br>
                    Your account has been created successfully.<br><br>
                    
                    <strong>Login Credentials:</strong><br>
                    Username: %s<br>
                    Password: %s<br><br>
                    
                    <a href='%s'
                       style='color:#0d6efd;
                              font-weight:bold;
                              padding:10px 20px;
                              background:rgb(229, 222, 222);
                              border-radius:50px;
                              text-decoration:none;'>
                       Click here to change your password
                    </a>
                    <br><br>
                    
                    Regards,<br>
                    Make Profiles Support Team<br>
                    contact@gracefultechnologies.com
                    """.formatted(userEntity.getName(), userEntity.getUserName(), password, changePasswordLink);


            emailDto.setMessage(message);
            emailDto.setToAddressList(new ArrayList<>(Arrays.asList(userEntity.getEmail())));

            return emailService.sendPasswordEmail(emailDto, userId);

        } catch (Exception e) {
            logger.error("Service :: sendCredentialsToUserMail :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: sendCredentialsToUserMail :: Exited");
        return status;
    }

    @Override
    public boolean updateUserPassword(UpdateUserPasswordDto updateUserPasswordDto) {
        logger.debug("Service :: updateUserPassword :: Entered");

        boolean status = false;
        EmailDto emailDto = new EmailDto();
        try {
            UserEntity userEntity = userRepository.findByUserName(updateUserPasswordDto.getUserName());

            UpdateUserPasswordEntity updatePasswordByUserId = updateUserPasswordRepository.findUpdatePasswordByUserId(userEntity.getId());

            if (!updatePasswordByUserId.isUpdated()) {
                userEntity.setPassword(passwordEncoder.encryptPassword(updateUserPasswordDto.getPassword()));

                userRepository.save(userEntity);


                emailDto.setSubject("Your make profile account has been created");


                String message = """
                        Dear %s,<br><br>
                        
                        Your password has been updated successfully.<br><br>
                        
                        <strong>Login Credentials:</strong><br>
                        Username: %s<br>
                        Password: %s<br><br>
                        
                        For security reasons, please keep your credentials confidential.<br><br>
                        
                        Regards,<br>
                        Make Profiles Support Team<br>
                        contact@gracefultechnologies.com
                        """.formatted(userEntity.getName(), userEntity.getUserName(), updateUserPasswordDto.getPassword());


                emailDto.setMessage(message);
                emailDto.setToAddressList(new ArrayList<>(Arrays.asList(userEntity.getEmail())));

                // sent the updated password email
                emailService.updateEmailPassword(emailDto, userEntity.getId());

                status = true;
            }

            userEntity = null;
            updatePasswordByUserId = null;

        } catch (Exception e) {
            logger.error("Service :: updateUserPassword :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: updateUserPassword :: Exited");
        return status;
    }

}
