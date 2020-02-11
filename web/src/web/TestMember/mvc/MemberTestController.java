package web.TestMember.mvc;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//어노테이션으로 매핑하는 방법
//외부 properties 파일 가져오기 위해 초기파라미터로 파일 이름 /위치 세팅

//@WebServlet("*.nhn, *.git, *.naver") // web.xml 안쓰고 쓰는 방법  -> 어노테이션으로 매핑하는 방법
//@WebServlet(urlPatterns ="*.ung", initParams = @WebInitParam(name="propertiesPath", value="D:\\JSP\\JSP\\web\\WebContent\\WEB-INF\\properties\\test.properties")) // web.xml 안쓰고 쓰는 방법  -> 어노테이션으로 매핑하는 방법

public class MemberTestController extends HttpServlet{

//  LoginFormBean lfb = null; 
//  LoginProBean lpb = null;
// 	key=요청경로, value = Bean클래스 객체로 모두 정리해서 활용할 Map
	private Map beanMap = new HashMap();
   
   @Override
    public void init(ServletConfig config) throws ServletException {
	   	System.out.println("init!!!!");
// 		Bean 클래스 객체 생성 (이제 앞으로 컨트롤러에서 객체 호출에서 빌려만 쓰는 거지 new 써서 객체 일일히 생성 안해도 되게 만듬
//      lfb = new LoginFormBean();
//      lpb = new LoginProBean();
 
//      initParams로 보내온 파라미터는 config가 받아옴.
//      propertiesPath 이름 붙인 것으로 properties파을을 꺼내면 된다.
		String path = config.getInitParameter("propertiesPath");
		//       System.out.println(path);
		//       Properties 클래스로 Properties 파일 로드 시키기
		Properties p = null;
		//        실제 파일을 가져오기 위해 InputStream 사용.
		InputStream is =null;
		try {
			is = new FileInputStream(path);  //외부 파일 가져올때 쓰는 것 OutStream - > 내부를 외부로 보내서 쓸 때
			// 파일 저장 경로를 스트림에 담아 객체만들고
			p = new Properties(); // Properties 객체 생성
			// 로 시키기 (key, value 형태로 세팅)
			p.load(is);
			System.out.println("?=================="+p);
			// properties 클래스로 로드시킨 데이터에서 value에 적힌 클래스명으로 객체 생성
			// 이래야 객체 생성 새로 안하고 여기서 빌려다 쓰게 만듬
			Iterator it = p.keySet().iterator();	// key 전체 꺼내서 반복자 만들기
			
			while(it.hasNext()) {					// 너 다음 요소가 있을때 까지 반복해 !
				String key = (String)it.next();		// 하나의 key 꺼내 담고
				String value = p.getProperty(key);	// key로 value 꺼내 담기.
				// Properties 파일은 원본 유지,
				// uri 경로 = key, BeanClass 객체 = value가 되는 형태
				// HashMap 객체를 생성해서 각 요청 = 빈클래스요소를 담겠다.
				// 요청때마다 편하게 (요청경로 =key) 요청 경로로 Bean 클래스 객체를
				// 사용하기 위해서
				Class c = Class.forName(value); // value = bean 클래스 전체경로
				Object obj = c.newInstance();
				// Object obj = new web.TestMember.mvc.LofinFormBean();
				
				beanMap.put(key, obj);	// Map에 저장
		    }
		            
		}catch(Exception e) {
			 e.printStackTrace();
		}
}
		   
   		@Override 
		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String uri = request.getRequestURI();
			String view = "/mvcMember/main.jsp";
			// 통합 처리 변경
			// #1. uri에 맞는 model 객체가 필요 -> actionBean() 호출해서 비지니스로직 처리
			Object obj = beanMap.get(uri);
			// 요청 경로가 beanMap 의 요소들의 key값, 요청에 맞는 Bean클래스 객체 꺼내짐.
			// loginForm.ung 요청에 들어오면 LoginFormBean 객체 돌려줌 -> obj 들어감
		    SuperBean sb=null;
		    if(obj instanceof SuperBean) {
		        sb = (SuperBean)obj;
		        view = sb.actionBean(request, response);
		    }
		    request.getRequestDispatcher(view).forward(request, response);
   		}
}
		
		
		
		
		
		
		
		




/*
 * @Override protected void doGet(HttpServletRequest request,
 * HttpServletResponse response) throws ServletException, IOException {
 * System.out.println("get!!!"); PrintWriter pw = response.getWriter();
 * pw.println("<html>"); pw.println("<body>");
 * pw.println("<h2>Hello Servlet!!!!</h2>"); pw.println("</body>");
 * pw.println("</html>"); }
 */

/*
 * @Override protected void doPost(HttpServletRequest request,
 * HttpServletResponse response) throws ServletException, IOException {
 * 
 * }
 */