package member.model.vo;

import java.io.Serializable;
import java.util.UUID;

public class SendTempPassword implements Serializable{
	private static final long serialVersionUID = 3015712182147477948L;
	private UUID uuid = UUID.randomUUID();
	
	public SendTempPassword() {}
	
	public SendTempPassword(UUID uuid) {
		this.uuid = uuid;
	}

	public UUID getUuid() {
		return uuid;
	}

	public void setUuid(UUID uuid) {
		this.uuid = uuid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String sendtempPassword() {
		String tempNum = null;
		
		for(int i = 0; i < 5; i ++) {
			tempNum = uuid.toString().replaceAll("-", "").substring(0, 10);
		}
		
		return tempNum;
	}
}
