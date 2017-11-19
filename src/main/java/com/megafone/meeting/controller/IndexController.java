package com.megafone.meeting.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.megafone.meeting.model.Meeting;
import com.megafone.meeting.service.MeetingService;

@Controller
@RequestMapping("/index")
public class IndexController {
	
	@Autowired
	private MeetingService meetingService;
	
	@RequestMapping
	public ModelAndView  goIndex(){
		ModelAndView  result = new ModelAndView("meetings");
		return result;
	}

	
}
