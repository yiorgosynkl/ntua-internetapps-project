import java.util.*;

public class Basket{
	private ArrayList<Product> products;
	private Set<String> ids;
	
	public Basket() {
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