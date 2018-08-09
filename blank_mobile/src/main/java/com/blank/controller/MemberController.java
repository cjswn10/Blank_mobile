
package com.blank.controller;

import java.util.HashMap;
import java.util.Map;

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
import com.blank.vo.MemberVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberDao dao;

	public void setDao(MemberDao dao) {
		this.dao = dao;
	}



	//留덉씠�럹�씠吏�
	@RequestMapping(value="/member/myPage.do")
	public ModelAndView myPage() {
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	

	//怨꾩젙李얘린
	@RequestMapping(value="search.do")
	public ModelAndView search() {
			
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	


	//id李얘린
	@RequestMapping(value="searchIdPage.do")
	public ModelAndView searchId() {
				
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	//鍮꾨�踰덊샇 李얘린
	@RequestMapping(value="searchPwdPage.do")
	public ModelAndView searchPwd() {
					
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	//�븘�씠�뵒 李얘린
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
	
	//鍮꾨�踰덊샇 李얘린
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
	
	//臾몄쓽�궗�빆(contact)
	@RequestMapping(value="/member/qNa.do")
	public ModelAndView Qna() {
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}


	//濡쒓렇�븘�썐
	@RequestMapping(value="/member/logOut.do")
	public ModelAndView logOut(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:/login.do");
		return mav;
	}
	

	//�쉶�썝媛��엯
	@RequestMapping(value="join.do", method=RequestMethod.GET)	
	public void joinForm() {
		
	}
	
	@RequestMapping(value="join.do", method=RequestMethod.POST)
	public ModelAndView joinSubmit(MemberVo mv) {
		ModelAndView mav = new ModelAndView("redirect:/login.do");
		mv.setMno(dao.memberNextMno());
		int re = dao.memberInsert(mv);
		if (re < 1) {

			mav.addObject("msg", "�쉶�썝 媛��엯 �떎�뙣");
			mav.setViewName("/member/error");
		}
		return mav;
	}
	

	//�븘�씠�뵒 以묐났�솗�씤
	@RequestMapping(value="checkId.do")
	@ResponseBody
	public String checkId(@RequestParam("id")String id) {
		
		Map map = new HashMap();
		map.put("id", id);
		int rowcount = dao.memberCheckId(map);
        return String.valueOf(rowcount);

	
	}
	
	@RequestMapping(value="/member/checkId2.do")
	@ResponseBody
	public String checkId2(@RequestParam("id")String id,HttpSession session) {
		
		Map map = new HashMap();
		map.put("id", id);
		int rowcount = dao.memberCheckId(map);
        return String.valueOf(rowcount);
        
	
	}
	

	//濡쒓렇�씤
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public void loginForm() {
		
	}
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public ModelAndView login(String id, String pwd, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("pwd", pwd);
		
		Boolean r = dao.login(map);
		if (r == true) {

			//id, �쉶�썝踰덊샇 �꽭�뀡 �깮�꽦
			session.setAttribute("id", id);
			session.setAttribute("mno", dao.mno(map));
			mav.setViewName("redirect:/member/main.do");
		}

		//mav.setViewName("redirect:/member/main.do");
		return mav;
	}

	//�쉶�썝�젙蹂� �닔�젙 �떆 鍮꾨�踰덊샇 �솗�씤
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

			mav.addObject("msg", "鍮꾨�踰덊샇媛� �씪移섑븯吏� �븡�뒿�땲�떎.");
		}	
		
		return mav;
	}
	

	//�쉶�썝�젙蹂� �닔�젙
	@RequestMapping(value="/member/updateMember.do", method=RequestMethod.GET)
	public void memberUpdateForm() {
		
	}
	
	@RequestMapping(value="/member/updateMember.do", method=RequestMethod.POST)
	public ModelAndView memberUpdate(MemberVo mv) {
		
		ModelAndView mav = new ModelAndView("redirect:/member/myPage.do");
		
		int re = dao.updateMember(mv);
		if (re < 1) {
			mav.addObject("msg", "�쉶�썝�젙蹂� �닔�젙 �떎�뙣");
			mav.setViewName("/member/error");
		}
		
		return mav;
	}
	
	//�븘�씠�뵒 寃��깋(移쒓뎄�씪湲곗옣)
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
	
	//�쉶�썝踰덊샇濡� id�븣�븘�궡湲�
	@RequestMapping(value="/member/getId.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String getIdByMno(int mno) {
		Map map = new HashMap();
		map.put("mno", mno);
		String id = dao.getMember(map).getId();
		return id;
	}
}

