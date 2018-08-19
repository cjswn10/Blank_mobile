
package com.blank.controller;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
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



	//마이페이지 뷰
	@RequestMapping(value="/member/myPage.do")
	public ModelAndView myPage() {
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	

	//아이디,비밀번호 찾기 뷰
	@RequestMapping(value="search.do")
	public ModelAndView search() {
			
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	


	//id찾기 뷰 
	@RequestMapping(value="searchIdPage.do")
	public ModelAndView searchId() {
				
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	//pwd찾기 뷰
	@RequestMapping(value="searchPwdPage.do")
	public ModelAndView searchPwd() {
					
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	//아이디찾기
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
	
	//비밀번호 찾기
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


	//로그아웃
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
		l.setRecord("로그아웃");
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");

		Calendar today = Calendar.getInstance();
		
		String todays = format.format(today.getTime());
		
		l.setLdate(todays);
		
		int re = dao.logRecord(l);
		if(re > 0)
		{
			mav.addObject("msg", "성공");
			mav.setViewName("redirect:/member/main.do");
		}
		else
		{
			mav.addObject("msg", "실패");
			mav.setViewName("error");
		}
		mav.addObject("autoOut", autoOut);
		session.invalidate();
		mav.setViewName("redirect:/login.do");
		return mav;
	}
	

	//회원가입(GET)
	@RequestMapping(value="join.do", method=RequestMethod.GET)	
	public void joinForm() {
		
	}
	//회원가입(POST)
	@RequestMapping(value="join.do", method=RequestMethod.POST)
	public ModelAndView joinSubmit(MemberVo mv) {
		ModelAndView mav = new ModelAndView("redirect:/login.do");
		mv.setMno(dao.memberNextMno());
		int re = dao.memberInsert(mv);
		if (re < 1) {

			mav.addObject("msg", "占쎌돳占쎌뜚 揶쏉옙占쎌뿯 占쎈뼄占쎈솭");
			mav.setViewName("/member/error");
		}
		return mav;
	}
	

	//중복확인
	@RequestMapping(value="checkId.do")
	@ResponseBody
	public String checkId(@RequestParam("id")String id) {
		
		Map map = new HashMap();
		map.put("id", id);
		int rowcount = dao.memberCheckId(map);
        return String.valueOf(rowcount);

	
	}
	
	//메인 페이지 아이디검색(id중복체크)
	@RequestMapping(value="/member/checkId2.do")
	@ResponseBody
	public String checkId2(@RequestParam("id")String id,HttpSession session) {
		
		Map map = new HashMap();
		map.put("id", id);
		int rowcount = dao.memberCheckId(map);
        return String.valueOf(rowcount);
        
	
	}
	

	//로그인
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public void loginForm() {	
		
	}
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public ModelAndView login(String id, String pwd, HttpSession session,LogVo l,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("pwd", pwd);
		
		Boolean r = dao.login(map);
		if (r == true) {

			//id, 占쎌돳占쎌뜚甕곕뜇�깈 占쎄쉭占쎈�� 占쎄문占쎄쉐
			session.setAttribute("id", id);
			session.setAttribute("mno", dao.mno(map));
			mav.setViewName("redirect:/member/main.do");
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
		l.setRecord("로그인");
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");

		Calendar today = Calendar.getInstance();
		
		String todays = format.format(today.getTime());
		
		l.setLdate(todays);
		
		int re = dao.logRecord(l);
		if(re > 0)
		{
			mav.addObject("msg", "성공");
			mav.setViewName("redirect:/member/main.do");
		}
		else
		{
			mav.addObject("msg", "실패");
			mav.setViewName("error");
		}
		
		//로그인 하고 3시간5분 동안 페이지를 이동하지않으면 세션 삭제(즉, 자동 로그아웃)
		session.setMaxInactiveInterval(185*60);
		
		return mav;
	}

	//비밀번호찾기
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

			mav.addObject("msg", "아이디와 비밀번호를 확인해주세요.");
		}	
		
		return mav;
	}
	

	//회원정보 수정
	@RequestMapping(value="/member/updateMember.do", method=RequestMethod.GET)
	public void memberUpdateForm() {
		
	}
	
	@RequestMapping(value="/member/updateMember.do", method=RequestMethod.POST)
	public ModelAndView memberUpdate(MemberVo mv) {
		
		ModelAndView mav = new ModelAndView("redirect:/member/myPage.do");
		
		int re = dao.updateMember(mv);
		if (re < 1) {
			mav.addObject("msg", "회원수정에 실패하였습니다.");
			mav.setViewName("/member/error");
		}
		
		return mav;
	}
	
	//메인 아이디검색
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
	
	//아이디 가져오기
	@RequestMapping(value="/member/getId.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String getIdByMno(int mno) {
		Map map = new HashMap();
		map.put("mno", mno);
		String id = dao.getMember(map).getId();
		return id;
	}
}

