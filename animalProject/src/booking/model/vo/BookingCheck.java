package booking.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class BookingCheck implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2675965931331759210L;
	private int bookingNo;
	private Date checkInDate;
	private Date checkOutDate;
	private String bookingProgress;
	private String puserId;
	private int price;
	private String address;
	private String petName;
	private String serviceKind;
	
	public BookingCheck() {
		// TODO Auto-generated constructor stub
	}

	public BookingCheck(int bookingNo, Date checkInDate, Date checkOutDate, String bookingProgress, String puserId,
			int price, String address, String petName, String serviceKind) {
		super();
		this.bookingNo = bookingNo;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.bookingProgress = bookingProgress;
		this.puserId = puserId;
		this.price = price;
		this.address = address;
		this.petName = petName;
		this.serviceKind = serviceKind;
	}

	public int getBookingNo() {
		return bookingNo;
	}

	public void setBookingNo(int bookingNo) {
		this.bookingNo = bookingNo;
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

	public String getBookingProgress() {
		return bookingProgress;
	}

	public void setBookingProgress(String bookingProgress) {
		this.bookingProgress = bookingProgress;
	}

	public String getPuserId() {
		return puserId;
	}

	public void setPuserId(String puserId) {
		this.puserId = puserId;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPetName() {
		return petName;
	}

	public void setPetName(String petName) {
		this.petName = petName;
	}
	
	public String getServiceKind() {
		return serviceKind;
	}

	public void setServiceKind(String serviceKind) {
		this.serviceKind = serviceKind;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return bookingNo + ", " + checkInDate + ", " + checkOutDate + ", " + bookingProgress + ", " + puserId + ", "
				+ price + ", " + address + ", " + petName + ", " + serviceKind;
	}

	
	
	
	
}
