package udp.practice;

import java.io.*;
import java.net.*;

public class UDPSpamReceiver {
	public static void receiver() {
		//무작위로 전송된 스팸메세지 받아서 출력하는 프로그램
		//무한루프로 전송 온 패킷 정보를 계속 받아 출력하는 프로그램.
		byte[] receiveM = new byte[6000];
		DatagramPacket pCket = null;
		try {
			DatagramSocket uClient = new DatagramSocket(4000);
			pCket = new DatagramPacket(receiveM, receiveM.length);
			
			//uClient.receive(pCket);
			
			/*String text = new String(receiveM);*/
			System.out.println("----데이터수신----");
			while(true) {
				uClient.receive(pCket);
				System.out.println("보내온 IP : " + pCket.getAddress());
				
				String message = new String(pCket.getData());
				System.out.println("받은 내용 : " + message);
			}
			
			
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public static void main(String[] args) {
		System.out.println("Receiver 구동중");
		receiver();

	}

}
