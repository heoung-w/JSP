package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		boolean check = true;
		HttpSession session = request.getSession();
		if(session.getAttribute("memId") == null) {
			check = false;
		}
		request.setAttribute("check", check);
		
		return "/WEB-INF/memberView/modify.jsp";
	}

}
