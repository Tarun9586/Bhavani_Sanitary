<%@page import="com.entity.User"%>
<%@page import="com.entity.Order"%>
<%@page import="com.dao.OrderDao"%>
<%@page import="com.db.HibernateUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders | Bhavani Sanitary</title>
    <%@include file="../components/all_css.jsp" %>
    <style>
        .order-card { border-radius: 10px; border: none; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .status-badge { padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; }
        .btn-cancel { font-size: 0.75rem; padding: 2px 8px; }
    </style>
</head>
<body style="background-color: #f4f7f6;">
<%@include file="../components/navbar.jsp" %>

<%
    // Security check
    User user = (User) session.getAttribute("activeUser");
    if (user == null) {
        session.setAttribute("msg", "Please Login first!");
        response.sendRedirect("../login.jsp");
        return;
    }

    OrderDao dao = new OrderDao(HibernateUtil.getSessionFactory());
    List<Order> list = dao.getOrdersByUserId(user.getId());
%>

<div class="container mt-5 pt-4">
    <h3 class="mb-4 text-center fw-bold"><i class="bi bi-clock-history"></i> Your Purchase History</h3>
    
    <% 
        String succMsg = (String) session.getAttribute("succMsg");
        String errorMsg = (String) session.getAttribute("errorMsg");
        if(succMsg != null) { %>
            <div class="alert alert-success text-center"><%= succMsg %></div>
        <% session.removeAttribute("succMsg"); }
        if(errorMsg != null) { %>
            <div class="alert alert-danger text-center"><%= errorMsg %></div>
        <% session.removeAttribute("errorMsg"); }
    %>

    <div class="row">
        <div class="col-md-12">
            <div class="card order-card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th class="ps-4">Order ID</th>
                                    <th>Product Details</th>
                                    <th>Quantity</th>
                                    <th>Total Price</th>
                                    <th>Order Date</th>
                                    <th>Status</th>
                                    <th class="pe-4">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (list != null && !list.isEmpty()) {
                                        for (Order o : list) {
                                            String status = o.getOrderStatus();
                                            String badgeClass = "bg-warning text-dark"; // Default: Pending
                                            
                                            if("Shipped".equalsIgnoreCase(status)) badgeClass = "bg-info text-white";
                                            else if("Delivered".equalsIgnoreCase(status)) badgeClass = "bg-success text-white";
                                            else if("Cancelled".equalsIgnoreCase(status)) badgeClass = "bg-danger text-white";
                                %>
                                <tr>
                                    <td class="ps-4 fw-bold text-primary">#ORD-<%= o.getOrderId() %></td>
                                    <td>
                                        <span class="fw-bold"><%= o.getProductName() %></span><br>
                                        <small class="text-muted">Payment: <%= o.getPaymentMode() %></small>
                                    </td>
                                    <td><%= o.getQuantity() %></td>
                                    <td class="fw-bold text-success">₹<%= o.getPrice() %></td>
                                    <td><%= o.getOrderDate() %></td>
                                    <td>
                                        <span class="badge status-badge <%= badgeClass %>">
                                            <%= status %>
                                        </span>
                                    </td>
                                    <td class="pe-4">
                                        <% if("Pending".equalsIgnoreCase(status)) { %>
                                            <form action="../CancelOrderServlet" method="post" onsubmit="return confirm('Bhai, pakka cancel karna hai?')">
                                                <input type="hidden" name="oid" value="<%= o.getOrderId() %>">
                                                <button type="submit" class="btn btn-outline-danger btn-sm btn-cancel">
                                                    <i class="bi bi-x-circle"></i> Cancel
                                                </button>
                                            </form>
                                        <% } else { %>
                                            <span class="text-muted small">-</span>
                                        <% } %>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    } else { 
                                %>
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <i class="bi bi-cart-x fs-1 text-muted"></i>
                                        <p class="mt-2 text-muted">No orders found yet!</p>
                                        <a href="../index.jsp" class="btn btn-primary btn-sm mt-2">Start Shopping</a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>