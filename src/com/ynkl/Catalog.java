package com.ynkl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class Catalog{
	private ArrayList<Product> products;
	private Set<String> ids;
	
	public Catalog() {
		products = new ArrayList<Product>();
		ids = new HashSet<String>();
	}
	
	public ArrayList<Product> getProducts(){
		return products;
	}
	
	public Set<String> getIds(){
		return ids;
	}
	
	public void addProduct(Product pr) {
		if ( !getIds().contains(pr.getId()) ) {
			products.add(pr);
			ids.add(pr.getId());
		}
	}
	
	public Integer totalPrice(Boolean discount, Integer countryId) {
		Integer total = new Integer(0);
		float[] tax = {1.10f, 1.15f, 1.17f, 1.21f, 1.23f}; // float taxes 
		
		for (int i=0; i< products.size(); i++) {
			total = total + products.get(i).getPrice();
		}
		
		if (discount) {
			total = (Integer) Math.round(total * 0.8f);
		}
		return (Integer) Math.round(total * tax[countryId]);
	}
}
	