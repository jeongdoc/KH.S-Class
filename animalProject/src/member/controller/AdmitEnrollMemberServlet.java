package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import member.model.vo.SendAdmitEmail;

/**
 * Servlet implementation class AdmitEnrollMemberServlet
 */
@WebServlet("/admitmember")
public class AdmitEnrollMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdmitEnrollMemberServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/*
	 * 이메일 입력인풋 옆에 새창으로 "인증번호 받기" 클릭 새창 열리면 인풋 메일로 인증번호 메일 발송 메일에 인증번호 입력하고 "인증하기"
	 * 클릭 새창 닫히고 인증값 히든인풋 DB 인서트시 인증값 재 확인
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 회원가입 인증메일 처리용 컨트롤러

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String host = "smtp.naver.com";
		final String password = "Wheerang)615";
		int port = 587;

		URLDecoder.decode("urlcontext", "UTF-8");
		
		String email = request.getParameter("email");

		System.out.println(" !!! " + email);
		int idx = email.indexOf("@");

		Properties prop = new Properties();
		System.out.println(idx);
		System.out.println(String.valueOf(idx));
		prop.put("mail.smtp.host", host);
		prop.put("mail.smtp.port", port);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.mime.charset", "utf-8");
		prop.put("mail.smpt.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", host);
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("2u3u123", password);
			}
		});
		session.setDebug(true);
		
		try {
			StringBuffer buffer = new StringBuffer();
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("2u3u123@naver.com"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); //email

			msg.setSubject("[doghouse]회원가입 인증 메일입니다.");
			
			String admitNum = new SendAdmitEmail().sendAdmitNumber();
			System.out.println(admitNum + "== admitNum");

			byte[] anon = "토론토에 갔다가 남극세종기지에도 갔다. 심해생물. welcome!".getBytes();
			buffer.append(anon + "\n");
			buffer.append("회원가입 인증메일입니다." +"\n");
			buffer.append("회원가입 절차를 계속 진행해주시기 바랍니다");
			buffer.append("인증번호 : [ " + admitNum + " ] ");
			msg.setText(buffer.toString()); // 잘 됨.
			
			Transport.send(msg);
			System.out.println("The admitNum sent successfully...");
			
			JSONObject job = new JSONObject();
			if(admitNum != null && email != null) { //난수, 이메일 잘 받아오는지 확인
				job.put("keycode", admitNum);
			}
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(job.toJSONString());
			out.flush();
			out.close();
			
			//System.out.println(job.toJSONString() + " <- job"); 제대로 넘어오는지 확인
			
		} catch (Exception e) {
			e.printStackTrace();
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
