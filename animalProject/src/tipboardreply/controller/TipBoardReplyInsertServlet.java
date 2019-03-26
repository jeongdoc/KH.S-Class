package tipboardreply.controller;

import java.io.IOException;

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
 * Servlet implementation class TipBoardReplyInsertServlet
 */
@WebServlet("/trinsert")
public class TipBoardReplyInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardReplyInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		TipBoardReply trboard = new TipBoardReply();
		/*int tipBoardNum = Integer.parseInt(request.getParameter("tnum"));*/
		
		
		int tipBoardNo = Integer.parseInt(request.getParameter("tipBoard_no"));
		String tipReplyId = request.getParameter("tipReply_id");
		String tipReplyContent = request.getParameter("tipReply_content");
		
		/*comment.setComment_num(dao.getSeq());*/	// 댓글 번호는 시퀀스값으로
		trboard.setTipNo(tipBoardNo);
		trboard.setUserId(tipReplyId);
		trboard.setTipReplyContent(tipReplyContent);
		/*comment.setComment_board(comment_board);
		comment.setComment_id(comment_id);
		comment.setComment_content(comment_content);
		
		boolean result = dao.insertComment(comment);*/
		
		int result = new TipBoardReplyService().insertTipBoardReply(trboard);
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("views/tipboard/tipBoardDetailView.jsp");
		}else {
			view = request.getRequestDispatcher("views/tipboard/tipBoardError.jsp");
			request.setAttribute("message", "댓글 등록 실패");
			view.forward(request, response);
		}
		/*if(result){
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("1");
			out.close();
		}
			
		return null;*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
