package notice.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import notice.model.service.NoticeService;
import notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeSearchServlet
 */
@WebServlet("/nsearch")
public class NoticeSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 검색 처리용 컨트롤러
		
		request.setCharacterEncoding("UTF-8");
		
/*		ArrayList<Notice> list = null;
		
		
		String search = request.getParameter("search");
		switch(search) {
		case "title" : String noticeTitle = request.getParameter("keyword"); 
						list = nservice.selectSearchTitle(noticeTitle); break;

		case "date" : String beginDate = request.getParameter("begin");
					String endDate = request.getParameter("end"); 
					list = nservice.selectSearchDate(Date.valueOf(beginDate), Date.valueOf(endDate));
					break;		
					
		}*/
		
		//검색 조건과 내용을 가져온다.
		String opt = request.getParameter("opt");
		String search = request.getParameter("search");
		
		//검색 조건과 내용을 Map에 담는다.
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("opt", opt);
		map.put("search", search);
		NoticeService nservice = new NoticeService();
		RequestDispatcher view = null;
		ArrayList<Notice> list = nservice.selectSearch(map);
		
		
		System.out.println(list);
		response.setContentType("text/html; charset=utf-8");
		if(list.size() > 0) {
			view = request.getRequestDispatcher("views/notice/noticeListView.jsp");
			request.setAttribute("list", list);				
			view.forward(request, response);
			
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('검색된 내용이 없습니다.'); location.href='/doggybeta/nlist';</script>");
			out.flush();		
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
