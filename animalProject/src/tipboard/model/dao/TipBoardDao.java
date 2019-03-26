package tipboard.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import notice.model.vo.Notice;

import static common.JDBCTemplate.*;

import tipboard.model.vo.TipBoard;

public class TipBoardDao {

	public int getListCount(Connection conn, String option, String word) {
		int listCount = 0;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from tipboard";
		
		try {
			System.out.println("페이징 변경시 option이 뭐냐?" + option);
			if(option == null) {
				stmt = conn.createStatement();
				rset = stmt.executeQuery(query);	
				System.out.println("여기로 가는지 확인");
			}else if(option.equals("title")) {
				query = "select count(*) from tipboard where tipboard_title like ? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + word + "%");
				rset = pstmt.executeQuery();
			}else if(option.equals("content")) {
				query = "select count(*) from tipboard where tipboard_content like ? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + word + "%");
				rset = pstmt.executeQuery();
			}else if(option.equals("title_content")) {
				query = "select count(*) from tipboard where tipboard_title like ? or tipboard_content like ? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + word + "%");
				pstmt.setString(2, "%" + word + "%");
				rset = pstmt.executeQuery();
			}else if(option.equals("writer")) {
				query = "select count(*) from tipboard where user_id like ? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + word + "%");
				rset = pstmt.executeQuery();
			}else {
				stmt = conn.createStatement();
				rset = stmt.executeQuery(query);	
				System.out.println("여기로 가는지 확인2");
			}
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
		
		return listCount;
	}

	public ArrayList<TipBoard> selectList(Connection conn, int currentPage, int limit, String option, String word) {
			ArrayList<TipBoard> list = new ArrayList<TipBoard>();
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			//해당 페이지에 출력할 목록의 시작행과 끝행 계산
			int startRow = (currentPage -1) * limit + 1;
			int endRow = startRow + limit - 1;
			
			/*String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
					"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) order by tipboard_no desc)) " + 
					"				WHERE RNUM >= ? AND RNUM <= ? ";*/
			/*String query = "select * from tipboard";*/
			
			try {
				if(option == null) {
					String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
							"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) order by tipboard_no desc)) " + 
							"				WHERE RNUM >= ? AND RNUM <= ? ";
					pstmt = conn.prepareStatement(query);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);
					rset = pstmt.executeQuery();
					while(rset.next()) {
						TipBoard tboard = new TipBoard();
						tboard.setTipBoardNo(rset.getInt("tipboard_no"));
						tboard.setTipBoardTitle(rset.getString("tipboard_title"));
						tboard.setTipBoardContent(rset.getString("tipboard_content"));
						tboard.setTipBoardDate(rset.getDate("tipboard_date"));
						tboard.setTipBoardOriginFile(rset.getString("tipboard_originfile"));
						tboard.setTipBoardViews(rset.getInt("tipboard_views"));
						tboard.setTipBoardRecommend(rset.getInt("tipboard_recommend"));
						tboard.setUserId(rset.getString("user_id"));
						tboard.setTipBoardDelete(rset.getString("tipboard_delete"));
						tboard.setTipBoardReFile(rset.getString("tipboard_refile"));
						list.add(tboard);
					}
				}else if(option.equals("title")) {
					String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
							"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) and tipboard_title like ? order by tipboard_no desc)) " + 
							"				WHERE RNUM >= ? AND RNUM <= ? ";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, "%" + word + "%");
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
					
					rset = pstmt.executeQuery();
					while(rset.next()) {
						TipBoard tboard = new TipBoard();
						tboard.setTipBoardNo(rset.getInt("tipboard_no"));
						tboard.setTipBoardTitle(rset.getString("tipboard_title"));
						tboard.setTipBoardContent(rset.getString("tipboard_content"));
						tboard.setTipBoardDate(rset.getDate("tipboard_date"));
						tboard.setTipBoardOriginFile(rset.getString("tipboard_originfile"));
						tboard.setTipBoardViews(rset.getInt("tipboard_views"));
						tboard.setTipBoardRecommend(rset.getInt("tipboard_recommend"));
						tboard.setUserId(rset.getString("user_id"));
						tboard.setTipBoardDelete(rset.getString("tipboard_delete"));
						tboard.setTipBoardReFile(rset.getString("tipboard_refile"));
						list.add(tboard);
					}
				}else if(option.equals("content")) {
					String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
							"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) and tipboard_content like ? order by tipboard_no desc)) " + 
							"				WHERE RNUM >= ? AND RNUM <= ? ";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, "%" + word + "%");
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
					
					rset = pstmt.executeQuery();
					while(rset.next()) {
						TipBoard tboard = new TipBoard();
						tboard.setTipBoardNo(rset.getInt("tipboard_no"));
						tboard.setTipBoardTitle(rset.getString("tipboard_title"));
						tboard.setTipBoardContent(rset.getString("tipboard_content"));
						tboard.setTipBoardDate(rset.getDate("tipboard_date"));
						tboard.setTipBoardOriginFile(rset.getString("tipboard_originfile"));
						tboard.setTipBoardViews(rset.getInt("tipboard_views"));
						tboard.setTipBoardRecommend(rset.getInt("tipboard_recommend"));
						tboard.setUserId(rset.getString("user_id"));
						tboard.setTipBoardDelete(rset.getString("tipboard_delete"));
						tboard.setTipBoardReFile(rset.getString("tipboard_refile"));
						list.add(tboard);
					}
				}else if(option.equals("title_content")) {
					String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
							"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) and (tipboard_content like ? or tipboard_title like ?) order by tipboard_no desc)) " + 
							"				WHERE RNUM >= ? AND RNUM <= ? ";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, "%" + word + "%");
					pstmt.setString(2, "%" + word + "%");
					pstmt.setInt(3, startRow);
					pstmt.setInt(4, endRow);
					
					rset = pstmt.executeQuery();
					while(rset.next()) {
						TipBoard tboard = new TipBoard();
						tboard.setTipBoardNo(rset.getInt("tipboard_no"));
						tboard.setTipBoardTitle(rset.getString("tipboard_title"));
						tboard.setTipBoardContent(rset.getString("tipboard_content"));
						tboard.setTipBoardDate(rset.getDate("tipboard_date"));
						tboard.setTipBoardOriginFile(rset.getString("tipboard_originfile"));
						tboard.setTipBoardViews(rset.getInt("tipboard_views"));
						tboard.setTipBoardRecommend(rset.getInt("tipboard_recommend"));
						tboard.setUserId(rset.getString("user_id"));
						tboard.setTipBoardDelete(rset.getString("tipboard_delete"));
						tboard.setTipBoardReFile(rset.getString("tipboard_refile"));
						list.add(tboard);
					}
				}else if(option.equals("writer")) {
					String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
							"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) and user_id like ? order by tipboard_no desc)) " + 
							"				WHERE RNUM >= ? AND RNUM <= ? ";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, "%" + word + "%");
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
					
					rset = pstmt.executeQuery();
					while(rset.next()) {
						TipBoard tboard = new TipBoard();
						tboard.setTipBoardNo(rset.getInt("tipboard_no"));
						tboard.setTipBoardTitle(rset.getString("tipboard_title"));
						tboard.setTipBoardContent(rset.getString("tipboard_content"));
						tboard.setTipBoardDate(rset.getDate("tipboard_date"));
						tboard.setTipBoardOriginFile(rset.getString("tipboard_originfile"));
						tboard.setTipBoardViews(rset.getInt("tipboard_views"));
						tboard.setTipBoardRecommend(rset.getInt("tipboard_recommend"));
						tboard.setUserId(rset.getString("user_id"));
						tboard.setTipBoardDelete(rset.getString("tipboard_delete"));
						tboard.setTipBoardReFile(rset.getString("tipboard_refile"));
						list.add(tboard);
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			return list;
	}

	public int addReadCount(Connection conn, int tipBoardNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "update tipboard set tipboard_views = tipboard_views + 1 where tipboard_no = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, tipBoardNum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public TipBoard selectBoard(Connection conn, int tipBoardNum) {
		TipBoard tboard = new TipBoard();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from tipboard where tipboard_no = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, tipBoardNum);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				tboard.setTipBoardNo(rset.getInt("tipboard_no"));
				tboard.setTipBoardTitle(rset.getString("tipboard_title"));
				tboard.setTipBoardContent(rset.getString("tipboard_content"));
				tboard.setTipBoardDate(rset.getDate("tipboard_date"));
				tboard.setTipBoardOriginFile(rset.getString("tipboard_originfile"));
				tboard.setTipBoardViews(rset.getInt("tipboard_views"));
				tboard.setTipBoardRecommend(rset.getInt("tipboard_recommend"));
				tboard.setUserId(rset.getString("user_id"));
				tboard.setTipBoardDelete(rset.getString("tipboard_delete"));
				tboard.setTipBoardReFile(rset.getString("tipboard_refile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return tboard;
	}

	public int insertBoard(Connection conn, TipBoard tboard) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into tipboard values (seq_tipboardno.nextval,?,?,default,?,0,0,?,default,?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, tboard.getTipBoardTitle());
			pstmt.setString(2, tboard.getTipBoardContent());
			pstmt.setString(3, tboard.getTipBoardOriginFile());
			pstmt.setString(4, tboard.getUserId());
			pstmt.setString(5, tboard.getTipBoardReFile());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateTipBoard(Connection conn, TipBoard tboard) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "update tipboard set tipboard_title = ?, tipboard_content = ?, TIPBOARD_ORIGINFILE = ?, TIPBOARD_REFILE = ? where tipboard_no = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, tboard.getTipBoardTitle());
			pstmt.setString(2, tboard.getTipBoardContent());
			pstmt.setString(3, tboard.getTipBoardOriginFile());
			pstmt.setString(4, tboard.getTipBoardReFile());
			pstmt.setInt(5, tboard.getTipBoardNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<TipBoard> selectDateList(Connection conn, Date begin, Date end, int currentPage, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<TipBoard> selectTitleList(Connection conn, String title, int currentPage, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<TipBoard> selectWriterList(Connection conn, String writer, int currentPage, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

	public int deleteTipBoard(Connection conn, int tipBoardNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		/*String query = "delete from tipboard where tipboard_no = ?";*/
		//업데이트로
		String query  = "update tipboard set tipboard_delete = 'y' where tipboard_no = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, tipBoardNum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

}
