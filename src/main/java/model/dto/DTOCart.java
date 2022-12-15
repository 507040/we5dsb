package model.dto;

public class DTOCart {
	private String id;
	private int cnt;
	private String name;
	private String owner;
	private int sale;
	private int instork;
	private int price;
	private String img;
	private int rePrice;
	private int sumPrice;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public int getInstork() {
		return instork;
	}
	public void setInstork(int instork) {
		this.instork = instork;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getRePrice() {
		return rePrice;
	}
	public void setRePrice(int sale,int price) {
		int asdff=(price/sale);
		this.rePrice = price-asdff;
	}
	public int getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(int rePrice,int cnt) {
		this.sumPrice = rePrice*cnt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}