package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ConfirmIdBean implements SuperBean{
	
		@Override
		public String actionBean(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
			boolean isLogin = false;
			HttpSession session = request.getSession();
			if(session.getAttribute("memId") == null) {
				isLogin = true;
			}
			

				request.setCharacterEncoding("UTF-8");
			
				// 주소뒤에 붙혀온 파라미터 받기
				String id = request.getParameter("id");
				// DB 연결해서 입력받아 넘어온 id가 DB에 이미 존재하는지 확인
				MemberDAO dao = MemberDAO.getInstance();
				boolean check = dao.confirmId(id);
				// check == true : DB에 이미 id가 존재한다. 
				// check == false : DB에 존재하지 않는 id (새로 가입하는 사용자가 사용가능한 id)
				request.setAttribute("check", check);
				request.setAttribute("trialid", id);
				request.setAttribute("isLogin", isLogin);
				
				
				return "/WEB-INF/memberView/confirmId.jsp";
		}
}
