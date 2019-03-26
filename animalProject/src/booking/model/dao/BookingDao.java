package booking.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import static common.JDBCTemplate.*;


import booking.model.vo.BookingCheck;
import booking.model.vo.BookingForHost;

public class BookingDao {

	public ArrayList<BookingCheck> selectBkList(Connection conn, String userid) {
		ArrayList<BookingCheck> list = new ArrayList<>();
		BookingCheck bc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT B.BOOKING_NO, B.CHECKIN_DATE, B.CHECKOUT_DATE, B.BOOKING_PROGRESS, B.PUSER_ID, M.PRICE, M.ADDRESS, P.PET_NAME, B.SERVICE_KIND FROM BOOKING B JOIN MEMBER M ON (B.PUSER_ID = M.USER_ID) JOIN PET P ON (B.PET_NO = P.PET_NO) WHERE B.USER_ID = ?";
		
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				bc = new BookingCheck();
				bc.setBookingNo(rset.getInt(1));
				bc.setCheckInDate(rset.getDate(2));
				bc.setCheckOutDate(rset.getDate(3));
				bc.setBookingProgress(rset.getString(4));
				bc.setPuserId(rset.getString(5));
				bc.setPrice(rset.getInt(6));
				bc.setAddress(rset.getString(7));
				bc.setPetName(rset.getString(8));
				bc.setServiceKind(rset.getString(9));
				
				list.add(bc);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public ArrayList<BookingForHost> selectBkForHostList(Connection conn, String userid) {
		ArrayList<BookingForHost> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		BookingForHost b = null;
		
		String query = "SELECT B.BOOKING_NO, B.SERVICE_KIND, P.PET_NO, M.USER_NAME,M.ADDRESS, B.CHECKIN_DATE, B.CHECKOUT_DATE,B.BOOKING_PROGRESS, H.PRICE, B.BOOKING_ETC FROM BOOKING B JOIN MEMBER M ON (B.USER_ID = M.USER_ID) JOIN PET P ON (M.USER_ID = P.USER_ID) JOIN MEMBER H ON (B.PUSER_ID = H.USER_ID) WHERE PUSER_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				b = new BookingForHost();
				b.setBookingNo(rset.getInt(1));
				b.setServiceKind(rset.getString(2));
				b.setPetNo(rset.getInt(3));
				b.setUserName(rset.getString(4));
				b.setAddress(rset.getString(5));
				b.setCheckInDate(rset.getDate(6));
				b.setCheckOutDate(rset.getDate(7));
				b.setProgress(rset.getString(8));
				b.setPrice(rset.getInt(9));
				b.setEtc(rset.getString(10));
				
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
}
