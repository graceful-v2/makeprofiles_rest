package com.make_profile.security;

import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.make_profile.service.impl.user.CustomUserDetailsService;

import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtFilter extends OncePerRequestFilter {

	@Autowired
	private JwtUtil jwtUtil;

	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {

		String path = request.getServletPath();

		if (path.equals("/profilev2rest/auth/login") || path.equals("/profilev2rest/user/create") || path.equals("/profilev2rest/forgot-password/users")
				|| path.equals("/profilev2rest/value-sets/search-by-code") || path.equals("/profilev2rest/cities/retrive-cities") || path.equals("/profilev2rest/candidate/by_mobile")){
			filterChain.doFilter(request, response);
			return;
		}

		String authHeader = request.getHeader("Authorization");

		if (authHeader == null || !authHeader.startsWith("Bearer ")) {
			filterChain.doFilter(request, response);
			return;
		}
		String token = authHeader.substring(7);

		if (isGoogleJwt(token)) {
			String username = extractEmailFromGoogleToken(token);
			List<GrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_USER"));
			UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(username, null,
					authorities);
			authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
			SecurityContextHolder.getContext().setAuthentication(authentication);
			filterChain.doFilter(request, response);
			return;
		}

		try {
			String name = jwtUtil.extractUsername(token);

			if (name != null && SecurityContextHolder.getContext().getAuthentication() == null) {
				UserDetails userDetails = customUserDetailsService.loadUserByUsername(name);

				UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
						userDetails.getUsername(), userDetails.getPassword(), userDetails.getAuthorities());
				authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
				SecurityContextHolder.getContext().setAuthentication(authenticationToken);

			}
		} catch (JwtException e) {
			Map<String, String> responseMap = new HashMap<>();
			responseMap.put("error", "Invalid Token");
			ObjectMapper objectMapper = new ObjectMapper();
			String jsonString = objectMapper.writeValueAsString(responseMap);

			response.getWriter().write(jsonString);
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			return;
		}
		filterChain.doFilter(request, response);
		return;
	}

	private boolean isGoogleJwt(String token) {
		try {
			String[] parts = token.split("\\.");
			if (parts.length != 3)
				return false;
			String headerJson = new String(java.util.Base64.getUrlDecoder().decode(parts[0]));
			return headerJson.contains("\"kid\"");
		} catch (Exception e) {
			return false;
		}
	}

	private String extractEmailFromGoogleToken(String token) {
		try {
			String[] parts = token.split("\\.");
			String payloadJson = new String(Base64.getDecoder().decode(parts[1]));
			JSONObject payload = new JSONObject(payloadJson);
			return payload.getString("email");
		} catch (Exception e) {
			return "google-user";
		}
	}
}