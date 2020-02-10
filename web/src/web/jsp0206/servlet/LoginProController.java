package web.jsp0206.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginProController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		// DB 연결해서 id,pw체크하는 로직...
		// MemberDAO dao = MemberDAO.getInstance();
		// int check = dao.userCheck(id,pw);
		
		int check = 1;
		
		request.setAttribute("check", check);
		RequestDispatcher rd = request.getRequestDispatcher("/jstl/jsp0206/loginPro.jsp");
		rd.forward(request, response);
	
	}
}
