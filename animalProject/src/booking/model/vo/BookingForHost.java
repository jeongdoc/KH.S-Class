package booking.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class BookingForHost implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4920180258796752908L;
	private int bookingNo;
	private String serviceKind;
	private String userName;
	private Date checkInDate;
	private Date checkOutDate;
	private int price;
	private String progress;
	private String etc;
	private int petNo;
	private String address;
	
	public BookingForHost() {
	}

	public BookingForHost(int bookingNo, String serviceKind, String userName, Date checkInDate, Date checkOutDate,
			int price, String progress, String etc, int petNo, String address) {
		super();
		this.bookingNo = bookingNo;
		this.serviceKind = serviceKind;
		this.userName = userName;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.price = price;
		this.progress = progress;
		this.etc = etc;
		this.petNo = petNo;
		this.address = address;
	}

	public int getBookingNo() {
		return bookingNo;
	}

	public void setBookingNo(int bookingNo) {
		this.bookingNo = bookingNo;
	}

	public String getServiceKind() {
		return serviceKind;
	}

	public void setServiceKind(String serviceKind) {
		this.serviceKind = serviceKind;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getCheckInDate() {
		return checkInDate;
	}

	public void setCheckInDate(Date checkInDate) {
		this.checkInDate = checkInDate;
	}

	public Date getCheckOutDate() {
		return checkOutDate;
	}

	public void setCheckOutDate(Date checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public int getPetNo() {
		return petNo;
	}

	public void setPetNo(int petNo) {
		this.petNo = petNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return bookingNo + ", " + serviceKind + ", " + userName + ", " + checkInDate + ", " + checkOutDate + ", "
				+ price + ", " + progress + ", " + etc + ", " + petNo + ", " + address;
	}

}
	