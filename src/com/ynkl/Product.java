package com.ynkl;

public class Product {
	private String id;
	private Integer price;
	private String name;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Product(String id, String name, Integer price){
		setId(id);
		setPrice(price);
		setName(name);
	}
	
	public static String printPrice(Integer myprice) {
		return String.valueOf((myprice / 100.0));
	}
}

