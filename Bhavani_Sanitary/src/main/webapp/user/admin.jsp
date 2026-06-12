<%@page import="org.hibernate.SessionFactory"%>
<%@page import="com.entity.User"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.dao.OrderDao"%>
<%@page import="com.db.HibernateUtil"%>
<%@page import="com.entity.category"%>
<%@page import="com.entity.product"%>
<%@page import="com.entity.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>

<%

String path = request.getContextPath();

User user =
		(User) session.getAttribute("activeUser");

/* =========================
      LOGIN VALIDATION
========================= */

if(user == null){

	session.setAttribute(
			"msg",
			"Please Login first!");

	response.sendRedirect(
			path + "/login.jsp");

	return;

}else if(!"admin".equalsIgnoreCase(
		user.getRole())){

	session.setAttribute(
			"msg",
			"Access Denied!");

	response.sendRedirect(
			path + "/index.jsp");

	return;

}

/* =========================
      DATABASE FETCH
========================= */

SessionFactory sf =
		HibernateUtil.getSessionFactory();

if(sf == null){

	out.println(
			"<h2>Database Connection Failed!</h2>");

	return;

}

List<category> clist =
		new CategoryDao(sf).getAllCategories();

if(clist == null)
	clist = new ArrayList<>();

List<product> plist =
		new ProductDao(sf).getAllProducts();

if(plist == null)
	plist = new ArrayList<>();

List<Order> olist =
		new OrderDao(sf).getAllOrders();

if(olist == null)
	olist = new ArrayList<>();

int pCount = plist.size();

%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1.0">

<title>
	Admin Dashboard | Bhavani Sanitary
</title>

<%@include file="../components/all_css.jsp"%>

<style>

/* =========================
          BODY
========================= */

body{
	background:#f5f7fb;
	padding-top:85px;
	overflow-x:hidden;
}

/* =========================
        ADMIN CARD
========================= */

.admin-card{
	cursor:pointer;
	transition:0.3s;
	border-radius:18px;
	border:none;
}

.admin-card:hover{
	transform:translateY(-6px);
	box-shadow:0 10px 25px rgba(0,0,0,0.12);
}

/* =========================
        PRODUCT IMAGE
========================= */

.img-admin{
	width:50px;
	height:50px;
	object-fit:cover;
	border-radius:8px;
}

/* =========================
        ADDRESS BOX
========================= */

.address-box{
	max-width:220px;
	font-size:0.85rem;
	word-wrap:break-word;
	display:block;
	color:#555;
}

/* =========================
          TABLE
========================= */

.table{
	min-width:700px;
}

.table th{
	font-size:14px;
	white-space:nowrap;
}

.table td{
	font-size:14px;
	vertical-align:middle;
}

/* =========================
        CARD HEADER
========================= */

.card-header{
	border-radius:15px 15px 0 0 !important;
}

/* =========================
        BUTTONS
========================= */

.btn{
	border-radius:10px;
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

	h2{
		font-size:1.6rem;
	}

	.admin-card{
		border-radius:15px;
	}

	.admin-card h3{
		font-size:1.6rem;
	}

	.admin-card p{
		font-size:12px;
	}

	.card-header h4{
		font-size:1rem;
	}

	.table th{
		font-size:12px;
	}

	.table td{
		font-size:12px;
	}

	.address-box{
		font-size:11px;
		max-width:150px;
	}

	.img-admin{
		width:40px;
		height:40px;
	}

	.form-select,
	.form-control{
		font-size:12px;
	}

	.btn-sm{
		font-size:11px !important;
		padding:5px 8px !important;
	}

	.modal-dialog{
		margin:10px;
	}

}

/* =========================
       SMALL MOBILE
========================= */

@media(max-width:576px){

	h2{
		font-size:1.4rem;
	}

	.admin-card{
		padding:10px !important;
	}

	.admin-card i{
		font-size:2rem !important;
	}

	.admin-card h3{
		font-size:1.4rem;
	}

	.card-header h4{
		font-size:0.9rem;
	}

	.table th,
	.table td{
		font-size:11px;
	}

	.btn-sm{
		font-size:10px !important;
		padding:4px 6px !important;
	}

	.address-box{
		font-size:10px;
		max-width:120px;
	}

}

</style>

</head>

<body>

<%@include file="../components/navbar.jsp"%>

<div class="container mt-4">

<!-- =========================
          TITLE
========================= -->

<h2 class="text-center fw-bold mb-4">

	Admin Control Center

</h2>

<!-- =========================
         ALERTS
========================= -->

<c:if test="${not empty succMsg}">

<div class="alert alert-success
	text-center alert-dismissible fade show">

	${succMsg}

	<button type="button"
		class="btn-close"
		data-bs-dismiss="alert">

	</button>

</div>

<c:remove var="succMsg"
	scope="session"/>

</c:if>

<c:if test="${not empty msg}">

<div class="alert alert-danger
	text-center alert-dismissible fade show">

	${msg}

	<button type="button"
		class="btn-close"
		data-bs-dismiss="alert">

	</button>

</div>

<c:remove var="msg"
	scope="session"/>

</c:if>

<!-- =========================
        TOP STATS
========================= -->

<div class="row g-3 text-center">

<div class="col-lg-3 col-md-6 col-6">

<div class="card admin-card
	p-3 shadow-sm bg-white">

<div class="card-body">

<i class="bi bi-people
	fs-1 text-info"></i>

<h3 class="mt-2 text-info">

	12

</h3>

<p class="text-uppercase
	text-muted fw-bold mb-0">

	Total Users

</p>

</div>

</div>

</div>

<div class="col-lg-3 col-md-6 col-6">

<div class="card admin-card
	p-3 shadow-sm bg-white"

	data-bs-toggle="modal"
	data-bs-target="#add-category">

<div class="card-body">

<i class="bi bi-tags
	fs-1 text-primary"></i>

<h3 class="mt-2 text-primary">

	<%= clist.size() %>

</h3>

<p class="text-uppercase
	text-muted fw-bold mb-0">

	Categories

</p>

<small class="text-primary">

	Add New

</small>

</div>

</div>

</div>

<div class="col-lg-3 col-md-6 col-6">

<div class="card admin-card
	p-3 shadow-sm bg-white"

	data-bs-toggle="modal"
	data-bs-target="#add-product">

<div class="card-body">

<i class="bi bi-box-seam
	fs-1 text-success"></i>

<h3 class="mt-2 text-success">

	<%= pCount %>

</h3>

<p class="text-uppercase
	text-muted fw-bold mb-0">

	Products

</p>

<small class="text-success">

	Add New

</small>

</div>

</div>

</div>

<div class="col-lg-3 col-md-6 col-6">

<div class="card admin-card
	p-3 shadow-sm bg-white">

<div class="card-body">

<i class="bi bi-cart-check-fill
	fs-1 text-warning"></i>

<h3 class="mt-2 text-warning">

	<%= olist.size() %>

</h3>

<p class="text-uppercase
	text-muted fw-bold mb-0">

	Orders

</p>

</div>

</div>

</div>

</div>

<!-- =========================
      CUSTOMER ORDERS
========================= -->

<div class="row mt-5">

<div class="col-12">

<div class="card shadow-sm border-0">

<div class="card-header
	bg-warning text-dark">

<h4 class="mb-0 fw-bold">

<i class="bi bi-bag-fill"></i>

Customer Orders

</h4>

</div>

<div class="card-body">

<div class="table-responsive">

<table class="table
	table-hover align-middle border">

<thead class="table-dark">

<tr>

<th>ID</th>
<th>Customer</th>
<th>Address</th>
<th>Product</th>
<th>Qty</th>
<th>Price</th>
<th>Status</th>
<th>Update</th>

</tr>

</thead>

<tbody>

<%

if(!olist.isEmpty()){

	for(Order o : olist){

	String s = o.getOrderStatus();

	if(s == null)
		s = "Pending";

%>

<tr>

<td class="fw-bold">

#<%= o.getOrderId() %>

</td>

<td>

<strong>

<%= o.getCustomerName() %>

</strong>

<br>

<small class="text-muted">

<%= o.getMobile() %>

</small>

</td>

<td>

<span class="address-box">

<%= o.getAddress() != null
? o.getAddress()
: "N/A" %>

</span>

</td>

<td>

<%= o.getProductName() %>

</td>

<td>

<%= o.getQuantity() %>

</td>

<td class="text-success fw-bold">

₹<%= o.getPrice() %>

</td>

<td>

<span class="badge
<%= s.equals("Pending")
? "bg-danger"
: s.equals("Shipped")
? "bg-primary"
: "bg-success" %>">

<%= s %>

</span>

</td>

<td>

<form action="../UpdateOrderStatus"
	method="post"
	class="d-flex">

<input type="hidden"
	name="oid"
	value="<%= o.getOrderId() %>">

<select name="status"
	class="form-select
	form-select-sm me-1">

<option value="Pending"
<%= s.equals("Pending")
? "selected"
: "" %>>

Pending

</option>

<option value="Shipped"
<%= s.equals("Shipped")
? "selected"
: "" %>>

Shipped

</option>

<option value="Delivered"
<%= s.equals("Delivered")
? "selected"
: "" %>>

Delivered

</option>

</select>

<button type="submit"
	class="btn btn-dark btn-sm">

OK

</button>

</form>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="8"
	class="text-center py-4">

	No orders found.

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</div>

</div>

</div>

<!-- =========================
      PRODUCTS TABLE
========================= -->

<div class="row mt-5">

<div class="col-12">

<div class="card shadow-sm">

<div class="card-header
	bg-dark text-white">

<h4 class="mb-0">

<i class="bi bi-box"></i>

Manage Products

</h4>

</div>

<div class="card-body">

<div class="table-responsive">

<table class="table
	table-hover align-middle">

<thead class="table-light">

<tr>

<th>Image</th>
<th>Name</th>
<th>Price</th>
<th>Discount</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

if(!plist.isEmpty()){

	for(product p : plist){

%>

<tr>

<td>

<img src="${pageContext.request.contextPath}/images/<%= p.getpPhoto() %>"

	class="img-admin"

	onerror="this.src='${pageContext.request.contextPath}/images/default.jpg'">

</td>

<td>

<%= p.getpName() %>

</td>

<td>

₹<%= p.getpPrice() %>

</td>

<td>

<%= p.getpDiscount() %>%

</td>

<td>

<a href="edit_product.jsp?pid=<%= p.getpId() %>"
	class="btn btn-warning btn-sm text-white">

	Edit

</a>

<a href="../DeleteProductServlet?pid=<%= p.getpId() %>"
	class="btn btn-danger btn-sm"

	onclick="return confirm('Delete Product?')">

	Delete

</a>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="5"
	class="text-center py-4">

	No products found.

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</div>

</div>

</div>

<!-- =========================
      CATEGORY TABLE
========================= -->

<div class="row mt-4 mb-5">

<div class="col-12">

<div class="card shadow-sm">

<div class="card-header
	bg-dark text-white">

<h4 class="mb-0">

<i class="bi bi-grid"></i>

Manage Categories

</h4>

</div>

<div class="card-body">

<div class="table-responsive">

<table class="table
	table-hover align-middle">

<thead class="table-light">

<tr>

<th>ID</th>
<th>Title</th>
<th>Description</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

if(!clist.isEmpty()){

	for(category c : clist){

%>

<tr>

<td>

<%= c.getCategoryID() %>

</td>

<td>

<%= c.getCategoryTitle() %>

</td>

<td>

<%= c.getCategoryDescription() %>

</td>

<td>

<a href="edit_category.jsp?cid=<%= c.getCategoryID() %>"

	class="btn btn-warning btn-sm text-white">

	Edit

</a>

<a href="../DeleteCategoryServlet?cid=<%= c.getCategoryID() %>"

	class="btn btn-danger btn-sm"

	onclick="return confirm('Delete Category?')">

	Remove

</a>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="4"
	class="text-center py-4">

	No categories found.

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</div>

</div>

</div>

</div>

<!-- =========================
      ADD CATEGORY MODAL
========================= -->

<div class="modal fade"
	id="add-category"
	tabindex="-1">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header
	bg-primary text-white">

<h5 class="modal-title">

	New Category

</h5>

<button type="button"
	class="btn-close btn-close-white"
	data-bs-dismiss="modal">

</button>

</div>

<form action="<%= path %>/AddCategoryServlet"
	method="post">

<div class="modal-body">

<input type="text"
	name="catTitle"
	class="form-control mb-3"
	placeholder="Category Name"
	required>

<textarea name="catDesc"
	class="form-control"
	placeholder="Description"
	rows="4"></textarea>

</div>

<div class="modal-footer">

<button type="submit"
	class="btn btn-primary text-white">

	Save

</button>

</div>

</form>

</div>

</div>

</div>

<!-- =========================
      ADD PRODUCT MODAL
========================= -->

<div class="modal fade"
	id="add-product"
	tabindex="-1">

<div class="modal-dialog modal-lg">

<div class="modal-content">

<div class="modal-header
	bg-success text-white">

<h5 class="modal-title">

	New Product

</h5>

<button type="button"
	class="btn-close btn-close-white"
	data-bs-dismiss="modal">

</button>

</div>

<form action="../AddProductServlet"
	method="post"
	enctype="multipart/form-data">

<div class="modal-body">

<input type="text"
	name="pName"
	class="form-control mb-2"
	placeholder="Product Name"
	required>

<textarea name="pDesc"
	class="form-control mb-2"
	placeholder="Description"></textarea>

<div class="row">

<div class="col-md-4">

<input type="number"
	name="pPrice"
	class="form-control mb-2"
	placeholder="Price"
	required>

</div>

<div class="col-md-4">

<input type="number"
	name="pDiscount"
	class="form-control mb-2"
	placeholder="Discount %"
	value="0">

</div>

<div class="col-md-4">

<input type="number"
	name="pQuantity"
	class="form-control mb-2"
	placeholder="Qty"
	required>

</div>

</div>

<label class="mt-2 fw-bold">

	Select Category

</label>

<select name="catId"
	class="form-select mb-2"
	required>

<%

for(category c : clist){

%>

<option value="<%= c.getCategoryID() %>">

<%= c.getCategoryTitle() %>

</option>

<%

}

%>

</select>

<label class="mt-2 fw-bold">

	Product Image

</label>

<input type="file"
	name="pPhoto"
	class="form-control"
	required>

</div>

<div class="modal-footer">

<button type="submit"
	class="btn btn-success">

	Upload

</button>

</div>

</form>

</div>

</div>

</div>

</body>
</html>