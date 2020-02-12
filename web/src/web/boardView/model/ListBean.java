package web.boardView.model;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		int pageSize = 10;
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		
		//#게시글 페이지 정보 담기. 
		String pageNum = null;
		if(request.getParameter("pageNum") != null){
			pageNum = request.getParameter("pageNum");
		}else{
			pageNum = "1";
		}
		
		//#현재 페이지에 보여줄 게시글의 시작과 끝 등등 정보 세팅
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		
		//#게시판 글 가져오기
		List articleList = null;
		BoardDAO dao = new BoardDAO();
		// 전체 글 개수 가져오기
		count = dao.getArticleCount();
		// 글이 하나라도 있으면 글 가져오기
		if(count > 0){
			articleList = dao.getArticles(startRow, endRow);
		}
		
		// 게시판에 뿌려줄 글 번호 담기
		number = count - (currentPage - 1) * pageSize;

		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("startRow", startRow);
		request.setAttribute("endRow", endRow);
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("articleList", articleList);
		
		
		return "/WEB-INF/boardView/list.jsp";
	}
}
