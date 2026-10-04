package com.make_profile.controller.user;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.make_profile.controller.BaseController;
import com.make_profile.dto.user.UserDto;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.security.JwtUtil;
import com.make_profile.service.user.UserService;
import com.make_profile.utility.CommonConstants;

@RestController
@RequestMapping("/user")
public class UserController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	UserService userService;

	@Autowired
	JwtUtil jwtUtil;

	@PostMapping("/create")
	public ResponseEntity<?> createUser(@RequestBody UserDto userDto,
			@RequestParam(name = "reference", required = false) String reference) {
		logger.debug("Controller :: createUser :: Entered");
		UserDto user = null;
		if (reference != null && !reference.isEmpty()) {
			userDto.setReference(reference);
		}
		user = userService.createUser(userDto);

		if (user != null) {
			String token = jwtUtil.generateToken(userDto.getUserName());
			user.setToken(token);
			user.setUserName(userDto.getUserName().toLowerCase());
			logger.debug("Controller :: createUser :: Exited");
			return new ResponseEntity<>(user, HttpStatus.OK);
		}
		return new ResponseEntity<>(buildResponse(CommonConstants.MP_0003), HttpStatus.BAD_REQUEST);
	}

	@GetMapping("/get_user/{userName}")
	public ResponseEntity<?> getUserByUserName(@PathVariable String userName) {
		logger.debug("Controller :: getUserByUserName :: Entered");

		UserDto user = userService.getUserByUserName(userName);

		logger.debug("Controller :: getUserByUserName :: Exited");
		return new ResponseEntity<>(user, HttpStatus.OK);

	}

	@PutMapping("/update_user/{userName}")
	public ResponseEntity<?> updateUser(@RequestBody UserDto userDto, @RequestHeader("username") String userName)
			throws MakeProfileException {
		logger.debug("Controller :: updateUser :: Entered");

		userDto.setUserName(userName);
		boolean status = userService.updateUser(userDto, userName);

		logger.debug("Controller :: updateUser :: Exited");

		if (!status) {
			return new ResponseEntity<>(buildResponse(CommonConstants.MP_0003), HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<>(buildResponse(CommonConstants.MP_0004), HttpStatus.OK);

	}

	@PostMapping("/create-by-resume")
	public ResponseEntity<?> createUserWithResumeDetails(@RequestBody UserDto userDto) {
		logger.debug("Controller :: createUserWithResumeDetails :: Entered");
		UserDto user = null;

		user = userService.createUserWithResumeDetails(userDto);

		if (user != null) {
			String token = jwtUtil.generateToken(userDto.getUserName());
			user.setToken(token);
			user.setUserName(userDto.getUserName().toLowerCase());
			logger.debug("Controller :: createUser :: Exited");
			return new ResponseEntity<>(user, HttpStatus.OK);
		}

		return new ResponseEntity<>(buildResponse(CommonConstants.MP_0017), HttpStatus.BAD_REQUEST);
	}

	@PutMapping("/update_password")
	public ResponseEntity<?> updatePassword(@RequestBody UserDto userDto, @RequestHeader("username") String userName)
			throws MakeProfileException {
		logger.debug("Controller :: updatePassword :: Entered");

		userDto.setUserName(userName);
		boolean status = userService.updatePassword(userDto);

		logger.debug("Controller :: updatePassword :: Exited");

		return new ResponseEntity<>(buildResponse(CommonConstants.MP_0004), HttpStatus.OK);

	}


}
