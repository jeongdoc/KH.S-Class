package freeboard.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import freeboard.model.dao.FreeBoardDao;
import freeboard.model.vo.FreeBoard;
import freeboardreply.model.vo.FreeBoardReply;

public class FreeBoardService {
	private FreeBoardDao fdao = new FreeBoardDao();
	
	public FreeBoardService() {}
	
	public int getListCount(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		int listCount = fdao.getListCount(conn, listOpt);
		close(conn);
		return listCount;
	}

	
	public void addReadCount(int freeBoardNo) {
		Connection conn = getConnection();
		int result = fdao.addReadCount(conn, freeBoardNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
	}

	

	public int insertFreeBoard(FreeBoard freeBoard) {
		Connection conn = getConnection();
		int result = fdao.insertFreeBoard(conn, freeBoard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}


	public int updateFreeBoard(FreeBoard freeboard) {
		Connection conn = getConnection();
		int result = fdao.updateFreeBoard(conn, freeboard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	
	public int deleteFreeBoard(int boardNum) {
		Connection conn = getConnection();
		int result = fdao.deleteFreeBoard(conn, boardNum);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	
	
	public ArrayList<FreeBoard> searchList(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		ArrayList<FreeBoard> list = fdao.searchList(conn, listOpt);
		close(conn);
		return list;
	}

	public FreeBoard selectFreeBoard(int freeBoardNo) {
		Connection conn = getConnection();
		FreeBoard freeBoard = fdao.selectFreeBoard(conn, freeBoardNo);
		close(conn);
		
		return freeBoard;
	}

	
	
}

