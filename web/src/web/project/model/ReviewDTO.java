package web.project.model;

import java.sql.Timestamp;

public class ReviewDTO {
	private int num;//리뷰 고유 번호
	private String id;
	private int bk_num;//책 고유 번호
	private String recontent;
	private String star;
	private int read_recount;
	private Timestamp bk_rereg;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBk_num() {
		return bk_num;
	}
	public void setBk_num(int bk_num) {
		this.bk_num = bk_num;
	}
	public String getRecontent() {
		return recontent;
	}
	public void setRecontent(String recontent) {
		this.recontent = recontent;
		System.out.println(this.recontent+"reviewDto에서 recontent");
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
		System.out.println(this.star+"reviewDto에서 star");
	}
	public int getRead_recount() {
		return read_recount;
	}
	public void setRead_recount(int read_recount) {
		this.read_recount = read_recount;
	}
	public Timestamp getBk_rereg() {
		return bk_rereg;
	}
	public void setBk_rereg(Timestamp bk_rereg) {
		this.bk_rereg = bk_rereg;
	}

}
