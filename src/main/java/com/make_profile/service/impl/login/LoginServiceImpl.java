package com.make_profile.service.impl.login;

import java.util.Objects;

import org.eclipse.persistence.sessions.coordination.Command;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.make_profile.configuration.PasswordEncryptor;
import com.make_profile.dto.login.LoginDto;
import com.make_profile.dto.user.UserDto;
import com.make_profile.entity.user.UserEntity;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.repository.user.UserRepository;
import com.make_profile.security.JwtUtil;
import com.make_profile.service.login.LoginService;
import com.make_profile.utility.CommonConstants;

@Service
public class LoginServiceImpl implements LoginService {

	private static final Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);

	@Autowired
	UserRepository userRepository;

	@Autowired
	ModelMapper modelMapper;

	@Autowired
	PasswordEncryptor passwordEncoder;

	@Override
	public UserDto userLogin(LoginDto loginDto) throws MakeProfileException {
		logger.debug("Service :: findByMobileNumber :: Exited");
		UserDto userDto = null;
		UserEntity userEntity = null;
		boolean googleStatus = false;
		boolean user = false;
		try {
			if (loginDto.getMobileNumber() != null) {
				userEntity = userRepository.findByMobileNumber(loginDto.getMobileNumber());
				if (loginDto.getMobileNumber().equals(userEntity.getMobileNumber())
						&& loginDto.getPassword().equals(passwordEncoder.decryptPassword(userEntity.getPassword()))) {
					userDto = modelMapper.map(userEntity, UserDto.class);
				}
			} else if (loginDto.getMobileNumber() == null) {
				userEntity = userRepository.findByUserName(loginDto.getUserName());
				if (userEntity == null) {
					user = true;
				} else {
					if (loginDto.getUserName().toLowerCase().equals(userEntity.getUserName())
							&& loginDto.getPassword().equals(passwordEncoder.decryptPassword(userEntity.getPassword()))
							&& !userEntity.getSignInAccess().equals("google")) {
						userDto = modelMapper.map(userEntity, UserDto.class);
					} else {
						googleStatus = true;
					}
				}
			}
			userEntity = null;
		} catch (Exception e) {
			logger.debug("Service :: userLogin :: Exception :: " + e.getMessage());
		}

		if (userDto == null) {

			if (googleStatus) {
				throw new MakeProfileException(CommonConstants.MP_0013);
			} else {
				if (user) {
					throw new MakeProfileException(CommonConstants.MP_0014);
				} else {
					throw new MakeProfileException(CommonConstants.MP_0005);
				}
			}
		}
		logger.debug("Service :: findByMobileNumber :: Exited");
		return userDto;
	}

}
