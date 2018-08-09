package com.blank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.blank.dao.MainDao;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MainController {

	@Autowired
	private MainDao dao;

	public void setDao(MainDao dao) {
		this.dao = dao;
	}
	@RequestMapping("/member/main.do")
	public void main() {
		
	}
	
	@RequestMapping(value="/member/mainList.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String list()
	{
		String str = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(dao.list());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return str;
	}
	
	
}
