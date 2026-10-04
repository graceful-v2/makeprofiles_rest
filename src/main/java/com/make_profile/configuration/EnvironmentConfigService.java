package com.make_profile.configuration;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.make_profile.entity.common.EnvironmentEntity;
import com.make_profile.repository.common.EnvironmentRepository;
import com.make_profile.utility.CommonConstants;

@Component
public class EnvironmentConfigService {

	@Autowired
	private EnvironmentRepository environmentRepository;

	private String openAiKey;
	
	private String razorPayKey;
	
	private String razorPaySecret;

	public String getOpenAiKey() {
		return openAiKey;
	}

	public String getRazorPayKey() {
		return razorPayKey;
	}

	public String getRazorPaySecret() {
		return razorPaySecret;
	}

	@EventListener(ApplicationReadyEvent.class)
	public void loadKeys() {

		this.openAiKey = environmentRepository.getEnvironmentValueByKey("OPEN_AI");

		List<EnvironmentEntity> razorConfigs = environmentRepository.getRazorPayConfiguration();
		for (EnvironmentEntity entity : razorConfigs) {
			switch (entity.getEnvironmentKey()) {
			case CommonConstants.RAZOR_PAY_KEY -> this.razorPayKey = entity.getEnvironmentValue();
			case CommonConstants.RAZOR_PAY_SECRET -> this.razorPaySecret = entity.getEnvironmentValue();
			}
		}

	}

}
