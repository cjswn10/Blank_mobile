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

	// 占싼글깍옙占쏙옙??
	@RequestMapping("/member/mainDetailDiary.do")
	public ModelAndView mainDetailDiary(int dno) {
		Map map = new HashMap();
		map.put("dno", dno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		return mav;
	}

	// 占싼글깍옙占쏙옙??
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
			mav.addObject("msg", "ERROR");
			mav.setViewName("/member/DELETE DIARY ERROR");
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

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		Calendar today = Calendar.getInstance();
		
		String todays = sdf.format(today.getTime());
		
		String cityName = request.getParameter("cityName");
		String dtitle = request.getParameter("dtitle");
		String ddate = request.getParameter("ddate");
		String dcontent = request.getParameter("dcontent");
		String dates = request.getParameter("date");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String select_day = request.getParameter("select_day");
		
		
		session.setAttribute("cityName", cityName);
		session.setAttribute("dtitle", dtitle);
		session.setAttribute("ddate", ddate);
		session.setAttribute("dcontent", dcontent);
		session.setAttribute("date", dates);
		session.setAttribute("year", year);
		session.setAttribute("month", month);
		session.setAttribute("select_day", select_day);
		
		
		try {
			
		
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:/Program Files/R/R-3.5.1/bin/x64/Rscript.exe");
			
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
	        
	        
	        String weather = caller.getParser().getXMLFileAsString();
	        //System.out.println(weather);
	        
			mav.addObject("weather", weather);
			mav.addObject("todays", todays);
		
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		return mav;
	}

	@RequestMapping(value = "/member/updateDiary.do", method = RequestMethod.POST)
	public ModelAndView diaryUpdateSubmit(DiaryVo d, HttpSession session, HttpServletRequest request) {

		int no = d.getDno();

		d.setDtype("000");
		String dtype = d.getDtype();

		if (d.getDfile() != null) {
			d.setDtype("100");
		}

		if (d.getDcontent() != null) {
			d.setDtype(d.getDtype().substring(0, 1) + "1" + d.getDtype().substring(2));
		}

		int mno = (Integer) session.getAttribute("mno");
		int bno = (Integer) session.getAttribute("bno");
		ModelAndView mav = new ModelAndView();

		Map map = new HashMap();
		map.put("dno", d.getDno());

		String oldDphoto = (dao.detailDiary(map)).getDphoto();
		String oldDfile = (dao.detailDiary(map)).getDfile();

		d.setDphoto(oldDphoto);
		d.setDfile(oldDfile);

		String path = request.getRealPath("resources/upload");
		String pathG = request.getRealPath("resources/upload2");

		MultipartFile upload = d.getUpload();
		MultipartFile uploadG = d.getUploadG();


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


		String orgnameG = uploadG.getOriginalFilename();
		String dfile = "x";

		if (orgnameG != null && !orgnameG.equals("")) {

			String excG = orgnameG.substring(orgnameG.lastIndexOf(".") + 1, orgnameG.length());
			dfile = bno + "b" + no + "grim." + excG;

			File saveFile = new File(pathG + "/" + dfile);
			try {
				uploadG.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
		}

		if (!dfile.equals("x")) {
			d.setDfile(dfile);
			d.setDtype(d.getDtype().substring(0, 2) + "1");

			try {
				byte[] dataG = uploadG.getBytes();
				FileOutputStream fosG = new FileOutputStream(pathG + "/" + dfile);
				fosG.write(dataG);
				fosG.close();
			} catch (Exception e) {
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
			if (oldDfile != null && !oldDfile.equals(dfile) && !dfile.equals("x")) {
				File fileG = new File(pathG + "/" + oldDfile);
				fileG.delete();
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
		return mav;
	}

	
	@RequestMapping(value = "/member/insertDiary.do", method = RequestMethod.GET)
	public ModelAndView diaryInsertForm(HttpSession session,HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		Calendar today = Calendar.getInstance();
		
		String todays = sdf.format(today.getTime());
		
		String cityName = request.getParameter("cityName");
		String dtitle = request.getParameter("dtitle");
		String ddate = request.getParameter("ddate");
		String dcontent = request.getParameter("dcontent");
		String dates = request.getParameter("date");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String select_day = request.getParameter("select_day");

		session.setAttribute("cityName", cityName);
		session.setAttribute("dtitle", dtitle);
		session.setAttribute("ddate", ddate);
		session.setAttribute("dcontent", dcontent);
		session.setAttribute("date", dates);
		session.setAttribute("year", year);
		session.setAttribute("month", month);
		session.setAttribute("select_day", select_day);
		
		try {
			
		
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:/Program Files/R/R-3.5.1/bin/x64/Rscript.exe");
			
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
	        
	        
	        String weather = caller.getParser().getXMLFileAsString();
	        //System.out.println(weather);
	        
			mav.addObject("weather", weather);
			mav.addObject("todays", todays);
		
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
			
		
		return mav;
	}

	@RequestMapping(value = "/member/insertDiary.do", method = RequestMethod.POST)
	public ModelAndView diaryInsertSubmit(DiaryVo d, HttpServletRequest request, HttpSession session) {
		int mno = (Integer) session.getAttribute("mno");
		int bno = (Integer) session.getAttribute("bno");

		int no = dao.diaryNextNo();
		d.setDno(no);

		d.setDtype("000");

		if (d.getDfile() != null) {
			d.setDtype("100");
		}

		if (d.getDcontent() != null) {
			d.setDtype(d.getDtype().substring(0, 1) + "1" + d.getDtype().substring(2));
		}

		d.setDphoto("");
		d.setDfile("");


		String path = request.getRealPath("resources/upload");
		String pathG = request.getRealPath("resources/upload2");

		MultipartFile upload = d.getUpload();
		MultipartFile uploadG = d.getUploadG();

		String ser_id = request.getParameter("ser_id");
		Boolean success = false;
		ModelAndView view = new ModelAndView();

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
		
		/************** 占쌓몌옙 ***************/
		String orgnameG = uploadG.getOriginalFilename();
		String dfile = "x";

		if (orgnameG != null && !orgnameG.equals("")) {
			String excG = orgnameG.substring(orgnameG.lastIndexOf(".") + 1, orgnameG.length());
			dfile = bno + "b" + no + "grim." + excG;
			File saveFileG = new File(pathG + "/" + dfile);

			try {
				upload.transferTo(saveFileG);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}

		}
		
		if (!dfile.equals("x")) {
			d.setDfile(dfile);
			d.setDtype(d.getDtype().substring(0, 2) + "1");
			try {
				byte[] dataG = uploadG.getBytes();
				FileOutputStream fosG = new FileOutputStream(pathG + "/" + dfile);
				fosG.write(dataG);
				fosG.close();
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

		ModelAndView mav = new ModelAndView("redirect:/member/diary.do?mno=" + mno + "&bno=" + bno);

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
			//code.addRCode("data <- gsub('.','', data)");
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
	       // System.out.println(keyword);
	        
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