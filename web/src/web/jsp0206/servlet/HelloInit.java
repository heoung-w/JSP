package web.jsp0206.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloInit extends HttpServlet{
	
	@Override
	// init 메서드는 단 한번만 실행된다.( 생성자랑 비슷함 )
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init!!!!");
	
	}

	@Override
	// service는 계속 생성됨.
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("service!!!");
	}
	
	
	
	
}
