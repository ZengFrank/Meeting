package com.megafone.meeting.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


import com.megafone.meeting.model.Meeting;
import com.megafone.meeting.service.MeetingService;

@RestController
@RequestMapping("/meetings")
public class MeetingController {

	@Autowired
	private MeetingService meetingService;
	
	@RequestMapping	
	 public List<Meeting> getAll(Meeting meeting){
		 return meetingService.getAll(meeting);
	 }
	
	@RequestMapping(value = "/delete/{id}")
    public int delete(@PathVariable Integer id) {
        meetingService.deleteById(id);
        return 1;
    }

	
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public int save(Meeting country) {
        String msg = country.getId() == null ? "新增成功!" : "更新成功!";
        meetingService.save(country);
        return 1;
    }
}
