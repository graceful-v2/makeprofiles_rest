package com.make_profile.service.password;

import com.make_profile.dto.EmailDto;

public interface EmailService {

	boolean sendEmail(EmailDto emailDto) throws Exception;

	boolean sendPasswordEmail(EmailDto emailDto,Long userId) throws Exception;

	boolean updateEmailPassword(EmailDto emailDto,Long userId) throws Exception;

}