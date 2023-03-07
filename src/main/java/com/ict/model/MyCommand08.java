package com.ict.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.db.DAO;

public class MyCommand08 implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String m_idx = request.getParameter("m_idx");
		
		int result = DAO.getDelete(m_idx);
		
		return String.valueOf(result);
	}
}
