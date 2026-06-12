package com.entity;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

@Entity
@Table(name= "category")
public class category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int categoryID;
    private String categoryTitle;
    private String categoryDescription;
    
    // Yahan fetch type LAZY rakha hai taaki unwanted data load na ho
    @OneToMany(mappedBy="category", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<product> products = new ArrayList<>();
    
    public category() {
        super();
    }
    
    public category(String categoryTitle, String categoryDescription, List<product> products) {
        super();
        this.categoryTitle = categoryTitle;
        this.categoryDescription = categoryDescription;
        this.products = products;
    }

    public category(int categoryID, String categoryTitle, String categoryDescription) {
        super();
        this.categoryID = categoryID;
        this.categoryTitle = categoryTitle;
        this.categoryDescription = categoryDescription;
    }

    public List<product> getProducts() {
        return products;
    }

    public void setProducts(List<product> products) {
        this.products = products;
    }
    
    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryTitle() {
        return categoryTitle;
    }

    public void setCategoryTitle(String categoryTitle) {
        this.categoryTitle = categoryTitle;
    }

    public String getCategoryDescription() {
        return categoryDescription;
    }

    public void setCategoryDescription(String categoryDescription) {
        this.categoryDescription = categoryDescription;
    }

    // toString() se product list hata di hai taaki infinite loop na bane
    @Override
    public String toString() {
        return "category [categoryID=" + categoryID + ", categoryTitle=" + categoryTitle + ", categoryDescription=" + categoryDescription + "]";
    }
}