package org.kh.first.test.model.vo;

import java.io.Serializable;

import org.springframework.stereotype.Component;

/**
 * @author JeongEun
 *
 */
@Component
public class Sample implements Serializable {
	private static final long serialVersionUID = -4758246891366492225L;
	
	private String name;
	private int age;
	
	public Sample() {
		super();
	}
	public Sample(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Sample [name=" + name + ", age=" + age + "]";
	}

}
