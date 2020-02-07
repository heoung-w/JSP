package web.project.model;

import java.sql.Timestamp;

public class CharDTO {

	
	private int count;		// 구매번호
	private String num;		// 책 번호
	private String id;		// 구매한 아이디
	private int price;		// 책 구매 가격
	private Timestamp reg;	// 구매시각
	
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
}
