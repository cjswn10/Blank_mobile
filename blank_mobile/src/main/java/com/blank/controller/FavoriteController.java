package com.blank.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.blank.dao.FavoriteDao;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class FavoriteController {
	@Autowired
	private FavoriteDao dao;

	public void setDao(FavoriteDao dao) {
		this.dao = dao;
	}
	@RequestMapping("/member/favorite.do")
	public void listview()
	{
		
	}
	@RequestMapping(value="/member/insertFavorite.do", method=RequestMethod.POST)
	public ModelAndView insertFavorite(int mno, int fmno) {
		Map map = new HashMap();
		map.put("mno", mno);
		map.put("fmno", fmno);
		
		ModelAndView mav = new ModelAndView("redirect:/member/favorite.do");
		int re = dao.insertFavorite(map);
		if (re > 0) {
			mav.addObject("re", re);
		}else {
			mav.addObject("msg","즐겨찾기 추가 실패");
			mav.setViewName("/member/error");		
		}		
		return mav;
	}
	
	@RequestMapping(value="/member/listFavorite.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String list(int mno, HttpSession session)
	{			
		session.setAttribute("mno", mno);		
		Map map = new HashMap();
		map.put("mno", mno);
		String str = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
		str = mapper.writeValueAsString(dao.list(map));
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return str;
		
	}
	
	@RequestMapping(value="/member/listFavorite2.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String list2(int mno, HttpSession session)
	{			
		//session.setAttribute("mno", mno);		
		Map map = new HashMap();
		map.put("mno", mno);
		String str = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
		str = mapper.writeValueAsString(dao.list2(map));
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return str;
		
	}
	
	@RequestMapping("member/deleteFavorite.do")
	@ResponseBody
	public ModelAndView delete(int fmno,int mno, HttpSession session)
	{
		
		session.setAttribute("fmno", fmno);
		Map map = new HashMap();
		map.put("fmno", fmno);
		map.put("mno", mno);
		
		ModelAndView mav = new ModelAndView("redirect:/member/favorite.do");
		int re = dao.delete(map);
		if(re<1)
		{
			mav.addObject("msg", "삭제하였습니다");
			mav.setViewName("/member/error");
		}
		return mav;
	}
	
}
