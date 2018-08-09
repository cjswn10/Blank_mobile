package com.blank.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.blank.db.BookManager;
import com.blank.vo.BookVo;
import com.blank.vo.MemberVo;

@Repository
public class BookDao {
	
	

	//? ?ΉκΉμ? ?? ? ??? οΏ?
	public List<BookVo> listBook(Map map)
	{
		return BookManager.listBook(map);
	}
	//? ?ΉκΉμ? ?? ? ?’?ΈλΈμ? ??
	public BookVo detailBook(Map map)
	{
		return BookManager.detailBook(map);
	}
	//? ?ΉκΉμ? ?? ? ??? ??
	public int insertBook(BookVo b)
	{
		return BookManager.insertBook(b);
	}
	//? ?ΉκΉμ? ?? ? ??? ??
	public int updateBook(BookVo b)
	{
		return BookManager.updateBook(b);
	}
	//? ?ΉκΉμ? ?? ? ??? ??
	public int deleteBook(Map map)
	{
		return BookManager.deleteBook(map);
	}
	//? ?ΉκΉμ? ?? ? ???Έ? ??Έ?? ??? ??
	public int bookNextBno()
	{
		return BookManager.bookNextBno();
	}
}
