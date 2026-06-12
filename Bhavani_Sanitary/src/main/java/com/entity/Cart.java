package com.entity;

import javax.persistence.*;

@Entity
@Table(name = "cart_details")
public class Cart {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int cartId;
	
	private int userId;
	private int productId;
	private String productName;
	private String author; 
    
    // 🔥 NAYA FIELD: Quantity store karne ke liye
    private int quantity; 
    
	private Double price;
	private Double totalPrice;

	public Cart() {
		super();
	}

	// Getters and Setters
	public int getCartId() { return cartId; }
	public void setCartId(int cartId) { this.cartId = cartId; }

	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }

	public int getProductId() { return productId; }
	public void setProductId(int productId) { this.productId = productId; }

	public String getProductName() { return productName; }
	public void setProductName(String productName) { this.productName = productName; }

	public String getAuthor() { return author; }
	public void setAuthor(String author) { this.author = author; }

    // 🔥 Getters and Setters for Quantity
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

	public Double getPrice() { return price; }
	public void setPrice(Double price) { this.price = price; }

	public Double getTotalPrice() { return totalPrice; }
	public void setTotalPrice(Double totalPrice) { this.totalPrice = totalPrice; }
}