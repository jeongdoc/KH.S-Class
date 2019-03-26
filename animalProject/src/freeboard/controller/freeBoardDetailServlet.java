package freeboard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import freeboard.model.service.FreeBoardService;
import freeboard.model.vo.FreeBoard;

/**
 * Servlet implementation class BoardDetailServlet
 */
@WebServlet("/fdetail")
public class freeBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public freeBoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 상세보기 처리용 컨트롤러
		
		int freeBoardNo = Integer.parseInt(request.getParameter("fnum"));
//		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		
		FreeBoardService fservice = new FreeBoardService();
		
		//조회수 1증가 처리함
		fservice.addReadCount(freeBoardNo);
		
		//해당 글번호의 게시글 조회해 옴
		FreeBoard freeboard = fservice.selectFreeBoard(freeBoardNo);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(freeboard != null) {
			view = request.getRequestDispatcher("views/freeBoard/freeBoardDetailView.jsp");
			request.setAttribute("freeboard", freeboard);
//			request.setAttribute("currentPage", currentPage);
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/freeBoard/freeBoardError.jsp");
			request.setAttribute("message", freeBoardNo + "번 게시글 상세조회 실패! 로그인하십시오.");
			view.forward(request, response);
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
