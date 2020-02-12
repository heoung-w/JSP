package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int check = -1;
		if(session.getAttribute("memId") == null) {
			
			String id = null, pw=null, auto=null;
			Cookie[] cs = request.getCookies();
			if(cs != null){
				for(Cookie coo : cs){
					if(coo.getName().equals("autoId")) id = coo.getValue();
					if(coo.getName().equals("autoPw")) pw = coo.getValue();
					if(coo.getName().equals("autoCh")) auto = coo.getValue();
				}
			}
			
			if(auto != null&& id!=null && pw!= null) {
				check = 0;
			}else {
				check = -1;
			}
			
		}else {
			check = 1;
		}
		request.setAttribute("check", check);
		
		
		return "/WEB-INF/memberView/main.jsp";
	}

	
	
	

}
 