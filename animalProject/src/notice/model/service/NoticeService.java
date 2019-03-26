package notice.model.service;

import java.sql.Connection;

import java.util.ArrayList;
import java.util.HashMap;

import notice.model.dao.NoticeDao;
import notice.model.vo.Notice;
import static common.JDBCTemplate.*;

public class NoticeService {
	private NoticeDao ndao = new NoticeDao();
	
	public NoticeService() {}
	
	public ArrayList<Notice> selectList() {
		Connection conn = getConnection();
		ArrayList<Notice> list = ndao.selectList(conn);
		close(conn);
		return list;
	}

	public int insertNotice(Notice notice) {
		Connection conn = getConnection();
		int result = ndao.insertNotice(conn, notice);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public Notice selectOne(int noticeNo) {
		Connection conn = getConnection();
		Notice notice = ndao.selectOne(conn, noticeNo);
		close(conn);
		
		return notice;
	}

	public int deleteNotice(int noticeNo) {
		Connection conn = getConnection();
		int result = ndao.deleteNotice(conn, noticeNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int updateNotice(Notice notice) {
		Connection conn = getConnection();
		int result = ndao.updateNotice(conn, notice);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public void addReadCount(int noticeNo) {
		Connection conn = getConnection();
		int result = ndao.addReadCount(conn, noticeNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		
	}

/*	public ArrayList<Notice> selectSearchTitle(String noticeTitle) {
		Connection conn = getConnection();
		ArrayList<Notice> list = ndao.selectSearchTitle(conn, noticeTitle);
		close(conn);
		return list;
	}

	public ArrayList<Notice> selectSearchDate(Date beginDate, Date endDate) {
		Connection conn = getConnection();
		ArrayList<Notice> list = ndao.selectSearchDate(conn, beginDate, endDate);
		close(conn);
		return list;
	}
*/
	public ArrayList<Notice> selectSearch(HashMap<String, Object> map) {
		Connection conn = getConnection();
		ArrayList<Notice> list = ndao.selectSearch(conn, map);
		close(conn);
		return list;
	}

}
