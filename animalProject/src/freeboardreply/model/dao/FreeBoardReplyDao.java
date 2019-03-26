package freeboardreply.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import freeboard.model.vo.FreeBoard;
import freeboardreply.model.vo.FreeBoardReply;

public class FreeBoardReplyDao {

	public int updateReply(Connection conn, FreeBoardReply replyBoard) {
		
		return 0;
	}

	public int updateReplySeq(Connection conn, FreeBoardReply replyBoard) {
		
		return 0;
	}

	public int insertReply(Connection conn, FreeBoardReply replyBoard) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO FREEBOARD_REPLY VALUES(seq_freply.nextval, ?, SYSDATE, 'user01', ?, 'N')";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, replyBoard.getFreereplycontent());
			pstmt.setInt(2, replyBoard.getFreeboardno());
	
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	

	public int deleteReply(Connection conn, FreeBoardReply replyBoard) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public FreeBoard selectFreeBoard(Connection conn, int freeBoardNo) {
		FreeBoard freeboard = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from freeboard "
				+ "where freeboard_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeBoardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				freeboard = new FreeBoard();
				
				freeboard.setFreeboardNo(rset.getInt("FREEBOARD_NO"));
				freeboard.setFreeboardTitle(rset.getString("FREEBOARD_TITLE"));
				freeboard.setFreeboardContent(rset.getString("FREEBOARD_CONTENT"));
				freeboard.setFreeboardDate(rset.getDate("FREEBOARD_DATE"));
				freeboard.setFreeboardOriginalFile(rset.getString("FREEBOARD_ORIGINFILE"));
				freeboard.setFreeboardViews(rset.getInt("FREEBOARD_VIEWS"));
				freeboard.setFreeboardRecommend(rset.getInt("FREEBOARD_RECOMMEND"));
				freeboard.setUserId(rset.getString("USER_ID"));
				freeboard.setFreeboardDelete(rset.getString("FREEBOARD_DELETE"));
				freeboard.setFreeboardRefile(rset.getString("FREEBOARD_REFILE"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return freeboard;
	}

	
	public ArrayList<FreeBoardReply> selectReplyList(Connection conn, HashMap<String, Object> map) {
		ArrayList<FreeBoardReply> flist = new ArrayList<>();
		
		int freeBoardNo = (Integer)map.get("freeBoardNo");
		int startRow = (Integer)map.get("startRow");		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * " + 
					   "FROM(SELECT ROWNUM RNUM, FREEREPLY_NO, FREEREPLY_CONTENT, " + 
					   "FREEREPLY_DATE, USER_ID, FREEBOARD_DELETE, FREEBOARD_NO " + 
					   "FROM (SELECT * " + 
					   "FROM FREEBOARD_REPLY WHERE " + 
					   "FREEBOARD_NO = (SELECT FREEBOARD_NO FROM FREEBOARD WHERE FREEBOARD_NO = ?) " + 
					   "AND FREEBOARD_DELETE IN('N', 'n', null) ORDER BY FREEREPLY_NO ASC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";	
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeBoardNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, startRow+9);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				FreeBoardReply freeReply = new FreeBoardReply();
				
				freeReply.setFreeboardno(rset.getInt("FREEREPLY_NO"));
				freeReply.setFreereplycontent(rset.getString("FREEREPLY_CONTENT"));
				freeReply.setFreereplydate(rset.getDate("FREEREPLY_DATE"));
				freeReply.setUserid(rset.getString("USER_ID"));
				freeReply.setFreeboardno(rset.getInt("FREEBOARD_NO"));
				freeReply.setFreeboarddelete(rset.getString("FREEBOARD_DELETE"));				
				
				flist.add(freeReply);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return flist;
	}


}
