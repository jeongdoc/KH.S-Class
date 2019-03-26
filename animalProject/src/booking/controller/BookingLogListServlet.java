package booking.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import booking.model.service.BookingService;
import booking.model.vo.BookingCheck;

/**
 * Servlet implementation class BookingLogListServlet
 */
@WebServlet("/bklist")
public class BookingLogListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingLogListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("userid");
		ArrayList<BookingCheck> list = new BookingService().selectBkList(userid);
		
		if(list.size() > 0) {
		JSONObject sendJSON = new JSONObject();
		JSONArray ar = new JSONArray();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy'년 'MM'월 'dd'일'");
		for(BookingCheck bc : list) {
			JSONObject job = new JSONObject();
			job.put("bno", bc.getBookingNo());
			String indate = sdf.format(bc.getCheckInDate());
			String outdate = sdf.format(bc.getCheckOutDate());
			
			job.put("indate", indate);
			job.put("outdate", outdate);
			job.put("progress", bc.getBookingProgress());
			job.put("puserid", bc.getPuserId());
			int price = bc.getPrice();
			if(bc.getServiceKind().equals("0") || bc.getServiceKind().equals("2")) {
				price *= 0.8; // 당일 상품 20% 낮은 가격
				price = (int) Math.floor(price/1000) * 1000; // 천단위 절사
			} else {
				price = (int) ((bc.getCheckOutDate().getTime() - bc.getCheckInDate().getTime())/(1000*60*60*24)) * bc.getPrice();
			}
			job.put("price", price);
			job.put("addr", URLEncoder.encode(bc.getAddress(), "utf-8"));
			job.put("pname", URLEncoder.encode(bc.getPetName(), "utf-8"));
			job.put("kind", bc.getServiceKind());
			
			ar.add(job);
		}
			sendJSON.put("list", ar);
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.append(sendJSON.toJSONString());
			out.flush();
			out.close();
		} else {
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
