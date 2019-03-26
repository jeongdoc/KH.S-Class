package tipboard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tipboard.model.service.TipBoardService;
import tipboard.model.vo.TipBoard;

/**
 * Servlet implementation class TipBoardUpdateViewServlet
 */
@WebServlet("/tupview")
public class TipBoardUpdateViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardUpdateViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int tipBoardNum = Integer.parseInt(request.getParameter("tnum"));
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		TipBoard tboard = new TipBoardService().selectTipBoard(tipBoardNum);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(tboard != null) {
			view = request.getRequestDispatcher("views/tipboard/tipBoardUpdateView.jsp");
			request.setAttribute("tboard", tboard);
			request.setAttribute("page", currentPage);
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/tipboard/tipBoardError.jsp");
			request.setAttribute("message", tipBoardNum + "번 게시글 수정페이지로 이동 실패!");
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
