package com.blank.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.blank.db.BookManager;
import com.blank.vo.BookVo;
import com.blank.vo.MemberVo;

@Repository
public class BookDao {
	
	

	//? ?‹¹ê¹ì˜™? ?™?˜™ ? ?™?˜™? ï¿?
	public List<BookVo> listBook(Map map)
	{
		return BookManager.listBook(map);
	}
	//? ?‹¹ê¹ì˜™? ?™?˜™ ? ?¢?„¸ë¸ì˜™? ?™?˜™
	public BookVo detailBook(Map map)
	{
		return BookManager.detailBook(map);
	}
	//? ?‹¹ê¹ì˜™? ?™?˜™ ? ?™?˜™? ?™?˜™
	public int insertBook(BookVo b)
	{
		return BookManager.insertBook(b);
	}
	//? ?‹¹ê¹ì˜™? ?™?˜™ ? ?™?˜™? ?™?˜™
	public int updateBook(BookVo b)
	{
		return BookManager.updateBook(b);
	}
	//? ?‹¹ê¹ì˜™? ?™?˜™ ? ?™?˜™? ?™?˜™
	public int deleteBook(Map map)
	{
		return BookManager.deleteBook(map);
	}
	//? ?‹¹ê¹ì˜™? ?™?˜™ ? ?™?˜™?˜¸? ?Œ˜?“¸?˜™? ?™?˜™? ?™?˜™
	public int bookNextBno()
	{
		return BookManager.bookNextBno();
	}
}
