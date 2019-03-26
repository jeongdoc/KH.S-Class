package freeboardreply.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import freeboard.model.vo.FreeBoard;
import freeboardreply.model.service.FreeBoardReplyService;
import freeboardreply.model.vo.FreeBoardReply;

/**
 * Servlet implementation class BoardReplyServlet
 */
@WebServlet("/freply")
public class freeBoardReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public freeBoardReplyServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 댓글달기 처리용 컨트롤러

		request.setCharacterEncoding("utf-8");
		
		int currentPage = 1;
		
//		int currentPage = Integer.parseInt(request.getParameter("page"));
	
		int freeBoardNo = Integer.parseInt(request.getParameter("fnum"));	
		String freeBoardWriter = request.getParameter("fwriter");
		String freeBoardContent = request.getParameter("fcontent");
		
		
		// 댓글 객체 생성 및 등록
		FreeBoardReplyService frservice = new FreeBoardReplyService();
		FreeBoard originBoard = frservice.selectFreeBoard(freeBoardNo);
		FreeBoardReply replyBoard = new FreeBoardReply();
		replyBoard.setFreereplycontent(freeBoardContent);
		replyBoard.setUserid(freeBoardWriter);
		replyBoard.setFreeboardno(originBoard.getFreeboardNo());

		int result = frservice.insertReply(replyBoard);	
		
		
		//댓글 가져오기
		String searchFreeBoardNo = request.getParameter("frnum");
		System.out.println("searchFreeBoardNo" + searchFreeBoardNo);
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchFreeBoardNo : ", searchFreeBoardNo);
		map.put("startRow", currentPage*10-9);// 1, 11, 21, 31....
		
		
		
		ArrayList<FreeBoardReply> flist = frservice.selectReplyList(map);
		
		for(FreeBoardReply f : flist) {
		System.out.println("댓글List : " + f);
		}
		
		//전송할 json 객체 준비
		JSONObject sendjson = new JSONObject();
		//리스트 객체들을 저장할 json 배열 객체 준비
		JSONArray jsonArr = new JSONArray();
		
		for(FreeBoardReply freereply : flist) {
			JSONObject replyJson = new JSONObject();
			
			replyJson.put("replyNo", freereply.getFreeboardno());
			replyJson.put("replyContent", URLEncoder.encode(freereply.getFreereplycontent(), "UTF-8"));
			replyJson.put("replyDate", freereply.getFreereplydate());
			replyJson.put("replyBoardNo", freereply.getFreeboardno());
			replyJson.put("replyDelete", freereply.getFreeboarddelete());

			jsonArr.add(replyJson);
			
		}
		
		sendjson.put("list", jsonArr);
		System.out.println("sendjson : " + sendjson.toJSONString());
		
		response.setContentType("aplication/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(sendjson.toJSONString());
		out.flush();
		out.close();
		
		
		
		if (result > 0) {
			request.setAttribute("replyList", flist);
			response.sendRedirect("/doggybeta/flist");
			
		} else {
			RequestDispatcher view = request.getRequestDispatcher("views/freeBoard/freeBoardError.jsp");
			request.setAttribute("message", freeBoardNo + "번글에 대한 댓글 등록 실패!");
			view.forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
