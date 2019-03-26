package member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import member.model.dao.MemberDao;
import member.model.service.MemberService;
import member.model.vo.MakeNaverId;
import member.model.vo.Member;

/**
 * Servlet implementation class NaverLoginServlet
 */
@WebServlet("/naverlogin")
public class NaverLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NaverLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 네이버 로그인 처리 컨트롤러
		
		String clientId = "obXTFPuiHDCuNQb5kAmx";
		String clientSecret = "gRoBiBR9aR"; 
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://127.0.0.1:8888/doggybeta/","UTF-8");
		
		StringBuffer apiURL = new StringBuffer();
		apiURL.append("https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&");
		apiURL.append("client_id=" + clientId);
		apiURL.append("&client_secret=" + clientSecret);
		apiURL.append("&redirect_uri=" + redirectURI);
		apiURL.append("&code=" + code);
		apiURL.append("&state=" + state);
		String access_token = "";
		String refresh_token = ""; //나중에 이용합시다
		/*System.out.println("1. apiRL : " + apiURL.toString());*/ //출력값 확인용
		
		try {
			URL url = new URL(apiURL.toString());
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) // 정상적으로 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			else //에러
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			
			 String inputLine;
		      StringBuffer res = new StringBuffer();
		      while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		      }
		      br.close();
		      if(responseCode==200) {
		        System.out.println(res.toString());
		        JSONParser parsing = new JSONParser();
		        Object obj = parsing.parse(res.toString()); //업캐스팅
		        JSONObject jsonObj = (JSONObject)obj; //다운캐스팅
		        
		        access_token = (String)jsonObj.get("access_token");
		        refresh_token = (String)jsonObj.get("refresh_token");
		      }
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 여기까지해도 response 리다이렉트하는 페이지에서 토큰값 꺼내서 볼 수 있음
		
		if(access_token != null) { //접근 토큰이 제대로 생성되었다면 아래 절차 진행
		String token = access_token;// 네이버 로그인 접근 토큰;
		String header = "Bearer " + token; // Bearer 다음에 공백 추가
		try {
		    String apiurl = "https://openapi.naver.com/v1/nid/me";
		    URL url = new URL(apiurl);
		    HttpURLConnection con = (HttpURLConnection)url.openConnection();
		    con.setRequestMethod("GET");
		    con.setRequestProperty("Authorization", header);
		    int responseCode = con.getResponseCode();
		    BufferedReader br;
		    if(responseCode==200) { // 정상 호출
		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		    } else {  // 에러 발생
		        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		    }
		    String inputLine;
		    StringBuffer res = new StringBuffer();
		    while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		    }
		    br.close();
		    
		    JSONParser parsing = new JSONParser();
		    Object obj = parsing.parse(res.toString());
		    JSONObject jsonObj = (JSONObject)obj;
		    JSONObject resObj = (JSONObject)jsonObj.get("response");
		    
		    String naverCode = (String)resObj.get("id"); //네이버고유식별자인데 token으로 대체
		    String email = (String)resObj.get("email");
		    String name = (String)resObj.get("name");
		    String nickName = (String)resObj.get("nickname");
		    
		    /*System.out.println("*** email : " + email);*/
		    
		    String naverRanId = new MakeNaverId().toString(); //랜덤아이디 생성
		    
		    MemberService mService = new MemberService();
		    Member member = new Member();
		    /*member.setUserId(id); 고유식별자*/
		    int re = mService.selectCheckNaverCode(email); //토큰으로 하면 안됨. 1시간마다 갱신되니까.
		    /*System.out.println("nls re : " + re);*/ //조회제대로 됐는지 확인하는 코드
		    if(re <= 0) { // db에 값이 없다면 인서트
		    	String splitToken = access_token.substring(2, 15) + access_token.substring(32, 43);
		    	/*System.out.println(splitToken + "<- 토큰나누기");*/ //제대로 섭스트링됐는지 확인용
		    	member.setUserId(naverCode);
		    	member.setEmail(email);
		    	member.setNaverCode(splitToken);
		    	member.setUserName(naverRanId);
		    	System.out.println("member : " + member.toString());
		    	int result = mService.insertMember(member);
		    	System.out.println("인서트 완료");
		    	
		    	if(result > 0) { // 인서트가 제대로 되었다면
		    		RequestDispatcher views = request.getRequestDispatcher("/jipsalogin");
		    		if(name == null) {
		    			request.setAttribute("nickname", nickName);
		    		} else {
		    			request.setAttribute("name", name);
		    		}
		    		request.setAttribute("access_token", access_token);
		    		request.setAttribute("naverId", naverRanId);
		    		request.setAttribute("email", email);
		    		views.forward(request, response);
		    	}
		    
		    } else {
		    	//db에 정보가 있다면
		    	Member mb = new Member();
		    	String splitToken = access_token.substring(2, 15) + access_token.substring(32, 43);
		    	/*System.out.println(splitToken + "<- 토큰나누기");*/ //제대로 섭스트링됐는지 확인용
		    	mb.setUserId(naverCode);
		    	mb.setEmail(email);
		    	mb.setNaverCode(splitToken);
		    	mb.setUserName(naverRanId);
		    	System.out.println("mb : " + mb.toString());
		    	int result = mService.updateNaverMember(mb);
		    	
		    	System.out.println("nsl update result : " + result);
		    	if(result > 0) { //업데이트가 잘 되었다면
		    		RequestDispatcher views = request.getRequestDispatcher("/jipsalogin");
		    		if(name == null) {
		    			request.setAttribute("nickname", nickName);
		    		} else {
		    			request.setAttribute("name", name);
		    		}
		    		request.setAttribute("access_token", access_token);
		    		request.setAttribute("naverId", naverRanId);
		    		request.setAttribute("email", email);
		    		views.forward(request, response);
		    	} else {
		    		RequestDispatcher view = request.getRequestDispatcher("views/member/memberError.jsp");
					request.setAttribute("message", "네이버 계정 로그인에 실패하였습니다. 다시 시도해주세요");
					view.forward(request, response);
		    	}
		    }
		    
		    System.out.println(res.toString());
		} catch (Exception e) {
		    System.out.println(e);
		}
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
