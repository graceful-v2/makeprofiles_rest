package com.make_profile.service.forgotpassword;

import com.make_profile.dto.password.PasswordResetTokenDto;

import com.make_profile.dto.password.UpdateUserPasswordDto;
import jakarta.servlet.http.HttpServletRequest;

public interface ForgotPasswordService {

	PasswordResetTokenDto sendPasswordResetToken(PasswordResetTokenDto passwordResetTokenDto, HttpServletRequest request) throws Exception;

	boolean verifyOtp(PasswordResetTokenDto passwordResetTokenDto);

	boolean updatPassword(PasswordResetTokenDto passwordResetTokenDto);

	boolean sendCredentialsToUserMail(Long userId);

	boolean updateUserPassword(UpdateUserPasswordDto updateUserPasswordDto);
	
}
