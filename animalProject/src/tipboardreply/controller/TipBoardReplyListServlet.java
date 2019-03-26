package tipboardreply.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tipboard.model.service.TipBoardService;
import tipboard.model.vo.TipBoard;
import tipboardreply.model.service.TipBoardReplyService;
import tipboardreply.model.vo.TipBoardReply;

/**
 * Servlet implementation class TipBoardReplyListServlet
 */
@WebServlet("/trlist")
public class TipBoardReplyListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardReplyListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 
		TipBoardReplyService trservice = new TipBoardReplyService();
		int tipBoardNo = Integer.parseInt(request.getParameter("tipBoard_no"));
		System.out.println("팁게시판 댓글의 글번호 : "+tipBoardNo);
		System.out.println("서블릿에서 팁 보드넘버 확인 : " + tipBoardNo);
		ArrayList<TipBoardReply> list = trservice.selectList(tipBoardNo);
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		System.out.println("리스트가 출력되는지 확인 : " + list);
		/*if(list.size() > 0) {*/
			view = request.getRequestDispatcher("views/tipboard/tipBoardDetailView.jsp");
			request.setAttribute("replyList", list);
		/*}else {
			view = request.getRequestDispatcher("views/tipboard/tipBoardError.jsp");
			request.setAttribute("message", "댓글 조회 실패");
			view.forward(request, response);
		}*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
