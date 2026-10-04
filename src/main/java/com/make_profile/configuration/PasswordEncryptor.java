package com.make_profile.configuration;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncryptor extends BCryptPasswordEncoder {

	public String encryptPassword(String userPassword) {
		StringBuilder encryptPassword = new StringBuilder();
		for (int i = 0; i < userPassword.length(); i++) {
			encryptPassword = encryptPassword.append(userPassword.charAt(i)).append(i);
		}
		String password = encryptPassword.reverse().toString();
		encryptPassword = null;
		return password;
	}

	public String decryptPassword(String encryptedPassword) {
		StringBuilder reversed = new StringBuilder(encryptedPassword).reverse();
		StringBuilder originalPassword = new StringBuilder();
		int j = 2;
 		for (int i = 0; i < reversed.length() - 1; i += j) {
			originalPassword.append(reversed.charAt(i));
			if (i >= 19) {
				j = 3;
			}
		}
		return originalPassword.toString();
	}

}
