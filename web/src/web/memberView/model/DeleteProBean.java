package web.memberView.model;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class DeleteProBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		boolean check = true;
		int result = 0;
		HttpSession session = request.getSession();
		if(session.getAttribute("memId")==null) {
			check=false;
		}else {
			// 회원 탈퇴 로직 작성
			// DB 에서 데이터 삭제 
			// session에서 아이디 꺼내기
			String id = (String)session.getAttribute("memId");
			// 폼페이지에서 넘어온 비밀번호 받기
			String pw = request.getParameter("pw");
		
			
			// 서버에 저장된 사진도 삭제해야함. --> 실제 서비스를해주는 save
			// 해당 사용자가 업로드한 사진경로 필요
			String path = request.getRealPath("mSave");
			//D:\mysource\jsp\workspace\.metadata\.plugins
			//  \org.eclipse.wst.server.core\tmp0\wtpwebapps\web\save\사진명
			MemberDAO dao = MemberDAO.getInstance();
			String photoName = dao.getPhotoName(id);
			if(photoName != null){
				path += ("\\" + photoName);
				File f = new File(path);
				f.delete();
			}
			result = dao.deleteMember(id, pw);
			
			// result : -1 (아이디 이상함,세션생성부분확인), 0 (비번 오류), 1(탈퇴 정상처리)
			if(result == 1) {	// 탈퇴 처리가 됬다면,
				// 로그아웃
				session.invalidate();
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
			}
		
		}
		request.setAttribute("check", check);
		request.setAttribute("result", result);
		
		
		
		
		
		
		return "/WEB-INF/memberView/deletePro.jsp";
	}

}
