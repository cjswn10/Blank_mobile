package com.blank.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.blank.dao.MemberDao;
import com.blank.vo.LogVo;
import com.blank.vo.MemberVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberDao dao;

	public void setDao(MemberDao dao) {
		this.dao = dao;
	}


	//myPage
	@RequestMapping(value="/member/myPage.do")
	public ModelAndView myPage() {
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	

	//�뜝�룞�삕�뜝�룞�삕李얍뜝�룞�삕
	@RequestMapping(value="search.do")
	public ModelAndView search() {
			
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	


	//id李얍뜝�룞�삕 form
	@RequestMapping(value="searchIdPage.do")
	public ModelAndView searchId() {
				
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	//pwd李얍뜝�룞�삕 form
	@RequestMapping(value="searchPwdPage.do")
	public ModelAndView searchPwd() {
					
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	//id李얍뜝�룞�삕
	@RequestMapping(value="searchId.do")
	@ResponseBody
	public String searchId(String name,String phone)
	{
		Map map = new HashMap();
		map.put("name", name);
		map.put("phone", phone);
		String str = "";
		String id = dao.searchId(map);
		if(id != null)
		{
			str = id;
		}
		else
		{
			str = "";
		}	
		return str;
	}
	
	//pwd李얍뜝�룞�삕
	@RequestMapping(value="searchPwd.do")
	@ResponseBody
	public String searchPwd(String id,String phone)
	{
		Map map = new HashMap();
		map.put("id", id);
		map.put("phone", phone);
		String str = "";
		String pwd = dao.searchPwd(map);
		if(pwd != null)
		{
			str = pwd;
		}
		else
		{
			str = "";
		}	
		return str;
	}
	
	
	//qna(contact)
	@RequestMapping(value="/member/qNa.do")
	public ModelAndView Qna() {
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}


	//logout
	@RequestMapping(value="/member/logOut.do")
	public ModelAndView logOut(HttpSession session,LogVo l,HttpServletRequest request,String autoOut) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			
			String ip = request.getHeader("X-FORWARDED-FOR");
			//System.out.println("TEST : X-FORWARDED-FOR : "+ip);

			if (ip == null) {
				ip = request.getHeader("Proxy-Client-IP");
				//System.out.println("TEST : Proxy-Client-IP : "+ip);
			}

			if (ip == null) {
				ip = request.getHeader("WL-Proxy-Client-IP");
				//System.out.println("TEST : WL-Proxy-Client-IP : "+ip);
			}

			if (ip == null) {
				ip = request.getHeader("HTTP_CLIENT_IP");
				//System.out.println("TEST : HTTP_CLIENT_IP : "+ip);
			}

			if (ip == null) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
				//System.out.println("TEST : HTTP_X_FORWARDED_FOR : "+ip);

			}

			if (ip == null) {
				ip = request.getRemoteAddr();
			}
			
			l.setIp(ip);
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		String id = request.getParameter("id");
		
		l.setId(id);
		l.setRecord("logout");
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");

		Calendar today = Calendar.getInstance();
		
		String todays = format.format(today.getTime());
		
		l.setLdate(todays);
		
		int re = dao.logRecord(l);
		if(re > 0)
		{
			mav.addObject("msg", "success");
			mav.setViewName("redirect:/member/main.do");
		}
		else
		{
			mav.addObject("msg", "fail");
			mav.setViewName("error");
		}
		
		
		/**
		 * �뜝�떥洹몄븘�슱�삕 �뜝�룞�삕 rImg �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕
		 */
		String FilePath = request.getRealPath("/resources/rImg");
		File FileList = new File(FilePath);

		String fileList[] = FileList.list();

		for(int i = 0; i < fileList.length; i++){
		  String FileName = fileList[i];
		  
		  //�뜝�떛紐뚯삕�뜝�룞�삕 RPlot�뜝�룞�삕 �뜝�룞�삕雍됵옙 �뜝�룞�삕�뜝�떦�벝�삕 �뜝�룞�삕�뜝�룞�삕
		  if(FileName.contains("RPlot")){
		    File deleteFile = new File(FilePath + "/" + FileName);
		    deleteFile.delete();
		  }
		}
		
		mav.addObject("autoOut", autoOut);
		session.invalidate();
		mav.setViewName("redirect:/login.do");
		return mav;
	}
	

	//join(GET)
	@RequestMapping(value="join.do", method=RequestMethod.GET)	
	public void joinForm() {
		
	}
	//join(POST)
	@RequestMapping(value="join.do", method=RequestMethod.POST)
	public ModelAndView joinSubmit(MemberVo mv) {
		ModelAndView mav = new ModelAndView("redirect:/login.do");
		mv.setMno(dao.memberNextMno());
		int re = dao.memberInsert(mv);
		if (re < 1) {

			mav.addObject("msg", "success login");
			mav.setViewName("/member/error");
		}
		return mav;
	}
	

	//id �뜝�뙥釉앹삕�솗�뜝�룞�삕
	@RequestMapping(value="checkId.do")
	@ResponseBody
	public String checkId(@RequestParam("id")String id) {
		
		Map map = new HashMap();
		map.put("id", id);
		int rowcount = dao.memberCheckId(map);
        return String.valueOf(rowcount);

	
	}
	
	//main - search_id
	@RequestMapping(value="/member/checkId2.do")
	@ResponseBody
	public String checkId2(@RequestParam("id")String id,HttpSession session) {
		
		Map map = new HashMap();
		map.put("id", id);
		int rowcount = dao.memberCheckId(map);
        return String.valueOf(rowcount);
        
	}
	

	//login
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public void loginForm(HttpServletRequest request) {	
		
	}
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public ModelAndView login(String id, String pwd, HttpSession session,LogVo l,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("pwd", pwd);
		
		Boolean r = dao.login(map);

		
		if (r == true) {
				
			//id, mno  	session
			session.setAttribute("id", id);
			session.setAttribute("mno", dao.mno(map));
			//mav.setViewName("redirect:/member/main.do");
			mav.setViewName("redirect:/login.do");
			mav.addObject("result",r);
		}
		else
		{
			mav.setViewName("redirect:/login.do");
			mav.addObject("result",r);

		}
		
		try {
			
			String ip = request.getHeader("X-FORWARDED-FOR");
			//System.out.println("TEST : X-FORWARDED-FOR : "+ip);

			if (ip == null) {
				ip = request.getHeader("Proxy-Client-IP");
				//System.out.println("TEST : Proxy-Client-IP : "+ip);
			}

			if (ip == null) {
				ip = request.getHeader("WL-Proxy-Client-IP");
				//System.out.println("TEST : WL-Proxy-Client-IP : "+ip);
			}

			if (ip == null) {
				ip = request.getHeader("HTTP_CLIENT_IP");
				//System.out.println("TEST : HTTP_CLIENT_IP : "+ip);
			}

			if (ip == null) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
				//System.out.println("TEST : HTTP_X_FORWARDED_FOR : "+ip);
			}

			if (ip == null) {
				ip = request.getRemoteAddr();
			}
			
			l.setIp(ip);
			     
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		l.setId(id);
		l.setRecord("login");
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");

		Calendar today = Calendar.getInstance();
		
		String todays = format.format(today.getTime());
		
		l.setLdate(todays);
		
		int re = dao.logRecord(l);
		
		session.setMaxInactiveInterval(185*60);
		
		return mav;
	}

	//pwdCheck
  @RequestMapping(value="/member/pwdCheck.do", method=RequestMethod.GET)
	public void pwdCheckForm() {
		
	}
	
	
	@RequestMapping(value="/member/pwdCheck.do", method=RequestMethod.POST)
	public ModelAndView pwdCheck(String id, String pwd,int mno) {
		ModelAndView mav = new ModelAndView();
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("pwd", pwd);
		map.put("mno", mno);
		Boolean r = dao.login(map);
		if (r == true) {
			mav.setViewName("/member/updateMember");
			mav.addObject("m", dao.getMember(map));
		}
		else
		{
			mav.addObject("msg", "failed to update");
		}	
		
		return mav;
	}
	

	//updateMember
	@RequestMapping(value="/member/updateMember.do", method=RequestMethod.GET)
	public void memberUpdateForm() {
		
	}
	
	@RequestMapping(value="/member/updateMember.do", method=RequestMethod.POST)
	public ModelAndView memberUpdate(MemberVo mv) {
		
		ModelAndView mav = new ModelAndView("redirect:/member/myPage.do");
		
		int re = dao.updateMember(mv);
		if (re < 1) {
			mav.addObject("msg", "failed to update Member");
			mav.setViewName("/member/error");
		}
		
		return mav;
	}
	
	//Search Id in main
	@RequestMapping(value="/member/mainSearchId.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String mainSearchId(String id,HttpSession session)
	{
		Map map = new HashMap();
		map.put("id", id);
		String str = "";
		try {
			
			ObjectMapper mapper = new ObjectMapper();
			if(id != "")
			{
				str = mapper.writeValueAsString(dao.mainSearchId(map)); 
			}
			else
			{
				str = "";
			}
			
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	//getIdByMno
	@RequestMapping(value="/member/getId.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String getIdByMno(int mno) {
		Map map = new HashMap();
		map.put("mno", mno);
		String id = dao.getMember(map).getId();
		return id;
	}
}