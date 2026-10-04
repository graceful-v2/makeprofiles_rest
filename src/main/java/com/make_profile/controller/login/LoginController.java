package com.make_profile.controller.login;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.make_profile.controller.BaseController;
import com.make_profile.dto.login.LoginDto;
import com.make_profile.dto.user.UserDto;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.security.JwtUtil;
import com.make_profile.service.login.LoginService;
import com.make_profile.utility.CommonConstants;

@RestController
@RequestMapping("/auth")
public class LoginController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	LoginService loginService;

	@Autowired
	JwtUtil jwtUtil;

	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody LoginDto loginDto) throws MakeProfileException {
		logger.debug("Controller :: login :: Entered");

		UserDto userDto = loginService.userLogin(loginDto);
		String token = jwtUtil.generateToken(userDto.getUserName());
		userDto.setToken(token);
		userDto.setUserName(userDto.getUserName().toLowerCase());

		logger.debug("Controller :: userLogin :: Exited");

		return new ResponseEntity<>(userDto, HttpStatus.OK);

	}

}
