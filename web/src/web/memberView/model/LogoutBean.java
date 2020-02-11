package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 세션삭제
		HttpSession session = request.getSession();
		if(session.getAttribute("memId")!= null) {
			session.invalidate();
		}
		// 쿠키 있으면 쿠키도 삭제
		Cookie[] cs = request.getCookies();	// request에서 전체쿠기 가져오기
		if(cs != null){	// 쿠키가 있다면, 
			for(Cookie coo : cs){ // 반복문 돌려서 모든 쿠키에 접근
				// 쿠키 이름 뽑아, 저장할때 붙힌 이름과 비교해서 동일하면 삭제
				if(coo.getName().equals("autoId") || coo.getName().equals("autoPw") || coo.getName().equals("autoCh") ){	 
					coo.setMaxAge(0);
					response.addCookie(coo);
				}
			}
		}
		// 쿠키,세션삭제 == 로그아웃 ==> 로그아웃한 후에 main으로 돌아가라!!
		//response.sendRedirect("main.jsp");
		
		
		
		
		return "/WEB-INF/memberView/logout.jsp";
	}

}
