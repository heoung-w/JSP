package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyFormBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean check = true;
		MemberDTO member = null;
		HttpSession session = request.getSession();
		if(session.getAttribute("memId") == null) {
			check = false;
		}else {
			String id = (String)session.getAttribute("memId");
			
			MemberDAO dao = MemberDAO.getInstance();
			member = dao.getMember(id);
		}
		request.setAttribute("check",check);
		request.setAttribute("member", member);
		
		return "/WEB-INF/memberView/modifyForm.jsp";
	}

}
