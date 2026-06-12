package com.entity;

import javax.persistence.*;

@Entity
@Table(name = "products")
public class product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int pId;

    private String pName;

    @Column(length = 3000)
    private String pDescription;

    private String pPhoto;
    private int pPrice;
    private int pDiscount;

    // Both spellings handled to avoid DB mismatch
    private int pQauntity;
    private Integer pQuantity;

    // Standard 4 separate specification columns
    private String pMaterial;
    private String pFinish;
    private String pWarranty;
    private String pUsage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_categoryID")
    private category category;

    // No-arg Constructor (required by Hibernate)
    public product() {
    }

    // Getters and Setters
    public int getpId() { return pId; }
    public void setpId(int pId) { this.pId = pId; }

    public String getpName() { return pName; }
    public void setpName(String pName) { this.pName = pName; }

    public String getpDescription() { return pDescription; }
    public void setpDescription(String pDescription) { this.pDescription = pDescription; }

    public String getpPhoto() { return pPhoto; }
    public void setpPhoto(String pPhoto) { this.pPhoto = pPhoto; }

    public int getpPrice() { return pPrice; }
    public void setpPrice(int pPrice) { this.pPrice = pPrice; }

    public int getpDiscount() { return pDiscount; }
    public void setpDiscount(int  pDiscount) { this.pDiscount = pDiscount; }

    public int getpQauntity() { return pQauntity; }
    public void setpQauntity(int pQauntity) { this.pQauntity = pQauntity; }

    public Integer getpQuantity() { return pQuantity; }
    public void setpQuantity(Integer pQuantity) { this.pQuantity = pQuantity; }

    public String getpMaterial() { return pMaterial; }
    public void setpMaterial(String pMaterial) { this.pMaterial = pMaterial; }

    public String getpFinish() { return pFinish; }
    public void setpFinish(String pFinish) { this.pFinish = pFinish; }

    public String getpWarranty() { return pWarranty; }
    public void setpWarranty(String pWarranty) { this.pWarranty = pWarranty; }

    public String getpUsage() { return pUsage; }
    public void setpUsage(String pUsage) { this.pUsage = pUsage; }

    public category getCategory() { return category; }
    public void setCategory(category category) { this.category = category; }
}