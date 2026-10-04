package com.make_profile.controller.forgotPassword;

import com.make_profile.dto.password.UpdateUserPasswordDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.make_profile.controller.BaseController;
import com.make_profile.dto.password.PasswordResetTokenDto;
import com.make_profile.service.forgotpassword.ForgotPasswordService;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/forgot-password")
public class ForgotPasswordController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(ForgotPasswordController.class);

    @Autowired
    ForgotPasswordService forgotPasswordService;

    @PostMapping("/users")
    public ResponseEntity<?> forgotPassword(@RequestBody PasswordResetTokenDto passwordResetTokenDto,
                                            HttpServletRequest request) throws Exception {
        logger.debug("Controller :: forgotPassword :: Entered");

        PasswordResetTokenDto resetTokenDto = forgotPasswordService.sendPasswordResetToken(passwordResetTokenDto,
                request);

        logger.debug("Controller :: forgotPassword :: Exited");
        if (resetTokenDto != null) {
            return new ResponseEntity<>(resetTokenDto, HttpStatus.OK);
        }
        return new ResponseEntity<>(resetTokenDto, HttpStatus.BAD_REQUEST);
    }

    @PostMapping("/verify-otp")
    public ResponseEntity<?> verifyOtp(@RequestBody PasswordResetTokenDto passwordResetTokenDto) {
        logger.debug("Controller :: verifyOtp :: Entered");

        boolean status = forgotPasswordService.verifyOtp(passwordResetTokenDto);

        logger.debug("Controller :: verifyOtp :: Exited");
        if (!status) {
            return new ResponseEntity<>(status, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(status, HttpStatus.OK);

    }

    @PutMapping("/update-password")
    public ResponseEntity<?> updateNewPassword(@RequestBody PasswordResetTokenDto passwordResetTokenDto) {
        logger.debug("Controller :: updateNewPassword :: Entered");

        boolean updatPassword = forgotPasswordService.updatPassword(passwordResetTokenDto);

        logger.debug("Controller :: updateNewPassword :: Exited");
        if (!updatPassword) {
            return new ResponseEntity<>(updatPassword, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(updatPassword, HttpStatus.OK);

    }

    @GetMapping("/send-credentials")
    public ResponseEntity<?> sendCredentialsToUserMail(@RequestHeader Long userId) {
        logger.debug("Controller :: sendCredentialsToUserMail :: Entered");

        boolean sendEmail = forgotPasswordService.sendCredentialsToUserMail(userId);

        logger.debug("Controller :: sendCredentialsToUserMail :: Exited");

        if (!sendEmail) {
            return new ResponseEntity<>(sendEmail, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(sendEmail, HttpStatus.OK);

    }

    @PostMapping("/update-user")
    public ResponseEntity<?> updateUserPassword(@RequestBody UpdateUserPasswordDto updateUserPasswordDto) {
        logger.debug("Controller :: updateUserPassword :: Entered");

        boolean updateUserPassword = forgotPasswordService.updateUserPassword(updateUserPasswordDto);

        logger.debug("Controller :: updateUserPassword :: Exited");

        if (!updateUserPassword) {
            return new ResponseEntity<>(updateUserPassword, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(updateUserPassword, HttpStatus.OK);

    }

}
