package com.make_profile.service.user;

import com.make_profile.dto.user.UserDto;
import com.make_profile.exception.MakeProfileException;

public interface UserService {

    UserDto createUser(UserDto userDto);

//	UserDto createGoogleUser(UserDto userDto);

    UserDto createGoogleUser(String username, String email, String reference);

    UserDto getUserByUserName(String userName);

    boolean updateUser(UserDto userDto, String userName) throws MakeProfileException;

    UserDto createUserWithResumeDetails(UserDto userDto);

    boolean updatePassword(UserDto userDto);

    UserDto updateUserDetailsByOAuthEmail(String userName, String email, String oldEmail, String reference);

}
