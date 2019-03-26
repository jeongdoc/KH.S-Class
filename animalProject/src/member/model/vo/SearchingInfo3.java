package member.model.vo;

import java.sql.Date;

public class SearchingInfo3 implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5029360413115380982L;
	private int petAge;
	private String petSize;
	private String petBreads;
	private String userId;

	
	public SearchingInfo3() {}


	public SearchingInfo3(int petAge, String petSize, String petBreads) {
		super();
		this.petAge = petAge;
		this.petSize = petSize;
		this.petBreads = petBreads;
	}


	public int getPetAge() {
		return petAge;
	}


	public void setPetAge(int petAge) {
		this.petAge = petAge;
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


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return this.petBreads + ", " + this.petSize + ", " + this.petAge;
	}
	


}


