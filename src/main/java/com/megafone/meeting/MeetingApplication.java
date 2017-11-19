package com.megafone.meeting;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@EnableWebMvc
@SpringBootApplication
@MapperScan(basePackages ="com.megafone.meeting.maper")
public class MeetingApplication extends WebMvcConfigurerAdapter implements CommandLineRunner {

	private Logger logger = LoggerFactory.getLogger(MeetingApplication.class);
	
	public static void main(String[] args) {
		SpringApplication.run(MeetingApplication.class, args);
	}

	@Override
	public void run(String... arg0) throws Exception {
		 logger.info("服务启动完成!");
		
	}
}
