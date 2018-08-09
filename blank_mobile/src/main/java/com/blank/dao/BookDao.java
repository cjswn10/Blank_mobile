package com.blank.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.blank.db.BookManager;
import com.blank.vo.BookVo;
import com.blank.vo.MemberVo;

@Repository
public class BookDao {
	
	

	//?��?��깍옙?��?��?�� ?��?��?��?���?
	public List<BookVo> listBook(Map map)
	{
		return BookManager.listBook(map);
	}
	//?��?��깍옙?��?��?�� ?��?��?��븝옙?��?��?��
	public BookVo detailBook(Map map)
	{
		return BookManager.detailBook(map);
	}
	//?��?��깍옙?��?��?�� ?��?��?��?��?��?��
	public int insertBook(BookVo b)
	{
		return BookManager.insertBook(b);
	}
	//?��?��깍옙?��?��?�� ?��?��?��?��?��?��
	public int updateBook(BookVo b)
	{
		return BookManager.updateBook(b);
	}
	//?��?��깍옙?��?��?�� ?��?��?��?��?��?��
	public int deleteBook(Map map)
	{
		return BookManager.deleteBook(map);
	}
	//?��?��깍옙?��?��?�� ?��?��?��?��?��?��?��?��?��?��?��?��?��?��
	public int bookNextBno()
	{
		return BookManager.bookNextBno();
	}
}
