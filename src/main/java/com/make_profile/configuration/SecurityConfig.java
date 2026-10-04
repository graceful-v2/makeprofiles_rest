package com.make_profile.configuration;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.make_profile.security.JwtFilter;
import com.make_profile.service.impl.user.CustomUserDetailsService;
import com.make_profile.configuration.CustomOAuth2AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    JwtFilter jwtFilter;

    @Autowired
    CustomOAuth2AuthenticationSuccessHandler customOAuth2AuthenticationSuccessHandler;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.cors().and().csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth.requestMatchers(new AntPathRequestMatcher("/auth/login"),
                        new AntPathRequestMatcher("/auth/google-login"), new AntPathRequestMatcher("/user/create"),
                        new AntPathRequestMatcher("/public/**"), new AntPathRequestMatcher("/oauth2/authorization/**"),
                        new AntPathRequestMatcher("/login/oauth2/code/google"),
                        new AntPathRequestMatcher("/forgot-password/users"),
                        new AntPathRequestMatcher("/forgot-password/update-password"),
                        new AntPathRequestMatcher("/forgot-password/verify-otp"),
                        new AntPathRequestMatcher("/value-sets/search-by-code"),
                        new AntPathRequestMatcher("/cities/retrive-cities"),
                        new AntPathRequestMatcher("/candidate/create"),
                        new AntPathRequestMatcher("/candidate/by_mobile"),
                        new AntPathRequestMatcher("/candidate/upload-image"),
                        new AntPathRequestMatcher("/open-ai/get-details"),
                        new AntPathRequestMatcher("/resume-ai/upload-resume"),
                        new AntPathRequestMatcher("/v3/api-docs/**"),
                        new AntPathRequestMatcher("/swagger-ui/**"),
                        new AntPathRequestMatcher("/swagger-ui.html"),
                        new AntPathRequestMatcher("/candidate/get-bytearray"),
                        new AntPathRequestMatcher("/candidate/check_mobile"),
                        new AntPathRequestMatcher("/job-category"),
                        new AntPathRequestMatcher("/user/create-by-resume"),
                        new AntPathRequestMatcher("/content/get-suggested-skills"),
                        new AntPathRequestMatcher("/templates/get-all"),
                        new AntPathRequestMatcher("/candidate/upload-image"),
                        new AntPathRequestMatcher("/forgot-password/update-user")).permitAll().anyRequest().authenticated())
                .oauth2Login(oauth -> oauth.successHandler(customOAuth2AuthenticationSuccessHandler))
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        http.addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailService() {
        return new CustomUserDetailsService();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailService());
        authProvider.setPasswordEncoder(passwordEncryptor());
        return authProvider;
    }

    @Bean
    public PasswordEncryptor passwordEncryptor() {
        return new PasswordEncryptor();
    }

    @Bean
    public AuthenticationManager authenticationManager() {
        return new ProviderManager(List.of(authenticationProvider()));
    }
}
