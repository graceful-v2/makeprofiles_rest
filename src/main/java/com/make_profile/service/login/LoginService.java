package com.make_profile.service.login;

import com.make_profile.dto.login.LoginDto;
import com.make_profile.dto.user.UserDto;
import com.make_profile.exception.MakeProfileException;

public interface LoginService {

	UserDto userLogin(LoginDto loginDto) throws MakeProfileException;

}
