package com.blank.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.blank.vo.BookVo;
import com.blank.vo.DiaryVo;

public class DiaryManager {

	private static SqlSessionFactory factory;
	static
	{
		try {
			
			Reader reader = Resources.getResourceAsReader("com/blank/db/BlankConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	
	
	public static List<DiaryVo> othersDiaryList(Map map){
		List<DiaryVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("diary.othersDiary", map);
		session.close();
		return list;
	}

	public static int deleteDiary(Map map) {
		int re = -1;
		SqlSession session = factory.openSession();
		re = session.delete("diary.deleteDiary", map);
		session.commit();
		session.close();
		return re;
	}
	
	public static int updateDiary(DiaryVo d) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.update("diary.updateDiary", d);
		session.close();
		return re;
	}
	
	public static DiaryVo detailDiary(Map map) {
		DiaryVo d = null;
		SqlSession session = factory.openSession();
		d = session.selectOne("diary.detailDiary", map);
		session.close();
		return d;
	}
	
	public static int insertDiary(Map map) {
		int re =  -1;
		SqlSession session = factory.openSession();
		re = session.insert("diary.insertDiary", map);
		session.commit();
		session.close();
		return re;
		
	}
	
	public static int diaryNextNo()
	{
		int dno = 0;
		SqlSession session = factory.openSession();
		dno = session.selectOne("diary.diaryNextNo");
		session.close();
		return dno;
	}
	
	public static List<DiaryVo> listDiary(Map map){
		List<DiaryVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("diary.selectAll", map);
		session.close();
		return list;
	}
	

}
