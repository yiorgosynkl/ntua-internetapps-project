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
}
	