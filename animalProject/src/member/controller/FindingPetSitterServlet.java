package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.SearchingInfo;

/**
 * Servlet implementation class FindingPetSitterListServlet
 */
@WebServlet("/finding")
public class FindingPetSitterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindingPetSitterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userid = request.getParameter("userid");
		
		ArrayList<SearchingInfo> list = new MemberService().searchPetSitter(userid);
		System.out.println("서블릿: " + userid);
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		
		System.out.println("서블릿: " + list);
		if(list.size() > 0) {
			view = request.getRequestDispatcher("views/findSitter/petSitterListView.jsp");
			request.setAttribute("list", list);
			view.forward(request, response);
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('펫 정보를 반드시 등록해야 합니다.'); location.href='views/findSitter/petSitterListView.jsp';</script>");
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
