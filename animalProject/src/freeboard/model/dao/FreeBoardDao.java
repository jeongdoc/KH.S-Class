package freeboard.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import freeboard.model.vo.FreeBoard;

public class FreeBoardDao {
	
	public FreeBoardDao() {}

	public int getListCount(Connection conn, HashMap<String, Object> listOpt) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int listCount = 1;
		
		if(opt == null) {
		
		String query = "select count(*) from freeboard";
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		}else if(opt.equals("0")) {
			
			String query = "select count(*) from freeboard where freeboard_title like ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					listCount = rset.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			
		}else if(opt.equals("1")) {
			
			String query = "select count(*) from freeboard where user_id like ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					listCount = rset.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
		}else if(opt.equals("2")) {
			
			String query = "select count(*) from freeboard_title like ? or freeboard_content like ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setString(2, "%" + inputdata + "%");
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					listCount = rset.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			
		}
		return listCount;
		
	}
	

	public int insertFreeBoard(Connection conn, FreeBoard freeboard) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO FREEBOARD VALUES(seq_freeboardno.nextval, ?, ?, SYSDATE, ?, ?, ?, 'user01', DEFAULT, DEFAULT)";
		System.out.println(freeboard);
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, freeboard.getFreeboardTitle());
			pstmt.setString(2, freeboard.getFreeboardContent());
			pstmt.setString(3, freeboard.getFreeboardOriginalFile());
			pstmt.setInt(4, freeboard.getFreeboardViews());
			pstmt.setInt(5, freeboard.getFreeboardRecommend());
		/*	pstmt.setString(6, freeboard.getUserId());\*/
			
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public int deleteFreeBoard(Connection conn, int boardNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update freeboard set freeboard_delete = 'y' where freeboard_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);				
			pstmt.setInt(1, boardNum);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public int updateFreeBoard(Connection conn, FreeBoard freeboard) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update freeboard "
				+ "set freeboard_title = ?, "
				+ "freeboard_content = ?, "
				+ "FREEBOARD_ORIGINFILE = ?, "
				+ "FREEBOARD_REFILE = ? "
				+ "where freeboard_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, freeboard.getFreeboardTitle());
			pstmt.setString(2, freeboard.getFreeboardContent());
			pstmt.setString(3, freeboard.getFreeboardOriginalFile());
			pstmt.setString(4, freeboard.getFreeboardRefile());
			pstmt.setInt(5, freeboard.getFreeboardNo());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public int addReadCount(Connection conn, int boardNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update freeboard "
				+ "set freeboard_views = freeboard_views + 1 "
				+ "where freeboard_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, boardNum);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public ArrayList<FreeBoard> searchList(Connection conn, HashMap<String, Object> listOpt) {
		ArrayList<FreeBoard> list = new ArrayList<FreeBoard>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int startRow = (Integer)listOpt.get("startRow");
		
		
		if(opt == null){
			
			String query = "SELECT * " + 
					"FROM (SELECT ROWNUM RNUM, FREEBOARD_NO, " + 
					"FREEBOARD_TITLE, FREEBOARD_CONTENT, " + 
					"FREEBOARD_DATE, " + 
					"FREEBOARD_ORIGINFILE, FREEBOARD_VIEWS, " + 
					"FREEBOARD_RECOMMEND, " +
					"USER_ID, " + 
					"FREEBOARD_DELETE, FREEBOARD_REFILE " + 
					"FROM (SELECT * FROM FREEBOARD WHERE FREEBOARD_DELETE IN('n', 'N', null) " +
					"ORDER BY FREEBOARD_NO DESC)) " +  
					"WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, startRow+9);
				
				rset = pstmt.executeQuery();
							
				while(rset.next()) {
					
					FreeBoard freeboard = new FreeBoard();
					
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
					
					list.add(freeboard);
					}
		
			} catch (Exception e) {
				e.printStackTrace();
			}	
			
			
		}else if(opt.equals("0")) {
			
			String query = "SELECT * " + 
					"FROM (SELECT ROWNUM RNUM, FREEBOARD_NO, " + 
					"FREEBOARD_TITLE, FREEBOARD_CONTENT, " + 
					"FREEBOARD_DATE, " + 
					"FREEBOARD_ORIGINFILE, FREEBOARD_VIEWS, " + 
					"FREEBOARD_RECOMMEND, " +
					"USER_ID, " + 
					"FREEBOARD_DELETE, FREEBOARD_REFILE " + 
					"FROM (SELECT * FROM FREEBOARD " +
					"WHERE FREEBOARD_TITLE LIKE ? AND FREEBOARD_DELETE IN('n', 'N', null) " +
					"ORDER BY FREEBOARD_NO DESC)) " +  
					"WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
								
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						FreeBoard freeboard = new FreeBoard();
						
						freeboard.setFreeboardNo(rset.getInt("FREEBOARD_NO"));
						freeboard.setFreeboardTitle(rset.getString("FREEBOARD_TITLE"));
						freeboard.setFreeboardContent(rset.getString("FREEBOARD_CONTENT"));
						freeboard.setFreeboardDate(rset.getDate("FREEBOARD_DATE"));
						freeboard.setFreeboardOriginalFile(rset.getString("FREEBOARD_ORIGINFILE"));
						freeboard.setFreeboardViews(rset.getInt("FREEBOARD_VIEWS"));
						freeboard.setUserId(rset.getString("USER_ID"));
						freeboard.setFreeboardDelete(rset.getString("FREEBOARD_DELETE"));
						freeboard.setFreeboardRefile(rset.getString("FREEBOARD_REFILE"));
						
						list.add(freeboard);
						}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			
			
		}else if(opt.equals("1")) {
			
			String query = "SELECT * " + 
					"FROM (SELECT ROWNUM RNUM, FREEBOARD_NO, " + 
					"FREEBOARD_TITLE, FREEBOARD_CONTENT, " + 
					"FREEBOARD_DATE, " + 
					"FREEBOARD_ORIGINFILE, FREEBOARD_VIEWS, " + 
					"FREEBOARD_RECOMMEND, " + 
					"USER_ID, " + 
					"FREEBOARD_DELETE, FREEBOARD_REFILE " + 
					"FROM (SELECT * FROM FREEBOARD " +
					"WHERE USER_ID LIKE ? AND FREEBOARD_DELETE IN('n', 'N', null) " +
					"ORDER BY FREEBOARD_NO DESC)) " +  
					"WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
				
				
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						FreeBoard freeboard = new FreeBoard();
						
						freeboard.setFreeboardNo(rset.getInt("FREEBOARD_NO"));
						freeboard.setFreeboardTitle(rset.getString("FREEBOARD_TITLE"));
						freeboard.setFreeboardContent(rset.getString("FREEBOARD_CONTENT"));
						freeboard.setFreeboardDate(rset.getDate("FREEBOARD_DATE"));
						freeboard.setFreeboardOriginalFile(rset.getString("FREEBOARD_ORIGINFILE"));
						freeboard.setFreeboardViews(rset.getInt("FREEBOARD_VIEWS"));
						freeboard.setUserId(rset.getString("USER_ID"));
						freeboard.setFreeboardDelete(rset.getString("FREEBOARD_DELETE"));
						freeboard.setFreeboardRefile(rset.getString("FREEBOARD_REFILE"));
						
						list.add(freeboard);
					}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
					
		}else if(opt.equals("2")) {
			
			String query = "SELECT * " + 
					"FROM (SELECT ROWNUM RNUM, FREEBOARD_NO, " + 
					"FREEBOARD_TITLE, FREEBOARD_CONTENT, " + 
					"FREEBOARD_DATE, " + 
					"FREEBOARD_ORIGINFILE, FREEBOARD_VIEWS, " + 
					"FREEBOARD_RECOMMEND, " + 
					"USER_ID, " + 
					"FREEBOARD_DELETE, FREEBOARD_REFILE " + 
					"FROM (SELECT * FROM FREEBOARD " +
					"WHERE FREEBOARD_TITLE LIKE ? OR FREEBOARD_CONTENT LIKE ? AND FREEBOARD_DELETE IN('n', 'N', null) " +
					"ORDER BY FREEBOARD_NO DESC)) " +  
					"WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setString(2, "%" + inputdata + "%");
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, startRow+9);
				
				
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						FreeBoard freeboard = new FreeBoard();
						
						freeboard.setFreeboardNo(rset.getInt("FREEBOARD_NO"));
						freeboard.setFreeboardTitle(rset.getString("FREEBOARD_TITLE"));
						freeboard.setFreeboardContent(rset.getString("FREEBOARD_CONTENT"));
						freeboard.setFreeboardDate(rset.getDate("FREEBOARD_DATE"));
						freeboard.setFreeboardOriginalFile(rset.getString("FREEBOARD_ORIGINFILE"));
						freeboard.setFreeboardViews(rset.getInt("FREEBOARD_VIEWS"));
						freeboard.setUserId(rset.getString("USER_ID"));
						freeboard.setFreeboardDelete(rset.getString("FREEBOARD_DELETE"));
						freeboard.setFreeboardRefile(rset.getString("FREEBOARD_REFILE"));
						
						list.add(freeboard);
					}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
		}
		return list;

}

	public FreeBoard selectFreeBoard(Connection conn, int freeBoardNo) {
		FreeBoard freeboard = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from freeboard where freeboard_no = ?";
		
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
}
	
	



