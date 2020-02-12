package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SignupProBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		boolean check = true;
		HttpSession session = request.getSession();
		if(session.getAttribute("memId") == null) {
			request.setCharacterEncoding("UTF-8");
			// 파일업로드 MultipartRequest
			String path = request.getRealPath("mSave");
			int max = 1024*1024*5;
			String enc = "UTF-8";
			DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
			MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
			MemberDTO member = new MemberDTO();
			
			member.setId(mr.getParameter("id"));
			member.setPw(mr.getParameter("pw"));
			member.setName(mr.getParameter("name"));
			member.setBirth(mr.getParameter("birth"));
			member.setEmail(mr.getParameter("email"));
			// 사진 저장 이름 (이름이 중복되었으면 뒤에 숫자가 붙은 이름으로 DB에 저장) 
			member.setPhoto(mr.getFilesystemName("photo"));
			
			MemberDAO dao = MemberDAO.getInstance();
			dao.insertMember(member);
			check = false;
		}
		request.setAttribute("check", check);
		
		return "/WEB-INF/memberView/signupPro.jsp";
	}

}
