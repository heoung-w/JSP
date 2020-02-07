package web.jsp0207.mvc;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class TextController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// #1. request 속성 추가
		request.setAttribute("num", 99);
		request.setAttribute("id", "java");
		
		//#2. request null 값 보내기
		request.setAttribute("data", null);
		
		//#3. 문자형숫자 보내서 숫자 연산 확인
		request.setAttribute("age", 10);
		
		//#4. session 값 보내기
		HttpSession session = request.getSession();
		session.setAttribute("num", 777);
		session.setAttribute("id", "pika");
		
		//#5. 배열 보내기
		int [] arr = {10,20,30,40,50};
		request.setAttribute("arr", arr);
		
		//#6. ArrayList 보내기
		ArrayList list = new ArrayList();
		list.add("피카츄");
		list.add("파이리");
		list.add("꼬부기");
		request.setAttribute("list", list);
		
		
		//#7. TestVO
		TestVO vo = new TestVO();
		vo.setId("java");
		vo.setAge(123);
		vo.setName("파이리");
		request.setAttribute("vo", vo);
		
		
		
		
		
		
		request.getRequestDispatcher("/jsp0207/elTest.jsp").forward(request, response);
		
	}

}
