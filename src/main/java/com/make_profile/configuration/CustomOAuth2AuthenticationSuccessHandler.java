package com.make_profile.configuration;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Objects;

import com.make_profile.controller.login.LoginController;
import com.make_profile.entity.common.EnvironmentEntity;
import com.make_profile.utility.CommonConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import jakarta.servlet.http.Cookie;

import com.make_profile.dto.user.UserDto;
import com.make_profile.security.JwtUtil;
import com.make_profile.service.user.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomOAuth2AuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    JwtUtil jwtUtil;

    @Autowired
    @Lazy
    UserService userService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {

        final Logger logger = LoggerFactory.getLogger(CustomOAuth2AuthenticationSuccessHandler.class);


        UserDto GoogleUser = null;

        try {
            OAuth2AuthenticationToken oauth2Token = (OAuth2AuthenticationToken) authentication;

            String username = (String) oauth2Token.getPrincipal().getAttributes().get("name");
            String email = (String) oauth2Token.getPrincipal().getAttributes().get("email");

            String token = jwtUtil.generateTokenGoogle(email);

            if (email == null) {
                email = "Email not available";
            }
            String redirectUri = null;
            String reference = null;
            String oldEmail = null;
            String update_password_flag = null;


            if (request.getCookies() != null) {
                for (Cookie cookie : request.getCookies()) {
                    if ("redirect_uri".equals(cookie.getName())) {
                        redirectUri = java.net.URLDecoder.decode(cookie.getValue(), java.nio.charset.StandardCharsets.UTF_8);
                    } else if ("reference".equals(cookie.getName())) {
                        reference = java.net.URLDecoder.decode(cookie.getValue(), java.nio.charset.StandardCharsets.UTF_8);
                    } else if ("password_flag".equals(cookie.getName())) {
                        update_password_flag = java.net.URLDecoder.decode(cookie.getValue(), java.nio.charset.StandardCharsets.UTF_8);
                    } else if ("email".equals(cookie.getName())) {
                        oldEmail = java.net.URLDecoder.decode(cookie.getValue(), java.nio.charset.StandardCharsets.UTF_8);
                    }
                }
            }

            if (Objects.nonNull(update_password_flag) && update_password_flag.equals("false")) {
                GoogleUser = userService.updateUserDetailsByOAuthEmail(username, email, oldEmail, reference);
            } else {
                GoogleUser = userService.createGoogleUser(username, email, reference);
            }

            if (redirectUri != null && !redirectUri.isEmpty()) {
                response.sendRedirect(redirectUri + "?token=" + token + "&username=" + String.valueOf(GoogleUser.getUserName()) + "&email=" + email + "&id=" + String.valueOf(GoogleUser.getId()));
            } else {
                response.sendRedirect("https://localhost:4200/#/candidate");
            }

        } catch (Exception e) {
            logger.error("Component:: Oauth :: " + e.getMessage());
        }


    }

}
