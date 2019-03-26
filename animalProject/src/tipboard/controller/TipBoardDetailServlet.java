package tipboard.controller;

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
 * Servlet implementation class TipBoardDetailServlet
 */
@WebServlet("/tdetail")
public class TipBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int tipBoardNum = Integer.parseInt(request.getParameter("tnum"));
		int currentPage = 1;
		if((request.getParameter("page")) !=null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		TipBoardService tservice = new TipBoardService();
		TipBoardReplyService trservice = new TipBoardReplyService();
		//댓글 페이징 처리 위한 변수들
		int trcurrentPage = 1;
		if(request.getParameter("trpage") != null) {
			trcurrentPage = Integer.parseInt(request.getParameter("trpage"));
		}
		int limit = 10;
		int listCount = trservice.getListCount();
		//총 페이지수 계산 : 목록이 마지막 1개일 때 1페이지로 처리
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지그룹(10개 페이지를 한 그룹으로 처리)에 
		//보여줄 시작 페이지 수
		//현재 페이지가 13이면 그룹은 11~20이 보여지게 함
		int startPage = (((int)((double)trcurrentPage / limit + 0.9)) - 1)
						* limit + 1;
		int endPage = startPage + limit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		//조회수 1증가 처리함
		tservice.addReadCount(tipBoardNum);
		
		//해당 글번호의 게시글 조회해 옴
		TipBoard tboard = tservice.selectBoard(tipBoardNum);
		
		
		//게시판의 댓글
		
		int tipBoardNo = Integer.parseInt(request.getParameter("tnum"));
		System.out.println("팁게시판 댓글의 글번호 : "+tipBoardNo);
		System.out.println("서블릿에서 팁 보드넘버 확인 : " + tipBoardNo);
		ArrayList<TipBoardReply> list = trservice.selectList(tipBoardNo,trcurrentPage, limit);
		
		response.setContentType("text/html; charset=utf-8");
		
		RequestDispatcher view = null;
		if(tboard != null) {
			view = request.getRequestDispatcher("views/tipboard/tipBoardDetailView.jsp");
			request.setAttribute("tboard", tboard);
			request.setAttribute("currentPage", currentPage);
			
			request.setAttribute("replyList", list);//댓글
			request.setAttribute("trcurrentPage", trcurrentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/tipboard/tipBoardError.jsp");
			request.setAttribute("message", tipBoardNum + "번 게시글 조회 실패");
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
