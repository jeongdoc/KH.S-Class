package member.model.vo;

import java.sql.Date;

public class SearchingInfo implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5029360413115380982L;
	private int bookingNo;
	private String serviceKind;
	private String userId;
	private String puserId;
	private Date checkInDate;
	private Date checkOutDate;
	private int petNo;
	private Date petDate;
	private String petSize;
	private String petBreads;
	private String address;
	private int price;
	private int age;
	
	public SearchingInfo() {}

	public SearchingInfo(int bookingNo, String serviceKind, String userId, String puserId, Date checkInDate,
			Date checkOutDate, int petNo, Date petDate, String petSize, String petBreads, String address, int price, int age) {
		super();
		this.bookingNo = bookingNo;
		this.serviceKind = serviceKind;
		this.userId = userId;
		this.puserId = puserId;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.petNo = petNo;
		this.petDate = petDate;
		this.petSize = petSize;
		this.petBreads = petBreads;
		this.address = address;
		this.price = price;
		this.age = age;
	}

	
	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPuserId() {
		return puserId;
	}

	public void setPuserId(String puserId) {
		this.puserId = puserId;
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

	public int getPetNo() {
		return petNo;
	}

	public void setPetNo(int petNo) {
		this.petNo = petNo;
	}

	public Date getPetDate() {
		return petDate;
	}

	public void setPetDate(Date petDate) {
		this.petDate = petDate;
	}

	public String getPetSize() {
		return petSize;
	}

	public void setPetSize(String petSize) {
		this.petSize = petSize;
	}

	public String getPetBreads() {
		return petBreads;
	}

	public void setPetBreads(String petBreads) {
		this.petBreads = petBreads;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "SearchingInfo [bookingNo=" + bookingNo + ", serviceKind=" + serviceKind + ", userId=" + userId
				+ ", puserId=" + puserId + ", checkInDate=" + checkInDate + ", checkOutDate=" + checkOutDate
				+ ", petNo=" + petNo + ", petDate=" + petDate + ", petSize=" + petSize + ", petBreads=" + petBreads
				+ ", address=" + address + ", price=" + price + ", age=" + age + "]";
	}


}


