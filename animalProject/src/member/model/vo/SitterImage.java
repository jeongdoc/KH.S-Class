package member.model.vo;

import java.io.Serializable;

public class SitterImage implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1889779740217061957L;
	private int imageNo;
	private String userId;
	private String originFile;
	private String renameFile;
	
	public SitterImage() {
		// TODO Auto-generated constructor stub
	}

	public SitterImage(int imageNo, String userId, String originFile, String renameFile) {
		super();
		this.imageNo = imageNo;
		this.userId = userId;
		this.originFile = originFile;
		this.renameFile = renameFile;
	}

	public int getImageNo() {
		return imageNo;
	}

	public void setImageNo(int imageNo) {
		this.imageNo = imageNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getOriginFile() {
		return originFile;
	}

	public void setOriginFile(String originFile) {
		this.originFile = originFile;
	}

	public String getRenameFile() {
		return renameFile;
	}

	public void setRenameFile(String renameFile) {
		this.renameFile = renameFile;
	}

	@Override
	public String toString() {
		return imageNo + ", " + userId + ", " + originFile + ", " + renameFile;
	}
	
	
	
}
