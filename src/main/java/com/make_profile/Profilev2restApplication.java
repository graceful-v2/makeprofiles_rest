package com.make_profile;

import java.time.Duration;

import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.make_profile.configuration.EnvironmentConfigService;
import com.make_profile.configuration.MakeProfileInterceptor;
import com.make_profile.repository.common.EnvironmentRepository;

@SpringBootApplication
public class Profilev2restApplication {

	@Autowired
	MakeProfileInterceptor makeProfileInterceptor;

	@Autowired
	EnvironmentRepository environmentRepository;

	@Autowired
	EnvironmentConfigService environmentConfigService;

//	private String openAiKey;

//	@PostConstruct
//	private void getOpenAiKeyFromDb() {
//
//		openAiKey = environmentRepository.getEnvironmentValueByKey("OPEN_AI");
//	}

	public static void main(String[] args) {
		SpringApplication.run(Profilev2restApplication.class, args);
	}

	@Bean
	ModelMapper modelMapper() {
		ModelMapper modelMapper = new ModelMapper();
		modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
		return modelMapper;
	}

	@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder) {
		RestTemplate restTemplate = builder.setConnectTimeout(Duration.ofSeconds(180))
				.setReadTimeout(Duration.ofSeconds(180)).build();
		restTemplate.getInterceptors().add((request, body, execution) -> {
			request.getHeaders().add("Authorization", "Bearer " + environmentConfigService.getOpenAiKey());
			return execution.execute(request, body);
		});
		return restTemplate;
	}

	@Bean
	FreeMarkerConfigurer freeMarkerConfigurer() {
		FreeMarkerConfigurer freeMarkerConfigurer = new FreeMarkerConfigurer();
		freeMarkerConfigurer.setTemplateLoaderPath("classpath:/resume-templates");
		return freeMarkerConfigurer;
	}

	@Bean
	WebMvcConfigurer configurer() {
		return new WebMvcConfigurer() {

			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedMethods("*").allowedOrigins("*");
			}

			@Override
			public void addInterceptors(InterceptorRegistry registry) {
				registry.addInterceptor(makeProfileInterceptor);
			}

		};
	}

	@Bean
	ThreadPoolTaskExecutor getThreadPoolTaskExecutor() {
		ThreadPoolTaskExecutor threadPoolTaskExecutor = new ThreadPoolTaskExecutor();
		threadPoolTaskExecutor.setCorePoolSize(100);
		threadPoolTaskExecutor.setThreadNamePrefix("make_profile_executor_thread");
		threadPoolTaskExecutor.initialize();
		return threadPoolTaskExecutor;
	}

}
