package com.blank.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.blank.db.BookManager;
import com.blank.vo.BookVo;
import com.blank.vo.MemberVo;

@Repository
public class BookDao {
	
	

	//일기장목록
	public List<BookVo> listBook(Map map)
	{
		return BookManager.listBook(map);
	}
	public BookVo detailBook(Map map)
	{
		return BookManager.detailBook(map);
	}
	//일기장 생성
	public int insertBook(BookVo b)
	{
		return BookManager.insertBook(b);
	}
	//일기장 수정
	public int updateBook(BookVo b)
	{
		return BookManager.updateBook(b);
	}
	//일기장 삭제
	public int deleteBook(Map map)
	{
		return BookManager.deleteBook(map);
	}
	//일기장 번호 자동증가
	public int bookNextBno()
	{
		return BookManager.bookNextBno();
	}
}
