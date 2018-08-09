package com.blank.db;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.blank.vo.FavoriteVo;

public class FavoriteManager {
	
	private static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/blank/db/BlankConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
			
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
		
	public static int insertFavorite(Map map) {
		int re = -1;
		SqlSession session = factory.openSession();
		re = session.insert("favorite.insertFavorite", map);
		session.commit();
		session.close();		
		return re;
	}
	
	public static List<FavoriteVo> list(Map map)
	{
		SqlSession session = factory.openSession();

		List<FavoriteVo> list = session.selectList("favorite.listFavorite", map);
		session.close();
		return list;
	}
	
	public static List<FavoriteVo> list2(Map map)
	{
		SqlSession session = factory.openSession();

		List<FavoriteVo> list = session.selectList("favorite.listFavorite2", map);
		session.close();
		return list;
	}
	
	public static int delete(Map map)
	{
		int re = -1;
		SqlSession session = factory.openSession();
		re = session.delete("favorite.deleteFavorite",map);
		session.commit();
		session.close();
		
		return re;
	}
	
	
	

}
