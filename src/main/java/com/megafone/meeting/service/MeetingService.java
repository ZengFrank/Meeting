package com.megafone.meeting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.megafone.meeting.maper.MeetingMapper;
import com.megafone.meeting.model.Meeting;

@Service
public class MeetingService {

	@Autowired
	private MeetingMapper meetingMapper;
	
	 public List<Meeting> getAll(Meeting meeting){
		return  meetingMapper.selectAll();
	 }
	 
	 
	 public void deleteById(Integer id){
		 meetingMapper.deleteByPrimaryKey(id);
	 }
	 
	 public void save(Meeting meeting){
		 if (meeting.getId() != null) {
			meetingMapper.updateByPrimaryKey(meeting);
		}else{
			meetingMapper.insert(meeting);
		}
	 }
}
