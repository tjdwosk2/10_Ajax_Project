package com.ict.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.db.DAO;
import com.ict.db.VO;

public class MyCommand03 implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 실제 DB 처리 후 MyController01로 되돌아 감
		List<VO> list = DAO.getListAll();

		// xml로 변환
		StringBuffer sb = new StringBuffer();

		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<members>");
		for (VO k : list) {
			sb.append("<member ");
			sb.append(" m_idx=\"" + k.getM_idx() + "\"");
			sb.append(" m_id=\"" + k.getM_id() + "\"");
			sb.append(" m_pw=\"" + k.getM_pw() + "\"");
			sb.append(" m_reg=\"" + k.getM_reg().substring(0, 10) + "\"");
			sb.append(" m_addr=\"" + k.getM_addr() + "\">");
			sb.append(k.getM_name());
			sb.append(" </member>");
		}
		sb.append("</members>");

		// 일반적인 MVC는 뷰 경로를 작성하지만
		// Ajax는 만들어진 데이터를 리턴함
		return sb.toString();
	}
}
