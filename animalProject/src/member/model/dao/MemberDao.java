package member.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import member.model.vo.SearchingInfo;
import static common.JDBCTemplate.*;
import member.model.vo.Member;
import member.model.vo.SitterImage;


public class MemberDao {
	public MemberDao () {}

	public Member loginCheck(Connection conn, String userid, String userpwd) {
		// 일반 유저 로그인 확인
		Member member = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		StringBuffer query = new StringBuffer();
		query.append("select * from member where user_id = ? and password = ?");
		/*System.out.println(userid +", "+userpwd);*/ //값 잘 받는지 확인

		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, userid);
			pstat.setString(2, userpwd);
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				member = new Member();
				member.setUserId(userid);
				member.setEmail(rSet.getString("email"));
				member.setUserName(rSet.getString("user_name"));
				member.setAddress(rSet.getString("address"));
				member.setPhone(rSet.getString("phone"));
				member.setJob(rSet.getString("job"));
				member.setPetSitter(rSet.getString("petsitter"));
				member.setPrice(rSet.getInt("price"));
				member.setUserDate(rSet.getDate("user_date"));
				member.setUserPwd(userpwd);
				member.setUserDelete(rSet.getString("user_delete"));
				member.setNaverCode(rSet.getString("NAVER_CODE"));
				System.out.println(member + " <- dao member");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return member;
	}
	public Member loginNaverCheck(Connection conn, String userid, String token) {
		// 네이버으로 가입한 회원 로그인 확인
		Member member = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select * from member where email = ? and naver_code = ?");
		/*System.out.println(userid +", token : "+token);*/ //값 잘 받는지 확인
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, userid);
			pstat.setString(2, token);
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				member = new Member();
				member.setUserId(userid);
				member.setEmail(rSet.getString("email"));
				member.setUserName(rSet.getString("user_name"));
				member.setAddress(rSet.getString("address"));
				member.setPhone(rSet.getString("phone"));
				member.setJob(rSet.getString("job"));
				member.setPetSitter(rSet.getString("petsitter"));
				member.setPrice(rSet.getInt("price"));
				member.setUserDate(rSet.getDate("user_date"));
				member.setUserPwd(rSet.getString("password"));
				member.setUserDelete(rSet.getString("user_delete"));
				member.setNaverCode(token);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return member;
	}

	public int findPassword(Connection conn, Member member) {
		//비밀번호 찾기
		int result = 0;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select count(*) from member where user_id = ? and email = ?");
		
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, member.getUserId());
			pstat.setString(2, member.getEmail());
			
			rSet = pstat.executeQuery();
			if(rSet.next()) {
				result = rSet.getInt(1);
			}
			System.out.println("findPwd result : " + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return result;
	}

	public int updateTempPassword(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstat = null;
		StringBuffer query = new StringBuffer();
		query.append("update member set password = ? where user_id = ?");
		try {
			pstat = conn.prepareStatement(query.toString());
			
			pstat.setString(1, member.getUserPwd());
			pstat.setString(2, member.getUserId());
			
			result = pstat.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}

	public int insertMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstat = null;
		StringBuffer query = new StringBuffer();
		query.append("insert into member values ( ");
		query.append("?,?,?,?,?,?,default,?,sysdate,?,default,?,?,?)");
		
		try {
			
			pstat = conn.prepareStatement(query.toString());
			System.out.println(query.toString());
			pstat.setString(1, member.getUserId());
			pstat.setString(2, member.getEmail());
			pstat.setString(3, member.getUserName());
			pstat.setString(4, member.getAddress());
			pstat.setString(5, member.getPhone());
			pstat.setString(6, member.getJob());
			pstat.setInt(7, member.getPrice());
			pstat.setString(8, member.getUserPwd());
			pstat.setString(9, member.getUseroriginfile());
			pstat.setString(10, member.getUserrefile());
			pstat.setString(11, member.getNaverCode());
			
			result = pstat.executeUpdate();
			System.out.println("DAO : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}
	
	public int selectCheckId(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select count(user_id) from member where user_id = ?");
		
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, userId);
			System.out.println(userId);
			
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				result = rSet.getInt(1);
			}
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return result;
	}
	public int updateHost(Connection conn, Member m) {
	      int result = 0;
	      PreparedStatement pstmt = null;
	      String query = "update member set petsitter = '1', phone=? , email = ?, address = ? , price = ?, user_originfile = ?, user_refile =?, user_name = ? where user_id = ?";
	      
	      try {
	         pstmt = conn.prepareStatement(query);
	         pstmt.setString(1, m.getPhone());
	         pstmt.setString(2, m.getEmail());
	         pstmt.setString(3, m.getAddress());
	         pstmt.setInt(4, m.getPrice());
	         pstmt.setString(5, m.getUseroriginfile());
	         pstmt.setString(6, m.getUserrefile());
	         pstmt.setString(7, m.getUserName());
	         pstmt.setString(8, m.getUserId());
	         
	         result = pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         close(pstmt);
	      }
	      
	      return result;
	   }
	public int selectCheckNaverCode(Connection conn, String email) {
		int result = 0;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select count(user_id) from member where naver_code is not null and email = ?");
		
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, email);
			System.out.println(email);
			
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				result = rSet.getInt(1);
			}
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return result;
	}


	public ArrayList<SearchingInfo> searchPetSitter(Connection conn, String userid) {
		ArrayList<SearchingInfo> list = new ArrayList<SearchingInfo>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT P.PET_BREADS, P.PET_SIZE, TRUNC(MONTHS_BETWEEN(sysdate, pet_date)/12) as AGE  FROM MEMBER M JOIN PET P ON(P.USER_ID = M.USER_ID) WHERE M.USER_ID = ?";
		System.out.println("dao단 id조회 : " + userid);
		
		try {
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				SearchingInfo petInfo = new SearchingInfo();
				
				petInfo.setPetBreads(rset.getString(1));
				petInfo.setPetSize(rset.getString(2));
				petInfo.setAge(rset.getInt(3));
				petInfo.setUserId(userid);
				
				list.add(petInfo);
			}
			System.out.println("dao단 : " + list.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<SearchingInfo> insertCondition(Connection conn, HashMap<String, Object> map) {
		ArrayList<SearchingInfo> list = new ArrayList<SearchingInfo>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "";
		
		return list;
	}

	public int updateNaverMember(Connection conn, Member member) {
		//네이버 로그인시 이미 등록되어있는 계정이라면
		int result = 0;
		PreparedStatement pstat = null;
		
		StringBuffer query = new StringBuffer();
		query.append("update member set ");
		query.append("naver_code = ?, user_name = ? ");
		query.append("where user_id = ?");
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, member.getNaverCode());
			pstat.setString(2, member.getUserName());
			pstat.setString(3, member.getUserId());
			
			result = pstat.executeUpdate();
			System.out.println("naver update dao : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}

	public int insertSitterImages(Connection conn, ArrayList<SitterImage> list) {
		int result = 0;
		PreparedStatement pstmt = null;
		int num = getSitterImagesCount(conn);
		String query = "INSERT ALL ";
		for(int i = 0; i < list.size(); i++) {
			query += "INTO SITTERIMG VALUES ( ?, ?, ?, ? ) ";
		}
		query += " SELECT * FROM DUAL";
		try {
			pstmt = conn.prepareStatement(query);
			int count = 1;
			for(int j = 0; j < list.size(); j++) {
				pstmt.setInt(count++, num++);
				pstmt.setString(count++, list.get(j).getUserId());
				pstmt.setString(count++, list.get(j).getOriginFile());
				pstmt.setString(count++, list.get(j).getRenameFile());
			}
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	private int getSitterImagesCount(Connection conn) {
		int count = 0;
		Statement stmt = null;
		String query = "SELECT COUNT(*) FROM SITTERIMG";
		ResultSet rset = null;
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				count = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return count;

	}

}
