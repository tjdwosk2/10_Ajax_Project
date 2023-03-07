package com.ict.db;


import java.util.List;

import org.apache.ibatis.session.SqlSession;

public class DAO {

	// 실제 사용하는 클래스 : SqlSession
	private static SqlSession ss;

	// 싱글턴 패턴(동기화 처리) : 프로그램 종료시까지 한 번 만들어진 객체를 재사용하는 형식
	private synchronized static SqlSession getSession() {
		if (ss == null) {
			ss = DBService.getFactory().openSession();
		}
		return ss;
	}
	
	public static List<VO> getListAll(){
		List<VO> list = getSession().selectList("members.list");
		return list;
	}
	
	public static String getIDChk(String m_id) {
		String result = "1"; 
		List<VO> list = getSession().selectList("members.idcheck", m_id);
		if(list.size()>0) result = "0";
		return result;
	}
	
	public static int getInsert(VO vo){
		int result = getSession().insert("members.insert", vo);
		ss.commit();
		return result;
	}
	
	public static int getDelete(String m_idx){
		int result = getSession().insert("members.delete", m_idx);
		ss.commit();
		return result;
	}
}
