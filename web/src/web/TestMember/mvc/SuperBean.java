package web.TestMember.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 모든 빈클래스의 조상이될 인터페이스
// 인터페이스 : 추상 메서드만 존재해야함.
public interface SuperBean {

	public String actionBean(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
}
