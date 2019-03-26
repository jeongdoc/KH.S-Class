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
import booking.model.vo.BookingForHost;

/**
 * Servlet implementation class BookingHostServiceServlet
 */
@WebServlet("/hservice")
public class BookingHostServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingHostServiceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("userid");
		ArrayList<BookingForHost> list = new BookingService().selectBkForHostList(userid);
		if(list.size() > 0) {
			JSONObject sendJSON = new JSONObject();
			JSONArray jar = new JSONArray();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy'년 'MM'월 'dd'일'");
			for(BookingForHost b : list) {
				JSONObject job = new JSONObject();
				job.put("bno", b.getBookingNo());
				job.put("kind", b.getServiceKind());
				job.put("username", URLEncoder.encode(b.getUserName(),"utf-8"));
				String indate = sdf.format(b.getCheckInDate());
				String outdate = sdf.format(b.getCheckOutDate());
				job.put("indate", indate);
				job.put("outdate", outdate);
				int price = b.getPrice();
				if(b.getServiceKind().equals("0") || b.getServiceKind().equals("2")) {
					price *= 0.8; // 당일 상품 20% 낮은 가격
				} else {
					price = (int) ((b.getCheckOutDate().getTime() - b.getCheckInDate().getTime())/(1000*60*60*24)) * b.getPrice();
				}
				price = (int) Math.floor(price/1000) * 1000; // 천단위 절사
				job.put("price", price);
				job.put("pg",b.getProgress());
				if(b.getEtc() != null) {
					job.put("etc", URLEncoder.encode(b.getEtc(), "utf-8"));
				}
				job.put("pno", b.getPetNo());
				job.put("addr", URLEncoder.encode(b.getAddress(),"utf-8"));
				
				jar.add(job);
				System.out.println(job);
			}
			sendJSON.put("list", jar);
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.append(sendJSON.toJSONString());
			out.flush();
			out.close();
		} else {
			System.out.println("예약 없음");
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
