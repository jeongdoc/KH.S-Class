package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.SearchingInfo;

/**
 * Servlet implementation class PetSitterListServlet
 */
@WebServlet("/fplist")
public class PetSitterListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PetSitterListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String serviceKind = request.getParameter("opt");
		String beginDate = request.getParameter("begin");
		String endDate = request.getParameter("end");
		String city = request.getParameter("city");
		String sido = request.getParameter("sido");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("opt", serviceKind);
		map.put("begin", beginDate);
		map.put("end", endDate);
		map.put("city", city);
		map.put("sido", sido);
		
		MemberService mservice = new MemberService();
		RequestDispatcher view = null;
		ArrayList<SearchingInfo> list = mservice.insertCondition(map);
		
		System.out.println(list.toString());
		response.setContentType("text/html; charset=utf-8");
		
		if(list.size() > 0) {
			view = request.getRequestDispatcher("/doggybeta/views/findSitter/petSitterListView.jsp");
			request.setAttribute("list", list);				
			view.forward(request, response);
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('조건에 맞는 펫시터가 없습니다.'); location.href='/doggybeta/finding';</script>");
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
