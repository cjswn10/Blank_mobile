package com.blank.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.blank.db.MainManager;
import com.blank.vo.DiaryVo;

@Repository
public class MainDao {

	public List<DiaryVo> list()
	{
		return MainManager.list();
	}
	
}
