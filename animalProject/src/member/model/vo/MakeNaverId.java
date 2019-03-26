package member.model.vo;

import java.io.Serializable;
import java.util.UUID;

public class MakeNaverId implements Serializable{
	private static final long serialVersionUID = 4328553713304841046L;
	private UUID uuid = UUID.randomUUID();
	private final static String token = "DH#";
	
	public MakeNaverId() {}

	public MakeNaverId(UUID uuid) {
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

	public static String getToken() {
		return token;
	}
	
	@Override
	public String toString() {
		String randomId = null;
		for(int i = 0; i < 10; i ++) {
			randomId = uuid.toString().replace("-", "").substring(5, 16);
		
		}
		String naverRanId = token + randomId;
		System.out.println("randomId = " + naverRanId);
		
		return naverRanId;
	}
	
	
	

}
