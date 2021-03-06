package com.blank.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.blank.dao.DiaryDao;
import com.blank.vo.DiaryVo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.rcaller.rStuff.RCaller;
import com.github.rcaller.rStuff.RCode;


@Controller
public class DiaryController {
	
	@Autowired
	private DiaryDao dao;

	public void setDao(DiaryDao dao) {
		this.dao = dao;
	}

	// 占쎈쐻占쎈뼩疫뀐옙繹먮씮�굲占쎈쐻占쎈짗占쎌굲??
	@RequestMapping("/member/mainDetailDiary.do")
	public ModelAndView mainDetailDiary(int dno) {
		Map map = new HashMap();
		map.put("dno", dno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		return mav;
	}

	// 占쎈쐻占쎈뼩疫뀐옙繹먮씮�굲占쎈쐻占쎈짗占쎌굲??
	@RequestMapping("/member/detailFavoriteDiary.do")
	public ModelAndView detailFavoriteDiary(int dno) {
		Map map = new HashMap();
		map.put("dno", dno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		return mav;
	}

	
	@RequestMapping("/member/othersDiary.do")
	public void othersDiary() {
		
	}
	
	@RequestMapping(value="/member/othersDiaryList.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String othersDiaryList(int fmno, HttpSession session) {
		Map map = new HashMap();
		map.put("othermno", fmno);
		String str = "";
		List<DiaryVo> list = dao.othersDiaryList(map);	
		try {

			ObjectMapper mapper = new ObjectMapper();
			str = mapper.writeValueAsString(list);

		} catch (Exception e) {
			// TODO: handle exception
		}
		return str;
	}

	@RequestMapping("/member/deleteDiary.do")
	public ModelAndView deleteDiary(int dno, HttpSession session, HttpServletRequest request) {

		int mno = (Integer) session.getAttribute("mno");
		int bno = (Integer) session.getAttribute("bno");
		Map map = new HashMap();

		map.put("dno", dno);

		String path = request.getRealPath("resources/upload");
		String oldFname = dao.detailDiary(map).getDphoto();

		ModelAndView mav = new ModelAndView("redirect:/member/diary.do?mno=" + mno + "&bno=" + bno);
		int re = dao.deleteDiary(map);
		if (re < 1) {
			mav.addObject("msg", "DELETE DIARY ERROR");
			mav.setViewName("/member/deleteDiary.do");
		}
		if (re > 0 && oldFname != null && !oldFname.equals("")) {
			File file = new File(path + "/" + oldFname);
			file.delete();

		}
		return mav;
	}

	@RequestMapping(value = "/member/updateDiary.do", method = RequestMethod.GET)
	public ModelAndView diaryUpdateForm(int dno,HttpSession session,HttpServletRequest request) {
		Map map = new HashMap();
		map.put("dno", dno);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		
		//날짜 엔터보이게
		String content = dao.detailDiary(map).getDcontent();
		content = content.replace("\r\n", "<br>");			
		mav.addObject("dcontent2", content);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		Calendar today = Calendar.getInstance();
		String todays = sdf.format(today.getTime());
	    
		mav.addObject("todays", todays);
			
		return mav;
	}

	@RequestMapping(value = "/member/updateDiary.do", method = RequestMethod.POST)
	public ModelAndView diaryUpdateSubmit(DiaryVo d, HttpSession session, HttpServletRequest request) {
		
		int no = d.getDno();

		d.setDtype("000");
		String dtype = d.getDtype();

		int mno = (Integer) session.getAttribute("mno");
		int bno = (Integer) session.getAttribute("bno");
		ModelAndView mav = new ModelAndView();

		Map map = new HashMap();
		map.put("dno", d.getDno());

		String oldDphoto = (dao.detailDiary(map)).getDphoto();
		String oldDfile = (dao.detailDiary(map)).getDfile();

		d.setDphoto(oldDphoto);
		if(d.getDfile() == null || d.getDfile().equals("")) {
			d.setDfile(oldDfile);
		}
		
		String path = request.getRealPath("resources/upload");
		MultipartFile upload = d.getUpload();
		
		String orgname = upload.getOriginalFilename();
		String dphoto = "x";

		if (orgname != null && !orgname.equals("")) {
			String exc = orgname.substring(orgname.lastIndexOf(".") + 1, orgname.length());
			dphoto = bno + "b" + no + "." + exc;

			File saveFile = new File(path + "/" + dphoto);
			try {
				upload.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
		}

		if (!dphoto.equals("x")) {
			d.setDphoto(dphoto);
			d.setDtype(d.getDtype().substring(0, 2) + "1");
			try {
				byte[] data = upload.getBytes();
				FileOutputStream fos = new FileOutputStream(path + "/" + dphoto);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		int re = dao.updateDiary(d);

		if (re > 0) {
			mav.setViewName("redirect:/member/diary.do?mno=" + mno + "&bno=" + bno);
			if (oldDphoto != null && !oldDphoto.equals(dphoto) && !dphoto.equals("x")) {
				File file = new File(path + "/" + oldDphoto);
				file.delete();
			}

		} else {
			mav.addObject("msg", "UPDATE DIARY ERROR");
			mav.setViewName("/member/error");
		}

		return mav;
	}

	@RequestMapping("/member/detailDiary.do")
	public ModelAndView detailDiary(int dno) {
		Map map = new HashMap();
		map.put("dno", dno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		
		String content = dao.detailDiary(map).getDcontent();
		content = content.replace("\r\n", "<br>");			
		mav.addObject("dcontent2", content);
		
		return mav;
	}
	
	@RequestMapping(value = "/member/weather4.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String weather(HttpSession session,HttpServletRequest request,String cityName,int dates)
	{

		String weather = "";

		try {
			
		
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:/Program Files/R/R-3.5.1/bin/x64/Rscript.exe");
			//caller.setRscriptExecutable("C:/R-3.5.1/bin/x64/Rscript.exe");
      
			RCode code = new RCode();
			code.clear();
			
			code.addRCode("setwd('c:/r_temp')");
			code.addRCode("data = read.csv('weather.csv')");
			code.addRCode("data2 = data.frame(data)");
			code.addRCode("weather = subset(data2,date=='"+dates+"')");
			code.addRCode("date = as.character(weather[1,1])");
	        code.addRCode("img = as.character(weather[1,2])");
	        code.addRCode("tmef = as.character(weather[1,3])");
	        
	        code.addRCode("setwd('c:/r_temp')");
			code.addRCode("data3 = read.csv('weather2.csv')");
			code.addRCode("data4 = data.frame(data3)");
			code.addRCode("weather2 = subset(data4,city=='"+cityName+"')");
			code.addRCode("city = as.character(weather2[1,1])");
	        code.addRCode("img2 = as.character(weather2[1,2])");
	        code.addRCode("tmef2 = as.character(weather2[1,3])");
	        
	        code.addRCode("allvars <- as.list(globalenv())");

	        caller.setRCode(code);

	        caller.runAndReturnResult("allvars");
			
	        String date = caller.getParser().getAsStringArray("date")[0];
	        String img = caller.getParser().getAsStringArray("img")[0];
	        String tmef = caller.getParser().getAsStringArray("tmef")[0];
	        
	        String city = caller.getParser().getAsStringArray("city")[0];
	        String img2 = caller.getParser().getAsStringArray("img2")[0];
	        String tmef2 = caller.getParser().getAsStringArray("tmef2")[0];
	        
	        
	        weather = caller.getParser().getXMLFileAsString();
	        //System.out.println(weather);
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return weather;
	}
	
	@RequestMapping(value = "/member/weather5.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String weather2(HttpSession session,HttpServletRequest request,String cityName)
	{
		System.out.println(cityName);
		String weather2 = "";

		try {
			
		
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:/Program Files/R/R-3.5.1/bin/x64/Rscript.exe");
			//caller.setRscriptExecutable("C:/R-3.5.1/bin/x64/Rscript.exe");
      
			RCode code = new RCode();
			code.clear();
	        
	        code.addRCode("setwd('c:/r_temp')");
			code.addRCode("data3 = read.csv('weather2.csv')");
			code.addRCode("data4 = data.frame(data3)");
			code.addRCode("weather2 = subset(data4,city=='"+cityName+"')");
			code.addRCode("city = as.character(weather2[1,1])");
	        code.addRCode("img2 = as.character(weather2[1,2])");
	        code.addRCode("tmef2 = as.character(weather2[1,3])");
	        
	        code.addRCode("allvars <- as.list(globalenv())");

	        caller.setRCode(code);

	        caller.runAndReturnResult("allvars");
			
	        String city = caller.getParser().getAsStringArray("city")[0];
	        String img2 = caller.getParser().getAsStringArray("img2")[0];
	        String tmef2 = caller.getParser().getAsStringArray("tmef2")[0];
	        
	        weather2 = caller.getParser().getXMLFileAsString();
	        //System.out.println(weather2);
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return weather2;
	}
	
	@RequestMapping(value = "/member/insertDiary.do", method = RequestMethod.GET)
	public ModelAndView diaryInsertForm(HttpSession session,HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		Calendar today = Calendar.getInstance();
		
		String todays = sdf.format(today.getTime());
		
		//오늘 날짜 불러오기
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

		Calendar today2 = Calendar.getInstance();
		
		String todays2 = sdf2.format(today2.getTime());

		mav.addObject("todays", todays);
		mav.addObject("todays2", todays2);
		
		//dno생성 후 전달
		int dno = dao.diaryNextNo();
		mav.addObject("dno", dno);
		
		return mav;
	}

	@RequestMapping(value = "/member/insertDiary.do", method = RequestMethod.POST)
	public ModelAndView diaryInsertSubmit(DiaryVo d, HttpServletRequest request, HttpSession session) {
		int mno = (Integer) session.getAttribute("mno");
		int bno = (Integer) session.getAttribute("bno");
		int dno = d.getDno();

		ModelAndView mav = new ModelAndView("redirect:/member/diary.do?mno=" + mno + "&bno=" + bno);
		
		d.setDtype("000");
		d.setDphoto("");

		String path = request.getRealPath("resources/upload");
		MultipartFile upload = d.getUpload();

		String ser_id = request.getParameter("ser_id");
		Boolean success = false;

		String orgname = upload.getOriginalFilename();
		String dphoto = "x";
		
		if (orgname != null && !orgname.equals("")) {
			String exc = orgname.substring(orgname.lastIndexOf(".") + 1, orgname.length());
			dphoto = bno + "b" + dno + "." + exc;
			File saveFile = new File(path + "/" + dphoto);

			try {
				upload.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
		}
		
		if (!dphoto.equals("x")) {
			d.setDphoto(dphoto);
			d.setDtype(d.getDtype().substring(0, 2) + "1");
			try {
				byte[] data = upload.getBytes();
				FileOutputStream fos = new FileOutputStream(path + "/" + dphoto);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		Map map = new HashMap();
		map.put("dno", d.getDno());
		map.put("dtitle", d.getDtitle());
		map.put("ddate", d.getDdate());
		map.put("dweather", d.getDweather());
		map.put("dfont", d.getDfont());
		map.put("dtype", d.getDtype());
		map.put("dfile", d.getDfile());
		map.put("dcontent", d.getDcontent());
		map.put("dphoto", d.getDphoto());
		map.put("secret", d.getSecret());
		map.put("mno", d.getMno());
		map.put("bno", d.getBno());

		System.out.println(d.getDfile());

		int re = dao.insertDiary(map);
		if (re < 1) {
			mav.addObject("msg", "INSERT DIARY ERROR");
			mav.setViewName("/member/error");
		}

		return mav;
	}

	@RequestMapping(value="/member/myKeyword.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String keyword(HttpSession session,int mno,int bno)
	{
		//ModelAndView mav = new ModelAndView();
		
		String keyword="";
		//int mno = (Integer)session.getAttribute("mno");
		
		try {
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:/Program Files/R/R-3.5.1/bin/x64/Rscript.exe");
			
			RCode code = new RCode();
			code.clear();
			
			code.addRCode("setwd('c:/r_temp')");
			code.addRCode("library(DBI)");
			code.addRCode("library(RODBC)");
			code.addRCode("library(KoNLP)");
			code.addRCode("library(wordcloud)");
			code.addRCode("useSejongDic()");
			code.addRCode("db = odbcConnect('blank','blank','blank')");
			code.addRCode("sql = sqlQuery(db,'select dcontent from book b,member m,diary d where b.mno=m.mno and d.bno=b.bno and b.mno="+mno+" and b.bno="+bno+"')");
			code.addRCode("keyword = matrix(sql$DCONTENT)");
			code.addRCode("write(keyword ,'keyword.txt')");
			code.addRCode("data = readLines('keyword.txt')");
			code.addRCode("data <- gsub('[ㄱ-ㅎ]','', data)");
			code.addRCode("data <- gsub('[0-9]','', data)");
			code.addRCode("data <- gsub('<br />','', data)");
			code.addRCode("data <- gsub('\r\n','', data)");
			code.addRCode("data1 <- sapply(data,extractNoun,USE.NAMES=F)");
			code.addRCode("data2 <- unlist(data1)");
			code.addRCode("data2 <- Filter(function(x) {nchar(x) >= 2} ,data2)");
			code.addRCode("write(unlist(data2),'diary_dtitle.txt')");
			code.addRCode("data4 <- read.table('diary_dtitle.txt')");
			code.addRCode("wordcount <- table(data4)");
			code.addRCode("data5 = head(sort(wordcount, decreasing=T),3)");
			code.addRCode("data6 = data.frame(data5)");
			code.addRCode("data7 = as.character(data6[1,1])");
			code.addRCode("data8 = as.character(data6[2,1])");
			code.addRCode("data9 = as.character(data6[3,1])");   
	        code.addRCode("allvars <- as.list(globalenv())");

	        caller.setRCode(code);

	        caller.runAndReturnResult("allvars");
			
	        String data7 = caller.getParser().getAsStringArray("data7")[0];
	        String data8 = caller.getParser().getAsStringArray("data8")[0];
	        String data9 = caller.getParser().getAsStringArray("data9")[0];

	        keyword = caller.getParser().getXMLFileAsString();
	        //System.out.println(keyword);
	        
	        //mav.addObject("keyword", keyword);
	        
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}  
		
		return keyword;
		
	}

	// LIST DIARY
	@RequestMapping(value = "/member/listDiary.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String listDiary(int bno, int mno, HttpSession session) {
		Map map = new HashMap();
		map.put("bno", bno);
		map.put("mno", mno);

		session.setAttribute("bno", bno);
		session.setAttribute("mno", mno);

		
		String str = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(dao.listDiary(map));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return str;
	}
	
	
	@RequestMapping("/member/diary.do")
	public void diary() {
		
	}

}