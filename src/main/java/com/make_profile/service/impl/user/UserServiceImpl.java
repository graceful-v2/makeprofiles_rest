package com.make_profile.service.impl.user;

import java.util.Objects;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.make_profile.configuration.PasswordEncryptor;
import com.make_profile.dto.user.UserDto;
import com.make_profile.entity.user.UserEntity;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.repository.user.UserRepository;
import com.make_profile.service.user.UserService;
import com.make_profile.utility.CommonConstants;

@Service
public class UserServiceImpl implements UserService {
    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    UserRepository userRepository;

    @Autowired
    PasswordEncryptor passwordEncoder;

    @Override
    public UserDto createUser(UserDto userDto) {
        logger.debug("Service :: createUser :: Entered");
        UserEntity makeProfileUserEntity = null;
        UserEntity userEntity = null;
        UserDto user = null;
        try {
            if (userRepository.findByMobileNumberAndEmail(userDto.getMobileNumber(), userDto.getEmail()) == 0) {
                if (userDto.getSignInAccess() == null) {
                    userDto.setSignInAccess("LoginUser");
                }
                userDto.setUserName(userDto.getUserName().toLowerCase());
                userDto.setPassword(passwordEncoder.encryptPassword(userDto.getPassword()));
                makeProfileUserEntity = convertUserDtoToUserEntity(userDto);
                userEntity = userRepository.save(makeProfileUserEntity);
                user = convertUserEntityToUserDto(userEntity);
            }
            makeProfileUserEntity = null;
            userEntity = null;
        } catch (Exception e) {
            logger.error("Service :: createUser :: Error " + e.getMessage());
        }
        logger.debug("Service :: createUser :: Exited");

        return user;
    }

    @Override
    public UserDto getUserByUserName(String userName) {

        try {

            UserEntity userEntity = userRepository.findByUserName(userName);
            String decrypt = passwordEncoder.decryptPassword(userEntity.getPassword());
            userEntity.setPassword(decrypt);

            return convertUserEntityToUserDto(userEntity);

        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public UserDto createGoogleUser(String userName, String email, String reference) {
        logger.debug("Service :: createGoogleUser :: Entered");

        UserDto userDto = null;
        UserEntity makeProfileUserEntity = null;
        UserEntity findByEmail = null;
        UserEntity userEntity = new UserEntity();
        try {
            findByEmail = userRepository.findByEmail(email);
            if (Objects.isNull(findByEmail)) {
                userEntity.setName(userName);
                userEntity.setEmail(email);
                userEntity.setSignInAccess("google");
                userEntity.setPassword(passwordEncoder.encryptPassword(userName));
                userEntity.setUserName(email);
                userEntity.setUpdatePassword(true);
                if (reference != null) {
                    userEntity.setReference(reference);
                }
                makeProfileUserEntity = userRepository.save(userEntity);
                userDto = convertUserEntityToUserDto(makeProfileUserEntity);
            } else {
                makeProfileUserEntity = userRepository.findByEmail(email);
                userDto = convertUserEntityToUserDto(makeProfileUserEntity);
            }
            userEntity = null;
            makeProfileUserEntity = null;
            findByEmail = null;
        } catch (Exception e) {
            logger.error("Service :: createGoogleUser :: Error " + e.getMessage());
        }
        logger.debug("Service :: createGoogleUser :: Exited");
        return userDto;
    }

    public UserDto convertUserEntityToUserDto(UserEntity userEntity) {

        UserDto userDetails = new UserDto();

        userDetails.setEmail(userEntity.getEmail());
        userDetails.setName(userEntity.getName());
        userDetails.setMobileNumber(userEntity.getMobileNumber());
        userDetails.setId(userEntity.getId());
        userDetails.setUserName(userEntity.getUserName());
        userDetails.setPassword(userEntity.getPassword());
        userDetails.setSignInAccess(userEntity.getSignInAccess());
        userDetails.setReference(userEntity.getReference());
        userDetails.setUpdatePassword(userEntity.isUpdatePassword());

        return userDetails;
    }

    public UserEntity convertUserDtoToUserEntity(UserDto userDto) {

        UserEntity userDetails = new UserEntity();

        userDetails.setEmail(userDto.getEmail());
        userDetails.setName(userDto.getName());
        userDetails.setMobileNumber(userDto.getMobileNumber());
        userDetails.setId(userDto.getId());
        userDetails.setUserName(userDto.getUserName());
        userDetails.setPassword(userDto.getPassword());
        userDetails.setSignInAccess(userDto.getSignInAccess());
        userDetails.setReference(userDto.getReference());

        return userDetails;
    }

    @Override
    public boolean updateUser(UserDto userDto, String userName) throws MakeProfileException {
        logger.debug("Service :: updateUser :: Entered");

        boolean status = false;
        UserEntity userEntity = null;
        Boolean isMobileAvailable = false;
        Boolean isEmailAvailable = false;
        Boolean sameMobile = false;
        Boolean sameEmail = false;
        try {
            UserEntity findByUserName = userRepository.findByUserName(userName);

            if (Objects.nonNull(findByUserName)) {

                sameMobile = findByUserName.getMobileNumber().equals(userDto.getMobileNumber());
                sameEmail = findByUserName.getEmail().equals(userDto.getEmail());

                if (sameMobile && sameEmail) {
                    userEntity = convertUserDtoToUserEntity(userDto);
                } else if (sameMobile) {
                    if (userRepository.getUserByEmail(userDto.getEmail()) == 0) {
                        userEntity = convertUserDtoToUserEntity(userDto);
                    } else {
                        throw new MakeProfileException(CommonConstants.MP_0011);
                    }
                } else if (sameEmail) {
                    if (userRepository.getUserByMobileNumber(userDto.getMobileNumber()) == 0) {
                        userEntity = convertUserDtoToUserEntity(userDto);
                    } else {
                        throw new MakeProfileException(CommonConstants.MP_0010);
                    }
                } else {
                    isMobileAvailable = userRepository.getUserByMobileNumber(userDto.getMobileNumber()) == 0;
                    isEmailAvailable = userRepository.getUserByEmail(userDto.getEmail()) == 0;

                    if (isMobileAvailable && isEmailAvailable) {
                        userEntity = convertUserDtoToUserEntity(userDto);
                    } else if (!isMobileAvailable) {
                        throw new MakeProfileException(CommonConstants.MP_0010);
                    } else {
                        throw new MakeProfileException(CommonConstants.MP_0011);
                    }
                }
            }

            userEntity.setPassword(passwordEncoder.encryptPassword(userEntity.getPassword()));
            userRepository.save(userEntity);

            findByUserName = null;
            userEntity = null;
            sameEmail = null;
            isMobileAvailable = null;
            isEmailAvailable = null;
            sameMobile = null;

            status = true;
        } catch (MakeProfileException e) {
            logger.error("Service :: getResumeHtmlCode :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: updateUser :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: updateUser :: Exited");
        return status;
    }

    @Override
    public UserDto createUserWithResumeDetails(UserDto userDto) {
        logger.debug("Service :: createUserWithResumeDetails :: Entered");
        UserEntity makeProfileUserEntity = null;
        UserEntity userEntity = null;
        UserDto user = null;
        try {
            if (userRepository.findByMobileNumberAndEmail(userDto.getMobileNumber(), userDto.getEmail()) == 0) {

                userDto.setSignInAccess("LoginUser");

                userDto.setUserName(userDto.getMobileNumber());
                userDto.setPassword(passwordEncoder.encryptPassword(userDto.getMobileNumber()));
                makeProfileUserEntity = convertUserDtoToUserEntity(userDto);
                userEntity = userRepository.save(makeProfileUserEntity);
                user = convertUserEntityToUserDto(userEntity);

                user.setPassword(userDto.getUserName().toLowerCase());
            }
            makeProfileUserEntity = null;
            userEntity = null;
        } catch (Exception e) {
            logger.error("Service :: createUserWithResumeDetails :: Error " + e.getMessage());
        }
        logger.debug("Service :: createUserWithResumeDetails :: Exited");
        return user;

    }

    @Override
    public boolean updatePassword(UserDto userDto) {
        logger.debug("Service :: updatePassword :: Entered");

        boolean status = false;
        try {

            UserEntity users = userRepository.findById(userDto.getId()).get();
            users.setPassword(passwordEncoder.encryptPassword(userDto.getPassword()));
            users.setUpdatePassword(true);

            userRepository.save(users);
            users = null;

            status = true;
        } catch (Exception e) {
            logger.error("Service :: updatePassword :: Error " + e.getMessage());
        }
        logger.debug("Service :: updatePassword :: Exited");
        return status;
    }

    @Override
    public UserDto updateUserDetailsByOAuthEmail(String userName, String email, String oldEmail, String reference) {
        logger.debug("Service :: updateUserDetailsByOAuthEmail :: Entered");

        UserDto userDto = null;
        UserEntity makeProfileUserEntity = null;
        UserEntity findByEmail = null;
        UserEntity userEntity = new UserEntity();
        try {
            findByEmail = userRepository.findByEmail(oldEmail);
            if (Objects.nonNull(findByEmail)) {
                userEntity.setName(userName);
                userEntity.setEmail(email);
                userEntity.setSignInAccess("google");
                userEntity.setPassword(passwordEncoder.encryptPassword(userName));
                userEntity.setUserName(email);
                userEntity.setUpdatePassword(true);
                if (reference != null) {
                    userEntity.setReference(reference);
                }
                makeProfileUserEntity = userRepository.save(userEntity);
                userDto = convertUserEntityToUserDto(makeProfileUserEntity);
            } else {
                makeProfileUserEntity = userRepository.findByEmail(email);
                userDto = convertUserEntityToUserDto(makeProfileUserEntity);
            }
            userEntity = null;
            makeProfileUserEntity = null;
            findByEmail = null;
        } catch (Exception e) {
            logger.error("Service :: updateUserDetailsByOAuthEmail :: Error " + e.getMessage());
        }
        logger.debug("Service :: updateUserDetailsByOAuthEmail :: Exited");
        return userDto;
    }

}
