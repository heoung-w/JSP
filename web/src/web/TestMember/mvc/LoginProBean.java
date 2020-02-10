package web.TestMember.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// SuperBean 인터페이스를 만들고, Bean클래스들은 모두 조상으로 두고 구현시킨다.
public class LoginProBean implements SuperBean {
	
	public String actionBean(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		
		request.setCharacterEncoding("utf-8"); // 여기다 적어두면 jsp 각 페이지에 만들어 줄 필요 없이  (view , jsp 파일 가기전에 ) 인코딩 처리 완료 하기
		// 아이디 패스워드 받기 전에 인코딩 해야함
		
		// 로그인 처리 로직.....\
		//loginPro 인 경우 , 로그인 처리 : 파라미터 받아, DB 연결하여 id, pw 확인하고 결과 뽑아 맞는지 확인하고 view 처리
		// 파라미터 꺼내기
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		// DB연결 로그인 체크
		MemberDAO dao = MemberDAO.getInstance();
		boolean check = dao.loginCheck(id, pw);
		/* String view="/class/jsp0210/loginForm.jsp"; */
		String view=null;
		// 로그인 성공
		if(check==true) {
			HttpSession session = request.getSession();
			session.setAttribute("memid", id);
			System.out.println(check);
			/* view= "/class/jsp0210/main.jsp"; */
		}else if(check==false){
		
		// 로그인 실패 -> 세션 없이 패스
		request.setAttribute("check", check);
		System.out.println(check);
		}				
		return "/mvcMember/loginPro.jsp";		
	}

}