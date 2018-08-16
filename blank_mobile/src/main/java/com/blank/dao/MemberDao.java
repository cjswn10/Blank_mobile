package com.blank.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import com.blank.db.MemberManager;
import com.blank.vo.LogVo;
import com.blank.vo.MemberVo;

@Repository
public class MemberDao {

	//회원가입
	public int memberInsert(MemberVo m) {
		return MemberManager.memberInsert(m);
	}
	//아이디중복체크
	public int memberCheckId(Map map) {

		return MemberManager.checkId(map);
		
	}
	//로그인
	public Boolean login(Map map) {
		return MemberManager.login(map);
	}
	//회원번호(세션유지 때문)
	public int mno(Map map)
	{
		return MemberManager.mno(map);
	}
	//회원번호 자동증가
	public int memberNextMno()
	{
		return MemberManager.memberNextMno();
	}
	//회원정보수정
	public int updateMember(MemberVo mv) {
		// TODO Auto-generated method stub
		return MemberManager.updateMember(mv);
	}
	//회원 정보 가져오기
	public MemberVo getMember(Map map) {
		// TODO Auto-generated method stub
		return MemberManager.getMember(map);
	}
	
	//메인 아이디검색
	public List<MemberVo> mainSearchId(Map map)
	{
		return MemberManager.mainSearchId(map);
	}
	
	//아이디 찾기
	public String searchId(Map map)
	{
		return MemberManager.searchId(map);
	}
	//비밀번호찾기
	public String searchPwd(Map map)
	{
		return MemberManager.searchPwd(map);
	}

	//로그인 기록
	public int logRecord(LogVo l)
	{
		return MemberManager.logRecord(l);
	}
}
