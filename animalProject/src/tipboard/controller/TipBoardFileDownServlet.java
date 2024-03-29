package tipboard.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TipBoardFileDownServlet
 */
@WebServlet("/tfdown")
public class TipBoardFileDownServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardFileDownServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 첨부파일 다운로드 처리용 컨트롤러
		// 1.
		request.setCharacterEncoding("utf-8");

		// 2.
		String tipOriginalFileName = request.getParameter("tofile");
		String tipRenameFileName = request.getParameter("trfile");

		// 3. 웹프로젝트 내의 저장폴더 지정
		String readFolder = request.getSession().getServletContext().getRealPath("/files/tipboard");

		// 4. 클라이언트로 내보낼 출력 스트림 생성
		ServletOutputStream downOut = response.getOutputStream();

		// 5. 다운로드에 사용될 파일 객체 생성
		File downFile = new File(readFolder + "/" + tipRenameFileName);

		// 6. 파일 다운로드에 대한 컨텐츠 타입 지정
		response.setContentType("text/plain; charset=utf-8");
		// 원본파일명에 한글 인코딩 처리
		response.addHeader("Content-Disposition",
				"attachment; filename=\"" + new String(tipOriginalFileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
		response.setContentLength((int) downFile.length());

		// 7. 저장폴더에서 파일 읽어서 클라이언트로 내보냄
		BufferedInputStream bin = new BufferedInputStream(new FileInputStream(downFile));

		int read = -1;
		while ((read = bin.read()) != -1) {
			downOut.write(read);
			downOut.flush();
		}

		downOut.close();
		bin.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
