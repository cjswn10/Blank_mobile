package com.blank.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.web.bind.annotation.RequestBody;

import com.blank.vo.LogVo;
import com.blank.vo.MemberVo;

public class MemberManager {

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
	//회원가입
	public static int memberInsert(MemberVo m)
	{
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.insert("member.insertMember", m);
		session.close();
		return re;
	}
	//회원번호 자동증가
	public static int memberNextMno()
	{
		int no = 0;
		SqlSession session = factory.openSession();
		no = session.selectOne("member.memberNextMno");
		session.close();
		return no;
	}
	//로그인
	public static boolean login(Map map) {
		boolean b = false;
		SqlSession session = factory.openSession();
		MemberVo m = session.selectOne("member.login", map);
		if (m != null) {
			b = true;
		}
		return b;
	}
	
	//아이디 중복체크
	public static int checkId(Map map)
	{
		int re = 0;
		SqlSession session = factory.openSession();
		re = session.selectOne("member.checkId",map);
		session.close();
		return re;
	}
	
	//회원번호(세션유지를 위해)
	public static int mno(Map map)
	{
		int mno = 0;
		SqlSession session = factory.openSession();
		mno = session.selectOne("member.mno",map);
		session.close();
		return mno;
	}
	
	//회원정보 가져오기
	public static MemberVo getMember(Map map) {
		// TODO Auto-generated method stub
		MemberVo mv = new MemberVo();
		SqlSession session = factory.openSession();
		mv = session.selectOne("member.getMember", map);
		return mv;
	}
	
	//회원정보 수정
	public static int updateMember(MemberVo mv) {
		// TODO Auto-generated method stub
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.insert("member.updateMember", mv);
		session.close();
		return re;
	}
	//메인페이지 아이디검색
	public static List<MemberVo> mainSearchId(Map map)
	{
		SqlSession session = factory.openSession();
		List<MemberVo> list = session.selectList("member.mainSearchId", map);
		session.close();
		return list;
	}
	
	//아이디 찾기
	public static String searchId(Map map)
	{
		String id = "";
		SqlSession session = factory.openSession();
		id = session.selectOne("member.searchId", map);
		session.close();
		return id;
	}
	
	//비밀번호 찾기
	public static String searchPwd(Map map)
	{
		String pwd = "";
		SqlSession session = factory.openSession();
		pwd = session.selectOne("member.searchPwd", map);
		session.close();
		return pwd;
	}
	
	//로그인 기록
	public static int logRecord(LogVo l)
	{
		int re = -1;
		SqlSession session = factory.openSession();
		l.setLno(logNextLno());
		re = session.insert("logRecod", l);
		session.commit();
		session.close();
		return re;
	}
	
	//로그인 기록 번호자동증가
	public static int logNextLno()
	{
		int lno = 0;
		SqlSession session = factory.openSession();
		lno = session.selectOne("member.logNextLno");
		session.close();
		return lno;
	}	
		
	
}







