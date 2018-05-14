package com.kh.farm.market.model.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("review")
public class Review implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 55555L;
	
	private int review_no;//리뷰 번호
	private String member_id;//리뷰 작성자 아이디
	private int sell_no;//판매글 번호
	private Date review_date;//리뷰 작성일
	private String review_title;//리뷰 제목
	private String review_contents;//리뷰 내용
	
	public Review() {
	
	}

	public Review(int review_no, String member_id, int sell_no, Date review_date, String review_title,
			String review_contents) {
		super();
		this.review_no = review_no;
		this.member_id = member_id;
		this.sell_no = sell_no;
		this.review_date = review_date;
		this.review_title = review_title;
		this.review_contents = review_contents;
	}

	@Override
	public String toString() {
		return "Review [review_no=" + review_no + ", member_id=" + member_id + ", sell_no=" + sell_no + ", review_date="
				+ review_date + ", review_title=" + review_title + ", review_contents=" + review_contents + "]";
	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getSell_no() {
		return sell_no;
	}

	public void setSell_no(int sell_no) {
		this.sell_no = sell_no;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_contents() {
		return review_contents;
	}

	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}
	
	

}
