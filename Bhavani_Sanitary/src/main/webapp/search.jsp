<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ProductDao, com.db.HibernateUtil, com.entity.product, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results | Bhavani Sanitary</title>
    <%@include file="components/all_css.jsp" %>
</head>
<body style="background-color: #EBF0F3; padding-top: 80px;">

    <%@include file="components/navbar.jsp" %>

    <div class="container">
        <%
            String searchKey = request.getParameter("ch");
            ProductDao dao = new ProductDao(HibernateUtil.getSessionFactory());
            List<product> sList = dao.getSearchProducts(searchKey);
        %>

        <h3 class="mb-4">Search results for: <span class="text-primary">"<%= searchKey %>"</span></h3>

        <div class="row">
            <%
                if(sList != null && !sList.isEmpty()) {
                    for(product p : sList) {
                        double discountPrice = p.getpPrice() - (p.getpPrice() * p.getpDiscount() / 100);
            %>
                <div class="col-md-3 mb-4">
                    <div class="product-card shadow-sm" style="background:#fff; border-radius:15px; padding:15px; text-align:center;">
                        <img src="img/products/<%= p.getpPhoto() %>" style="height:150px; object-fit:contain;" 
                             onerror="this.src='https://www.jaquar.com/images/thumbs/0055445_arc_400.webp';">
                        <h5 class="mt-2 text-truncate"><%= p.getpName() %></h5>
                        <p class="text-success fw-bold mb-1">₹<%= Math.round(discountPrice) %></p>
                        <p class="text-muted small"><del>₹<%= p.getpPrice() %></del> (<%= p.getpDiscount() %>% Off)</p>
                        <a href="product_details.jsp?pid=<%= p.getpId() %>" class="btn btn-primary btn-sm rounded-pill w-100">View</a>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="col-12 text-center mt-5">
                    <i class="bi bi-search" style="font-size: 4rem; color: #ccc;"></i>
                    <h4 class="mt-3 text-muted">Sorry, no products found for "<%= searchKey %>"</h4>
                    <a href="index.jsp" class="btn btn-outline-primary mt-2">Back to Home</a>
                </div>
            <%
                }
            %>
        </div>
    </div>

  
</body>
</html>