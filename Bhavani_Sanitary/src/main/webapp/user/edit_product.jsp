<%@page import="com.entity.category"%>
<%@page import="com.entity.product"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.db.HibernateUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Product | Bhavani Sanitary</title>
<%@include file="../components/all_css.jsp"%>
</head>
<body style="background-color: #f0f2f5;">
<%@include file="../components/navbar.jsp"%>

<%
    int pid = Integer.parseInt(request.getParameter("pid"));
    ProductDao dao = new ProductDao(HibernateUtil.getSessionFactory());
    product p = dao.getProductById(pid);

    CategoryDao cdao = new CategoryDao(HibernateUtil.getSessionFactory());
    List<category> clist = cdao.getAllCategories();
%>

<div class="container mt-5 mb-5">
    <div class="row">
        <div class="col-md-8 offset-md-2"> 
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h3><i class="bi bi-pencil-square"></i> Edit Product Details</h3>
                </div>
                <div class="card-body">
                    <form action="../UpdateProductServlet" method="post" enctype="multipart/form-data">
                        
                        <input type="hidden" name="pId" value="<%= p.getpId() %>">
                        <input type="hidden" name="oldImage" value="<%= p.getpPhoto() %>">
                        
                        <div class="mb-3">
                            <label class="fw-bold">Product Name</label>
                            <input name="pName" value="<%= p.getpName() %>" type="text" class="form-control" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="fw-bold">Description</label>
                            <textarea name="pDesc" class="form-control" rows="3"><%= p.getpDescription() %></textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="fw-bold">Price</label>
                                <input name="pPrice" value="<%= p.getpPrice() %>" type="number" class="form-control" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="fw-bold">Discount (%)</label>
                                <input name="pDiscount" value="<%= p.getpDiscount() %>" type="number" class="form-control">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="fw-bold text-danger">Stock Qty</label>
                                <%
                                    int currentQty = 0;
                                    try { currentQty = p.getpQauntity(); } catch(Exception e) {
                                        try { currentQty = p.getpQuantity(); } catch(Exception ex){}
                                    }
                                %>
                                <input name="pQuantity" value="<%= currentQty %>" type="number" class="form-control" min="0" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="fw-bold">Category</label>
                            <select name="catId" class="form-select" required>
                                <% if(clist != null) { for(category c : clist) { %>
                                    <option value="<%= c.getCategoryID() %>" <%= (p.getCategory() != null && c.getCategoryID() == p.getCategory().getCategoryID()) ? "selected" : "" %> >
                                        <%= c.getCategoryTitle() %>
                                    </option>
                                <% } } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="fw-bold">Change Photo (Optional)</label>
                            <input name="pPhoto" type="file" class="form-control">
                            <div class="mt-2">
                                <small class="text-muted d-block">Current: <%= p.getpPhoto() %></small>
                                <img src="../images/<%= p.getpPhoto() %>" style="height: 50px; border-radius: 5px;" class="shadow-sm border mt-1" onerror="this.src='../img/default.jpg'">
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-success px-5 fw-bold shadow-sm">
                                <i class="bi bi-save me-2"></i>SAVE UPDATES
                            </button>
                            <a href="admin.jsp" class="btn btn-outline-dark px-4">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>