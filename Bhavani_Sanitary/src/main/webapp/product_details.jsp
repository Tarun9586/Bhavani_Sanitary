<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.dao.ProductDao,com.db.HibernateUtil,
com.entity.product,com.entity.User,java.util.List"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Product Details | Bhavani Sanitary</title>

<%@include file="components/all_css.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>

/* =========================
          BODY
========================= */

body{
    background-color:#f8f9fa;
    padding-top:90px;
    overflow-x:hidden;
}

/* =========================
      PRODUCT IMAGE BOX
========================= */

.sticky-image-container{
    position:sticky;
    top:100px;
    z-index:10;
    background:white;
    border-radius:18px;
    padding:22px;
    border:1px solid #eee;
}

/* IMAGE CHOTI KI */

.product-img{
    max-height:280px;
    width:100%;
    object-fit:contain;
}

/* =========================
        QTY INPUT
========================= */

.qty-input{
    display:flex;
    align-items:center;
    border:1px solid #ced4da;
    border-radius:25px;
    width:fit-content;
    background:#fff;
    overflow:hidden;
}

.qty-input button{
    background:#f8f9fa;
    border:none;
    padding:5px 14px;
    font-size:1.1rem;
    transition:0.2s;
}

.qty-input button:hover{
    background:#e9ecef;
}

.qty-input input{
    width:42px;
    text-align:center;
    border:none;
    font-weight:bold;
    outline:none;
}

/* REMOVE NUMBER ARROWS */

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button{
    -webkit-appearance:none;
    margin:0;
}

/* =========================
        PRICE TAGS
========================= */

.discount-tag{
    background:#ff5722;
    color:#fff;
    padding:3px 8px;
    border-radius:5px;
    font-size:0.75rem;
    font-weight:bold;
}

/* =========================
      REVIEW CARD
========================= */

.review-card{
    border-left:4px solid #ffc107;
    margin-bottom:15px;
    background:#fff;
    border-radius:10px;
}

/* =========================
      SPECIFICATIONS
========================= */

.spec-label{
    font-weight:bold;
    width:35%;
    color:#555;
    font-size:0.9rem;
}

/* =========================
      RELATED PRODUCTS
========================= */

.related-product-link{
    text-decoration:none !important;
    color:inherit !important;
    display:block;
}

.related-card{
    border:1px solid rgba(0,0,0,0.06);
    border-radius:15px;
    transition:all 0.3s ease;
    background:#fff;
    overflow:hidden;
}

.related-product-link:hover .related-card{
    transform:translateY(-5px);
    box-shadow:0 10px 20px rgba(0,0,0,0.08) !important;
}

/* RELATED IMAGE SMALL */

.related-product-img{
    max-height:110px;
    max-width:100%;
    object-fit:contain;
}

/* =========================
        TABLET
========================= */

@media(max-width:992px){

    body{
        padding-top:85px;
    }

    .sticky-image-container{
        position:relative;
        top:0;
        margin-bottom:25px;
    }

    .product-img{
        max-height:240px;
    }

    .related-product-img{
        max-height:95px;
    }

}

/* =========================
          MOBILE
========================= */

@media(max-width:768px){

    body{
        padding-top:75px;
    }

    .container{
        padding-left:12px;
        padding-right:12px;
    }

    .sticky-image-container{
        padding:18px;
        border-radius:15px;
    }

    .product-img{
        max-height:180px;
    }

    h1{
        font-size:1.5rem;
    }

    .display-6{
        font-size:1.7rem !important;
    }

    .breadcrumb{
        font-size:0.8rem;
    }

    .qty-input{
        transform:scale(0.92);
    }

    .qty-input button{
        padding:5px 12px;
        font-size:1rem;
    }

    .qty-input input{
        width:35px;
        font-size:14px;
    }

    .btn{
        font-size:13px !important;
        padding:10px !important;
    }

    .discount-tag{
        font-size:0.65rem;
    }

    .spec-label{
        width:40%;
        font-size:0.8rem;
    }

    .table td{
        font-size:0.8rem;
    }

    .review-card{
        padding:12px !important;
    }

    .review-card h6{
        font-size:0.9rem;
    }

    .review-card p{
        font-size:0.75rem;
    }

    .related-card{
        border-radius:12px;
    }

    .related-product-img{
        max-height:80px;
    }

    .related-card h6{
        font-size:0.8rem !important;
    }

}

/* =========================
       SMALL MOBILE
========================= */

@media(max-width:576px){

    .product-img{
        max-height:150px;
    }

    h1{
        font-size:1.3rem;
    }

    .display-6{
        font-size:1.4rem !important;
    }

    .spec-label{
        width:45%;
        font-size:0.75rem;
    }

    .table td{
        font-size:0.72rem;
    }

    .related-product-img{
        max-height:70px;
    }

    .related-card h6{
        font-size:0.72rem !important;
    }

    .related-card span{
        font-size:0.7rem !important;
    }

}

</style>

</head>

<body>

<%@include file="components/navbar.jsp"%>

<%

String pidStr = request.getParameter("pId");

if(pidStr == null){

    pidStr = request.getParameter("pid");

}

int pid = 0;

product p = null;

User user =
        (User) session.getAttribute("activeUser");

int currentCatId = 0;

if(pidStr != null && !pidStr.trim().isEmpty()){

    try{

        pid = Integer.parseInt(pidStr.trim());

        ProductDao dao =
                new ProductDao(
                        HibernateUtil.getSessionFactory());

        p = dao.getProductById(pid);

        if(p != null && p.getCategory() != null){

            currentCatId =
                    p.getCategory().getCategoryID();

        }

    }catch(Exception e){

        e.printStackTrace();

    }

}

if(p == null){

    response.sendRedirect("index.jsp");

    return;

}else{

    int finalStock = 0;

    try{

        finalStock = p.getpQauntity();

    }catch(Exception e){

        try{

            finalStock = p.getpPrice();

        }catch(Exception ex){}

    }

    double discountPrice =
            p.getpPrice()
            - (p.getpPrice()
            * p.getpDiscount() / 100);

%>

<div class="container mt-3 mb-5">

<div class="row">

<!-- =========================
        LEFT SIDE
========================= -->

<div class="col-lg-4">

    <div class="sticky-image-container shadow-sm mb-4 text-center">

        <img src="images/<%= p.getpPhoto() %>"
             class="product-img mb-3"
             alt="Product Image"

             onerror="this.src='https://www.jaquar.com/images/thumbs/0055445_arc_400.webp'">

        <% if(finalStock > 0){ %>

        <div class="d-flex justify-content-center align-items-center mb-3">

            <span class="me-2 small fw-bold text-muted">

                QTY:

            </span>

            <div class="qty-input shadow-sm">

                <button onclick="changeQty(-1)">-</button>

                <input type="number"
                       id="quantity"
                       value="1"
                       min="1"
                       max="<%= finalStock %>"
                       readonly>

                <button onclick="changeQty(1)">+</button>

            </div>

        </div>

        <% } %>

        <div class="d-grid gap-2">

        <% if(finalStock > 0){ %>

            <% if(user == null){ %>

                <a href="login.jsp"
                   class="btn btn-warning fw-bold shadow-sm rounded-pill py-2">

                    <i class="bi bi-cart-plus me-2"></i>

                    ADD TO CART

                </a>

            <% } else { %>

                <a href="add_to_cart?pid=<%= p.getpId() %>&uid=<%= user.getId() %>&pname=<%= p.getpName() %>&price=<%= p.getpPrice() %>&qty=1"

                   id="cart-link"

                   data-base-url="add_to_cart?pid=<%= p.getpId() %>&uid=<%= user.getId() %>&pname=<%= p.getpName() %>&price=<%= p.getpPrice() %>"

                   class="btn btn-warning fw-bold shadow-sm rounded-pill py-2">

                    <i class="bi bi-cart-plus me-2"></i>

                    ADD TO CART

                </a>

            <% } %>

            <button class="btn btn-outline-dark shadow-sm rounded-pill py-2">

                <i class="bi bi-lightning-fill me-2"></i>

                BUY NOW

            </button>

        <% } else { %>

            <button class="btn btn-danger fw-bold rounded-pill py-2 w-100"
                    disabled>

                OUT OF STOCK

            </button>

        <% } %>

        </div>

    </div>

</div>

<!-- =========================
        RIGHT SIDE
========================= -->

<div class="col-lg-8 ps-lg-5">

<nav aria-label="breadcrumb">

<ol class="breadcrumb">

<li class="breadcrumb-item">

    <a href="index.jsp"
       class="text-decoration-none">

        Home

    </a>

</li>

<li class="breadcrumb-item active">

<%

String catTitle = "Sanitary Fittings";

try{

    if(p.getCategory() != null){

        catTitle =
                p.getCategory().getCategoryTitle();

    }

}catch(Exception e){}

out.print(catTitle);

%>

</li>

</ol>

</nav>

<h1 class="fw-bold">

    <%= p.getpName() %>

</h1>

<p class="text-muted small">

    SKU: BS-<%= p.getpId() %>

</p>

<hr>

<div class="mb-4">

<span class="display-6 fw-bold text-primary">

₹<%= Math.round(discountPrice) %>

</span>

<span class="text-muted ms-2 fs-5">

<del>₹<%= p.getpPrice() %></del>

</span>

<span class="discount-tag ms-2 align-middle">

<%= p.getpDiscount() %>% OFF

</span>

</div>

<div class="card bg-light border-0 p-3 mb-4">

<h6 class="fw-bold">

    Product Description

</h6>

<p class="text-secondary small mb-0">

    <%= p.getpDescription() %>

</p>

</div>

<div class="mb-4">

<% if(finalStock > 0){ %>

<span class="badge rounded-pill bg-success-subtle
text-success border border-success px-3 py-2">

    In Stock

</span>

<small class="ms-2 text-muted">

    Only <%= finalStock %> units left

</small>

<% } else { %>

<span class="badge rounded-pill bg-danger-subtle
text-danger border border-danger px-3 py-2">

    Out of Stock

</span>

<% } %>

</div>

<hr>

<!-- =========================
       SPECIFICATIONS
========================= -->

<div class="mt-4">

<h5 class="fw-bold mb-3 text-dark">

    Technical Specifications

</h5>

<div class="table-responsive">

<table class="table table-sm table-borderless
bg-white shadow-sm rounded">

<tbody>

<tr class="border-bottom">

<td class="spec-label ps-3 py-2">Brand</td>

<td class="py-2">Bhavani Sanitary</td>

</tr>

<tr class="border-bottom">

<td class="spec-label ps-3 py-2">Material</td>

<td class="py-2">

<%= p.getpMaterial() != null
? p.getpMaterial()
: "N/A" %>

</td>

</tr>

<tr class="border-bottom">

<td class="spec-label ps-3 py-2">Finish</td>

<td class="py-2">

<%= p.getpFinish() != null
? p.getpFinish()
: "N/A" %>

</td>

</tr>

<tr class="border-bottom">

<td class="spec-label ps-3 py-2">Warranty</td>

<td class="py-2">

<%= p.getpWarranty() != null
? p.getpWarranty()
: "N/A" %>

</td>

</tr>

<tr class="border-bottom">

<td class="spec-label ps-3 py-2">Usage</td>

<td class="py-2">

<%= p.getpUsage() != null
? p.getpUsage()
: "N/A" %>

</td>

</tr>

</tbody>

</table>

</div>

</div>

<!-- =========================
          REVIEW
========================= -->

<div class="mt-5 mb-5">

<h5 class="fw-bold mb-3">

    Customer Feedback

</h5>

<div class="card shadow-sm review-card p-3 border-0">

<div class="text-warning mb-1 small">

<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>

</div>

<h6 class="fw-bold mb-1 small">

    Excellent Build Quality

</h6>

<p class="small mb-1 text-muted">

    Truly premium product for bathrooms.

</p>

<span class="text-primary fw-bold"
      style="font-size:0.75rem;">

    - Rahul S.

</span>

</div>

</div>

</div>

</div>

<!-- =========================
      RELATED PRODUCTS
========================= -->

<%

if(currentCatId > 0){

    try{

        ProductDao relatedDao =
                new ProductDao(
                        HibernateUtil.getSessionFactory());

        List<product> relatedList =
                relatedDao.getAllProductsByCategoryId(
                        currentCatId);

        if(relatedList != null
           && relatedList.size() > 1){

%>

<div class="row mt-5">

<div class="col-12">

<hr class="mb-5"
    style="border-top:2px dashed #dee2e6;">

<div class="d-flex justify-content-between
align-items-center mb-4">

<h3 class="fw-bold text-dark mb-0">

    You May Also Like

</h3>

</div>

</div>

</div>

<div class="row">

<%

int count = 0;

for(product rp : relatedList){

    if(rp.getpId() == p.getpId()){

        continue;

    }

    if(count >= 4){

        break;

    }

    double rpDiscountPrice =
            rp.getpPrice()
            - (rp.getpPrice()
            * rp.getpDiscount() / 100);

%>

<div class="col-lg-3 col-md-4 col-6 mb-4">

<a href="product_details.jsp?pid=<%= rp.getpId() %>"
   class="related-product-link">

<div class="card related-card h-100 shadow-sm text-center">

<div class="p-3 bg-white d-flex
align-items-center justify-content-center"
     style="height:150px;">

<img src="images/<%= rp.getpPhoto() %>"

     onerror="this.src='https://www.jaquar.com/images/thumbs/0055445_arc_400.webp';"

     class="related-product-img"

     alt="<%= rp.getpName() %>">

</div>

<div class="card-body pt-2">

<h6 class="fw-bold mb-1 text-truncate text-dark">

<%= rp.getpName() %>

</h6>

<div class="d-flex justify-content-center
align-items-center gap-2">

<span class="text-success fw-bold">

₹<%= Math.round(rpDiscountPrice) %>

</span>

<span class="text-muted
text-decoration-line-through small">

₹<%= rp.getpPrice() %>

</span>

</div>

<span class="badge bg-danger rounded-pill mt-1">

<%= rp.getpDiscount() %>% Off

</span>

</div>

</div>

</a>

</div>

<%

count++;

}

%>

</div>

<%

        }

    }catch(Exception ex){

        System.out.println(
            "Related Error : "
            + ex.getMessage());

    }

}

%>

</div>

<% } %>

<script>

function changeQty(amt){

    let qtyInput =
            document.getElementById("quantity");

    if(!qtyInput)
        return;

    let currentQty =
            parseInt(qtyInput.value);

    let maxQty =
            parseInt(qtyInput.getAttribute("max"));

    let newQty =
            currentQty + amt;

    if(newQty >= 1 && newQty <= maxQty){

        qtyInput.value = newQty;

        let cartBtn =
                document.getElementById("cart-link");

        if(cartBtn){

            let baseUrl =
                    cartBtn.getAttribute(
                            "data-base-url");

            cartBtn.href =
                    baseUrl + "&qty=" + newQty;

        }

    }

}

</script>

</body>
</html>