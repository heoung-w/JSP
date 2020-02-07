package web.jsp0206.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HelloController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 서블릿은 바로 실행 불가. 요청과 맞물려 연결해줄 웹주소도 만들워줘야함.
		// web.xml 에 작업해야함
		System.out.println("hello!!! controller");
		
		// # JSP 페이지에 데이터 넘기기
		request.setAttribute("num", 1111);
		request.setAttribute("name", "피카츄");
		
		// #session으로 데이터 넘기기
		// JSP에서는 바로 set할수 있었지만 여기서는 session을 get으로 한번 꺼낸후 set해야한다.
		HttpSession session = request.getSession();
		session.setAttribute("memId", "java");
		
		
		// 해당 JSP 페이지 연결
		RequestDispatcher rd = request.getRequestDispatcher("/jsp0206/hello.jsp");
		rd.forward(request, response);
		// <jsp:forward>태그를 자바로 바꾼형태와 비슷하다.
	}
}
