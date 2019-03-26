package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import member.model.service.MemberService;
import member.model.vo.Member;
import member.model.vo.SendTempPassword;

/**
 * Servlet implementation class FindPasswordServlet
 */
@WebServlet("/jipsafindpwd")
public class FindPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /*private static String tempNum = null;*/
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 임시비밀번호 발송 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		String host = "smtp.naver.com";
		final String password = "Wheerang)615";
		int port = 587;
		
		Member member = new Member();
		
		String email = request.getParameter("email");
		String userid = request.getParameter("userid");
		
		response.setContentType("text/html; charset=utf-8");
		
		member.setUserId(userid);
		member.setEmail(email);
		
		System.out.println("비밀번호찾기 : " + userid + " == " + email);
		MemberService mService = new MemberService();
		int result = mService.findPassword(member);
		
		PrintWriter out = response.getWriter();
		if(result > 0) {
			URLDecoder.decode("urlcontext", "UTF-8");
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
				return new PasswordAuthentication(email.substring(0,idx), password);
			}
		});
		session.setDebug(true);
		
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(email));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(member.getEmail()));
			
			msg.setSubject("[doghouse]임시 비밀번호 발송 메일입니다.");
			
			String tempNum = new SendTempPassword().sendtempPassword();
			
			msg.setText(tempNum); //잘 됨.
			member.setUserId(userid);
			member.setUserPwd(tempNum); //임시비밀번호 저장

			int re = new MemberService().updateTempPassword(member); //비밀번호 업데이트
			response.setContentType("application/json; charset=utf-8");
			JSONObject job = new JSONObject();
			if(re > 0) {
				Transport.send(msg);
				System.out.println("The message sent successfully...");
				String str = "임시 비밀번호가 있는 이메일이 성공적으로 전송되었습니다. 로그인 후 비밀번호를 변경해주시기 바랍니다.";
				
				job = new JSONObject();
				job.put("str", str);
				
				out.println(job.toJSONString());
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		} else {
			response.setContentType("application/json; charset=utf-8");
			JSONObject job = new JSONObject();
			
			String str = "아이디 또는 이메일을 잘못 입력하셨습니다";
			job.put("str", str);
			
			out.println(job.toJSONString());
			out.flush();
			out.close();
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
