package web.memberView.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ModifyProBean implements SuperBean{
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		//파일업로드 MultipartRequest
		String path = request.getRealPath("save");
		int max = 1024*1024*5;
		String enc = "UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);

		// 넘어오는 데이터 : 비밀번호, 생년월일, email
		// form에서 id 안넘옴 : id를 알기위해 session에서 id 꺼내기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("memId");
		MemberDTO member = new MemberDTO();
		member.setId(id);	// dto에 직접 id 세팅해서 
		
		member.setPw(mr.getParameter("pw"));
		member.setBirth(mr.getParameter("birth"));
		member.setEmail(mr.getParameter("email"));
		// DB 업데이트시, 기존의 사진 이름 정보 분실을 방지하기 위해 처리
		// 새로 파일 업로드를 하고 넘어 왔다면
		if(mr.getFilesystemName("photo") != null){
			// 새로 업로드한 input 태그에있는 사진이름으로 체워주고
			member.setPhoto(mr.getFilesystemName("photo"));
		}else{ // 새로 파일 업로드를 안했을 경우,
			// 기존의 파일 명으로 체워주기
			member.setPhoto(mr.getParameter("exPhoto"));
		}
			
		// db에 수정할 데이터를 dto 통으로 보내, 회원정보 수정하기.
		MemberDAO dao = MemberDAO.getInstance();
		dao.updateMember(member);
		
		return "/WEB-INF/memberView/modifyPro.jsp";
	}

}
