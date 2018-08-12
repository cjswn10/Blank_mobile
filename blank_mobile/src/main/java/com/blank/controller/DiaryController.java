package com.blank.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.language.bm.Rule.Phoneme;
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

	// 메인 상세보기
	@RequestMapping("/member/mainDetailDiary.do")
	public ModelAndView mainDetailDiary(int dno) {
		Map map = new HashMap();
		map.put("dno", dno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		return mav;
	}

	// 친구일기 상세보기
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

	// 일기 삭제
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

	// 일기 update(get)
	@RequestMapping(value = "/member/updateDiary.do", method = RequestMethod.GET)
	public ModelAndView diaryUpdateForm(int dno) {
		Map map = new HashMap();
		map.put("dno", dno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		return mav;
	}

	// 일기 update(post)
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

		// 이전 파일을 가져오기 위한 map
		Map map = new HashMap();
		map.put("dno", d.getDno());

		// 이전 이름이지만 새파일이름도 동일하게 바꿀것이라 파일명은 동일
		String oldDphoto = (dao.detailDiary(map)).getDphoto();
		String oldDfile = (dao.detailDiary(map)).getDfile();

		d.setDphoto(oldDphoto);
		d.setDfile(oldDfile);

		String path = request.getRealPath("resources/upload");
		String pathG = request.getRealPath("resources/upload2");

		MultipartFile upload = d.getUpload();
		MultipartFile uploadG = d.getUploadG();

		// 사진 이름 바꾸는 코드 및 서버에 들어감
		String orgname = upload.getOriginalFilename();
		String dphoto = "x";

		// 사진이름 바꾸기
		if (orgname != null && !orgname.equals("")) {

			String exc = orgname.substring(orgname.lastIndexOf(".") + 1, orgname.length());
			// bno와 dno와 확장자를 결합한 새이름
			dphoto = bno + "b" + no + "." + exc;

			// 설정한 이름을 가진 파일(saveFile)을 upload에 다시 실어줌
			File saveFile = new File(path + "/" + dphoto);
			try {
				upload.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}

		}

		// 업로드한 사진이 있으면
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

		/************** 그림 *****************/

		// 그림 이름 바꾸는 코드 및 서버에 들어감
		String orgnameG = uploadG.getOriginalFilename();
		String dfile = "x";

		// 그림이름 바꾸기
		if (orgnameG != null && !orgnameG.equals("")) {

			String excG = orgnameG.substring(orgnameG.lastIndexOf(".") + 1, orgnameG.length());
			// bno와 dno와 확장자를 결합한 새이름
			dfile = bno + "b" + no + "grim." + excG;

			// 설정한 이름을 가진 파일(saveFile)을 upload에 다시 실어줌
			File saveFile = new File(pathG + "/" + dfile);
			try {
				uploadG.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
		}

		// 업로드한 파일이 있으면
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
		
		System.out.println("이전사진 "+oldDphoto);
		System.out.println("이전그림 "+oldDfile);
		System.out.println("업데이트 사진 "+d.getDphoto());
		System.out.println("업데이트 그림 "+d.getDfile());

		int re = dao.updateDiary(d);

		if (re > 0) {
			mav.setViewName("redirect:/member/diary.do?mno=" + mno + "&bno=" + bno);
			if (oldDphoto != null && !oldDphoto.equals(dphoto) && !dphoto.equals("x")) {
				System.out.println("사진 삭제됨");
				File file = new File(path + "/" + oldDphoto);
				file.delete();
			}
			if (oldDfile != null && !oldDfile.equals(dfile) && !dfile.equals("x")) {
				System.out.println("그림 삭제됨");
				File fileG = new File(pathG + "/" + oldDfile);
				fileG.delete();
			}

		} else {
			mav.addObject("msg", "UPDATE DIARY ERROR");
			mav.setViewName("/member/error");
		}

		return mav;
	}

	// 상세보기
	@RequestMapping("/member/detailDiary.do")
	public ModelAndView detailDiary(int dno) {
		Map map = new HashMap();
		map.put("dno", dno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("d", dao.detailDiary(map));
		return mav;
	}

	// 일기 추가(get)
	@RequestMapping(value = "/member/insertDiary.do", method = RequestMethod.GET)
	public ModelAndView diaryInsertForm(HttpSession session,HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		
		String cityName = request.getParameter("cityName");
		String dtitle = request.getParameter("dtitle");
		String ddate = request.getParameter("ddate");
		String dcontent = request.getParameter("dcontent");
		
//		System.out.println("cityName:"+cityName);
//		System.out.println("dtitle:"+dtitle);
//		System.out.println("ddate:"+ddate);
//		System.out.println("dcontent:"+dcontent);
		
		session.setAttribute("dtitle", dtitle);
		session.setAttribute("ddate", ddate);
		session.setAttribute("dcontent", dcontent);
		
		try {
			
		
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:/Program Files/R/R-3.5.1/bin/x64/Rscript.exe");
			
			RCode code = new RCode();
			code.clear();
			
			code.addRCode("setwd('c:/r_temp')");
			code.addRCode("data = read.csv('weather.csv')");
			code.addRCode("data2 = data.frame(data)");
			code.addRCode("weather = subset(data2,city=='"+cityName+"')");
			code.addRCode("city = as.character(weather[1,1])");
	        code.addRCode("img = as.character(weather[1,2])");
	        code.addRCode("tmef = as.character(weather[1,3])");
	        code.addRCode("allvars <- as.list(globalenv())");

	        caller.setRCode(code);

	        caller.runAndReturnResult("allvars");
			
	        String city = caller.getParser().getAsStringArray("city")[0];
	        String img = caller.getParser().getAsStringArray("img")[0];
	        String tmef = caller.getParser().getAsStringArray("tmef")[0];
	        
//	        System.out.println(city.toString());
//	        System.out.println(img.toString());
//	        System.out.println(tmef.toString());
	        
	        String weather = caller.getParser().getXMLFileAsString();
	        //System.out.println(weather);
	        
			mav.addObject("weather", weather);
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
			
		
		return mav;
	}

	// 일기 추가(post)
	@RequestMapping(value = "/member/insertDiary.do", method = RequestMethod.POST)
	public ModelAndView diaryInsertSubmit(DiaryVo d, HttpServletRequest request, HttpSession session) {
		int mno = (Integer) session.getAttribute("mno");
		int bno = (Integer) session.getAttribute("bno");

		int no = dao.diaryNextNo();
		d.setDno(no);

		d.setDtype("000");
		// 파일이 unll이 아니면 타입 설정
		if (d.getDfile() != null) {
			d.setDtype("100");
		}

		// content가 null이 아니면 타입 설정
		if (d.getDcontent() != null) {
			d.setDtype(d.getDtype().substring(0, 1) + "1" + d.getDtype().substring(2));
		}

		d.setDphoto("");
		d.setDfile("");

		// 사진,그림 path 설정
		String path = request.getRealPath("resources/upload");
		String pathG = request.getRealPath("resources/upload2");

		MultipartFile upload = d.getUpload();
		MultipartFile uploadG = d.getUploadG();

		String ser_id = request.getParameter("ser_id");
		Boolean success = false;
		ModelAndView view = new ModelAndView();

		// 실제 파일 이름
		String orgname = upload.getOriginalFilename();
		String dphoto = "x";

		if (orgname != null && !orgname.equals("")) {

			String exc = orgname.substring(orgname.lastIndexOf(".") + 1, orgname.length());
			// 사진이름을 설정
			dphoto = bno + "b" + no + "." + exc;
			// 설정한 사진이름을 파일로 만든다
			File saveFile = new File(path + "/" + dphoto);

			try {
				// 설정한 이름을 가진 파일(saveFile)을 upload에 다시 실어줌
				upload.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}

		}
		// 업로드한 사진이 있으면
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
			// 그림이름을 설정
			dfile = bno + "b" + no + "grim." + excG;
			// 설정한 그림이름을 파일로 만든다
			File saveFileG = new File(pathG + "/" + dfile);

			try {
				// 설정한 이름을 가진 파일(saveFileG)을 upload에 다시 실어줌
				upload.transferTo(saveFileG);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}

		}
		
		// 업로드한 그림이 있으면
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

	@RequestMapping("/member/diary.do")
	public void diary() {

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

}