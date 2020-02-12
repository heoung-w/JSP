package web.boardView.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.boardView.model.SuperBean;

/**
 * Servlet implementation class BoardController
 */
// @WebServlet("/BoardController")
public class BoardController extends HttpServlet {

	private Map beans = new HashMap();
	@Override
	public void init(ServletConfig config) throws ServletException {
		String path = config.getInitParameter("propertiesConfig");
		Properties p = null;
		InputStream is = null;
		try {
			is = new FileInputStream(path);
			p = new Properties();
			p.load(is);
			Iterator it = p.keySet().iterator();
			while(it.hasNext()) {
				String key = (String)it.next();
				String value = p.getProperty(key);
				Class c = Class.forName(value);
				Object obj = c.newInstance();
				beans.put(key, obj);
			}
			System.out.println(beans);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		Object obj = beans.get(uri);
		String view = "";
		SuperBean sb =null;
		if(obj instanceof SuperBean) {
			sb = (SuperBean)obj;
			view = sb.actionBean(request, response);
		}
		request.getRequestDispatcher(view).forward(request, response);
		
		
	}

}
