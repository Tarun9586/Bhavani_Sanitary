package com.entity;

import javax.persistence.*;

@Entity
@Table(name= "user_details")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "full_name")
	private String name;

	@Column(unique = true, nullable = false) // Ensures DB level uniqueness
	private String email;
    
	private String phno;
	private String password;
	private String role;
	private String address;

	public User() { super(); }

	public User(String name, String email, String phno, String password, String role, String address) {
		super();
		this.name = name;
		this.email = email;
		this.phno = phno;
		this.password = password;
		this.role = role;
		this.address=address;
	}

	// Getters and Setters
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }
	public String getPhno() { return phno; }
	public void setPhno(String phno) { this.phno = phno; }
	public String getPassword() { return password; }
	public void setPassword(String password) { this.password = password; }
	public String getRole() { return role; }
	public void setRole(String role) { this.role = role; }
	public String getAddress() {return address;}
	public void setAddress(String address) {this.address=address;}
}