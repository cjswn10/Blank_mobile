package com.blank.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blank.dao.MainDao;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.rcaller.rStuff.RCaller;
import com.github.rcaller.rStuff.RCode;

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
	
	@RequestMapping(value="/member/dailyKeyword.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String dailyKeyword(HttpServletRequest request) {
		String keywords = "";
		
		try {
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:\\Program Files\\R\\R-3.5.1\\bin\\x64\\Rscript.exe");
			
			RCode code = new RCode();
			code.clear();		
			
			File file;			
			file = code.startPlot();
			/**
			 * db연동 후 파일(dailyKeyword.txt) 생성
			 */
			code.addRCode("setwd('c:/r_temp')");
			code.addRCode("library(DBI)");
			code.addRCode("library(RODBC)");
			
			code.addRCode("db = odbcConnect('blank', 'blank', 'blank')");
			code.addRCode("sql = 'SELECT dcontent FROM diary WHERE ddate=TRUNC(sysdate-1)'");
			code.addRCode("data = sqlQuery(db, sql)");
			code.addRCode("keywords = matrix(data$DCONTENT)");
			code.addRCode("write(keywords, 'dailyKeyword.txt')");
			
			/**
			 * wordcloud로 만들기
			 */
			code.addRCode("library(KoNLP)");
			code.addRCode("library(RColorBrewer)");
			code.addRCode("library(wordcloud)");
			code.addRCode("useSejongDic()");
			code.addRCode("data1=readLines('dailyKeyword.txt')");
			code.addRCode("data1 <- gsub('<br />','', data1)");
			code.addRCode("data1 <- gsub('\\r\\n','', data1)");
			code.addRCode("data1 <- gsub('<br>','', data1)");
			code.addRCode("data2 <- sapply(data1,extractNoun,USE.NAMES=F)");
			code.addRCode("data3 <- unlist(data2)");
			code.addRCode("data3 <- Filter(function(x) {nchar(x) >= 1} ,data3)");
			code.addRCode("data3=gsub('[0-9]','',data3)");
			code.addRCode("data3=gsub('[ㄱ-ㅎ]','',data3)");
			code.addRCode("write(unlist(data3),'dailyKeyword2.txt')");
			code.addRCode("data4 <- read.table('dailyKeyword2.txt')");
			code.addRCode("wordcount = table(data4)");
			code.addRCode("palete <- brewer.pal(9,'Set3')");
			code.addRCode("wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=1,random.order=F,random.color=T,colors=palete)");
			
			code.endPlot();
			caller.setRCode(code);
			caller.runOnly();
			
			String path = request.getRealPath("/resources/rImg");
			keywords = file.getName();

			try {
				FileInputStream fis = new FileInputStream(file);
				FileOutputStream fos = new FileOutputStream(path + "/" + keywords);
				FileCopyUtils.copy(fis, fos);
				fis.close();
				fos.close();
				
			}catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return keywords;
	}
	
	@RequestMapping(value="/member/weeklyKeyword.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String weeklyKeyword(HttpServletRequest request) {
		String keywords = "";
		
		try {
			RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:\\Program Files\\R\\R-3.5.1\\bin\\x64\\Rscript.exe");
			
			RCode code = new RCode();
			code.clear();		
			
			File file;			
			file = code.startPlot();
			/**
			 * db연동 후 파일(weeklyKeyword.txt) 생성
			 */
			code.addRCode("setwd('c:/r_temp')");
			code.addRCode("library(DBI)");
			code.addRCode("library(RODBC)");
			
			code.addRCode("db = odbcConnect('blank', 'blank', 'blank')");
			code.addRCode("sql = 'SELECT dcontent FROM diary WHERE ddate BETWEEN TRUNC(sysdate-7) AND TRUNC(sysdate)'");
			code.addRCode("data = sqlQuery(db, sql)");
			code.addRCode("keywords = matrix(data$DCONTENT)");
			code.addRCode("write(keywords, 'weeklyKeyword.txt')");
			
			/**
			 * wordcloud로 만들기
			 */
			code.addRCode("library(KoNLP)");
			code.addRCode("library(RColorBrewer)");
			code.addRCode("library(wordcloud)");
			code.addRCode("useSejongDic()");
			code.addRCode("data1=readLines('weeklyKeyword.txt')");
			code.addRCode("data1 <- gsub('<br />','', data1)");
			code.addRCode("data1 <- gsub('\\r\\n','', data1)");
			code.addRCode("data1 <- gsub('<br>','', data1)");
			code.addRCode("data2 <- sapply(data1,extractNoun,USE.NAMES=F)");
			code.addRCode("data3 <- unlist(data2)");
			code.addRCode("data3 <- Filter(function(x) {nchar(x) >= 1} ,data3)");
			code.addRCode("data3=gsub('[0-9]','',data3)");
			code.addRCode("data3=gsub('[ㄱ-ㅎ]','',data3)");
			code.addRCode("write(unlist(data3),'weeklyKeyword2.txt')");
			code.addRCode("data4 <- read.table('weeklyKeyword2.txt')");
			code.addRCode("wordcount = table(data4)");
			code.addRCode("palete <- brewer.pal(9,'Set3')");
			code.addRCode("wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=1,random.order=F,random.color=T,colors=palete)");
			
			code.endPlot();
			caller.setRCode(code);
			caller.runOnly();
			
			String path = request.getRealPath("/resources/rImg");
			keywords = file.getName();

			try {
				FileInputStream fis = new FileInputStream(file);
				FileOutputStream fos = new FileOutputStream(path + "/" + keywords);
				FileCopyUtils.copy(fis, fos);
				fis.close();
				fos.close();
				
			}catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return keywords;
	}
}
