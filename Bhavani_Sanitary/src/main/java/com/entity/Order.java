package com.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "user_order")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;
    
    private String orderStatus;
    private String paymentMode;
    private int quantity;
    private double price; 
    private Date orderDate;

    private String customerName;
    private String address;
    private String mobile;
    private String productName;

    // YAHA CHANGE KIYA: Fetch type LAZY kiya hai
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id") 
    private User user;
    
    // YAHA BHI CHANGE KIYA: Fetch type LAZY kiya hai
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id") 
    private product product; 

    public Order() {
        super();
    }

    // --- Getters and Setters ---
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public String getPaymentMode() { return paymentMode; }
    public void setPaymentMode(String paymentMode) { this.paymentMode = paymentMode; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public product getProduct() { return product; }
    public void setProduct(product product) { this.product = product; }
}