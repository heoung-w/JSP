package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginProBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 로그인이 되있는 상태면 바로 메인으로 바꿔주기
		HttpSession session = request.getSession();
		if(session.getAttribute("memId") != null) {
			return "/WEB-INF/memberView/main.jsp";
		}
		
		
		
		request.setCharacterEncoding("UTF-8");
		// loginForm 에서 전달받은 파라미터 받기 
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto"); // 자동로그인 파리미터 받기
		
		// 메인에서 세션없고, 쿠키가 있어서 이리로 넘어올때 처리 
		// loginForm을 타고 온것이 아니라 위에 getParameter로 값 꺼낼 수 없다. 모두 null 상태
		// 쿠키 꺼내서 위 변수 체워주기 
		Cookie[] cs = request.getCookies();
		if(cs != null){
			for(Cookie coo : cs){
				if(coo.getName().equals("autoId")) id = coo.getValue();
				if(coo.getName().equals("autoPw")) pw = coo.getValue();
				if(coo.getName().equals("autoCh")) auto = coo.getValue();
			}
		}
		
		// 로그인 체크
		MemberDAO dao = MemberDAO.getInstance();
		boolean check = false;
		check = dao.loginCheck(id, pw);
		
		if(check) { // id-pw 일치할때
			// 세션 만들기 : 로그인 성공으로 앞으로 로그인상태 유지 시켜줄 세션 만들어주기.

			session.setAttribute("memId", id);
			// 자동로그인 체크 하고 로그인버튼 눌렀을때 ---> 쿠키 생성
			if(auto != null){ // 자동로그인 체크했다면,
				// 쿠키 객체 생성
				Cookie c1 = new Cookie("autoId", id);
				Cookie c2 = new Cookie("autoPw", pw);
				Cookie c3 = new Cookie("autoCh", auto);
				// 쿠키들 유효기간 설정
				c1.setMaxAge(60*60*24);
				c2.setMaxAge(60*60*24);
				c3.setMaxAge(60*60*24);
				// 적용
				response.addCookie(c1);
				response.addCookie(c2);
				response.addCookie(c3);
			}
			
		}
		request.setAttribute("check", check);
		System.out.println(check);
		return "/WEB-INF/memberView/loginPro.jsp";

	}
}
