package com.blank.db;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.blank.vo.BookVo;
import com.blank.vo.MemberVo;

public class BookManager {

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
	
	
	
	//일기장목록
	public static List<BookVo> listBook(Map map)
	{
		List<BookVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("book.listBook",map);
		session.close();
		return list;
	}
	
	//일기장 상세
	public static BookVo detailBook(Map map)
	{
		BookVo b = null;
		SqlSession session = factory.openSession();
		b = session.selectOne("book.detailBook",map);
		session.close();
		return b;
	}
	
	//일기장 생성
	public static int insertBook(BookVo b)
	{
		int re = -1;
		SqlSession session = factory.openSession();
		
		re = session.insert("book.insertBook", b);
		if(re > 0)
		{
			session.commit();
		}
		else
		{
			session.rollback();
		}	
		session.close();
		return re;
	}
	//일기장 수정
	public static int updateBook(BookVo b)
	{
		int re = -1;
		SqlSession session = factory.openSession();
		re = session.update("book.updateBook", b);
		if(re > 0)
		{
			session.commit();
		}
		else
		{
			session.rollback();
		}	
		session.close();
		return re;
	}
	//일기장 삭제
	public static int deleteBook(Map map)
	{
		int re = -1;
		
		int cnt = 0;
		
		SqlSession session = factory.openSession();
		
		cnt += session.delete("book.deleteDiary", map);
		cnt += session.delete("book.deleteBook", map);
		
		if(cnt > 0)
		{
			session.commit();
			re=1;
		}
		else
		{
			session.rollback();
		}
		session.close();
		return re;
	}
	//일기장 번호 자동증가
	public static int bookNextBno()
	{
		int no = 0;
		SqlSession session = factory.openSession();
		no = session.selectOne("book.bookNextBno");
		session.close();
		return no;
	}
}








