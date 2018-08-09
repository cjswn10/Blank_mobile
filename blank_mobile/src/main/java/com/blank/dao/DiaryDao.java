package com.blank.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.blank.db.DiaryManager;
import com.blank.vo.DiaryVo;

@Repository
public class DiaryDao {
	
	public List<DiaryVo> othersDiaryList(Map map)
	{
		return DiaryManager.othersDiaryList(map);
	}
  
	public int deleteDiary(Map map) {
		return DiaryManager.deleteDiary(map);
	}
	
	public int updateDiary(DiaryVo d) {
		return DiaryManager.updateDiary(d);
	}
	
	public DiaryVo detailDiary(Map map) {
		return DiaryManager.detailDiary(map);
	}
	
	public int insertDiary(Map map) {
		return DiaryManager.insertDiary(map);
	}

	public int diaryNextNo() {
		return DiaryManager.diaryNextNo();
	}
	
	public List<DiaryVo> listDiary(Map map){
		return DiaryManager.listDiary(map);
	}
}
