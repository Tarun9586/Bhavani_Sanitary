<%@page import="com.entity.*, com.dao.*, com.db.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout | Bhavani Sanitary</title>
    <%@include file="../components/all_css.jsp" %>
</head>
<body style="background-color: #f7f8f9;">
<%@include file="../components/navbar.jsp" %>

<%
    User u = (User) session.getAttribute("activeUser");
    if(u == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    CartDao dao = new CartDao(HibernateUtil.getSessionFactory());
    List<Cart> cartList = dao.getCartByUser(u.getId());
    Double totalBill = 0.0;
%>

<div class="container pt-5 mt-5 mb-5">
    <div class="row">
        <%-- Left Side: Order Summary --%>
        <div class="col-md-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white">
                    <h4 class="mb-0 text-success">Order Summary</h4>
                </div>
                <div class="card-body">
                    <table class="table align-middle text-center">
                        <thead class="table-light">
                            <tr>
                                <th class="text-start">Product</th>
                                <th>Price</th>
                                <th>Qty</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            if(cartList != null && !cartList.isEmpty()) {
                                for(Cart c : cartList) {
                                    totalBill += c.getTotalPrice();
                            %>
                            <tr>
                                <td class="text-start"><%= c.getProductName() %></td>
                                <td>₹ <%= c.getPrice() %></td>
                                <td><%= c.getQuantity() %></td>
                                <td class="fw-bold">₹ <%= c.getTotalPrice() %></td>
                            </tr>
                            <% 
                                }
                            } else {
                                response.sendRedirect("../index.jsp");
                                return;
                            }
                            %>
                            <tr class="table-info">
                                <td colspan="3" class="text-end fw-bold">Grand Total:</td>
                                <td class="fw-bold fs-5 text-danger">₹ <%= totalBill %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%-- Right Side: Shipping Form --%>
        <div class="col-md-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Shipping Details</h4>
                </div>
                <div class="card-body">
    <form action="../OrderServlet" method="post" id="checkout-form">
        
        <div class="mb-3">
            <label class="form-label fw-bold">Full Name</label>
            <%-- Pre-fill User Name --%>
            <input type="text" name="username" value="<%= u.getName() %>" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label fw-bold">Email Address</label>
            <%-- Pre-fill Email --%>
            <input type="email" name="email" value="<%= u.getEmail() %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">Mobile Number</label>
            <%-- Pre-fill Phone Number (phno variable from your User class) --%>
            <input type="text" 
                   name="mobile" 
                   id="mobile"
                   value="<%= (u.getPhno() != null) ? u.getPhno() : "" %>"
                   class="form-control" 
                   placeholder="Enter 10 digit mobile number" 
                   maxlength="10" 
                   required>
            <div id="mobile-error" class="text-danger small" style="display:none;">
                Please enter a valid 10-digit mobile number.
            </div>
        </div>
        
        <div class="mb-3">
            <label class="form-label fw-bold">Shipping Address</label>
            <%-- Pre-fill Address in Textarea --%>
            <textarea name="address" class="form-control" rows="3" required 
                      placeholder="Enter building, street, city, pincode"><%= (u.getAddress() != null) ? u.getAddress() : "" %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">Payment Mode</label>
            <select name="payment" class="form-select">
                <option value="COD">Cash On Delivery (COD)</option>
                <option value="Online" disabled>Online Payment (Coming Soon)</option>
            </select>
        </div>

        <input type="hidden" name="totalAmount" value="<%= totalBill %>">

        <button type="submit" class="btn btn-warning btn-lg w-100 mt-3 fw-bold shadow-sm">
           Confirm & Place Order
        </button>
    </form>
</div>
            </div>
        </div>
    </div>
</div>

<%-- JavaScript Validation for Mobile Number --%>
<script>
document.getElementById("checkout-form").addEventListener("submit", function(event) {
    var mobile = document.getElementById("mobile").value;
    var errorDiv = document.getElementById("mobile-error");
    
    // Pattern: 10 digits starting with 6, 7, 8, or 9
    var mobilePattern = /^[6-9]\d{9}$/;

    if (!mobilePattern.test(mobile)) {
        errorDiv.style.display = "block";
        errorDiv.innerText = "Enter the Valid Phone number (10 digits starting with 6-9)";
        event.preventDefault(); // Stop form submission
    } else {
        errorDiv.style.display = "none";
    }
});

// To prevent typing non-numeric characters
document.getElementById("mobile").addEventListener("input", function(e) {
    this.value = this.value.replace(/[^0-9]/g, '');
});
</script>

</body>
</html>