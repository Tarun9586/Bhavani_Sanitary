<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.dao.CartDao, com.db.HibernateUtil, com.entity.Cart, com.entity.User, java.util.List" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Bhavani Sanitary - Your Cart</title>

<%@ include file="components/all_css.jsp"%>

<style>

body{
    background-color:#f5f6f8;
    padding-top:90px;
    overflow-x:hidden;
}

/* MAIN CARD */

.cart-card{
    border:none;
    border-radius:20px;
    background:#fff;
    box-shadow:0 4px 18px rgba(0,0,0,0.08);
    overflow:hidden;
}

/* HEADER */

.cart-title{
    font-size:2rem;
    font-weight:700;
    color:#212529;
}

/* TABLE */

.table thead{
    background:#f8f9fa;
}

.table td,
.table th{
    vertical-align:middle;
}

/* PRODUCT NAME */

.product-name{
    font-weight:600;
    color:#0d6efd;
    font-size:1rem;
}

/* QTY BUTTON */

.qty-box{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:10px;
}

.qty-btn{
    width:34px;
    height:34px;
    border-radius:50%;
    border:1px solid #ced4da;
    display:flex;
    align-items:center;
    justify-content:center;
    text-decoration:none;
    font-size:18px;
    font-weight:bold;
    background:#fff;
    transition:0.3s;
}

.qty-btn:hover{
    transform:scale(1.08);
    box-shadow:0 3px 10px rgba(0,0,0,0.12);
}

.qty-number{
    min-width:25px;
    font-weight:700;
    font-size:1rem;
}

/* TOTAL */

.grand-total-row{
    background:#fff8dc !important;
}

/* BUTTONS */

.action-btn{
    border-radius:40px;
    padding:10px 24px;
    font-weight:600;
}

/* REMOVE */

.remove-btn{
    border-radius:30px;
}

/* EMPTY CART */

.empty-cart{
    padding:60px 20px;
}

/* MOBILE RESPONSIVE */

@media(max-width:992px){

    .cart-title{
        font-size:1.7rem;
    }

}

@media(max-width:768px){

    body{
        padding-top:80px;
    }

    .container{
        padding-left:10px;
        padding-right:10px;
    }

    .cart-card{
        border-radius:16px;
    }

    .cart-title{
        font-size:1.4rem;
    }

    .table{
        min-width:700px;
    }

    .table td,
    .table th{
        font-size:0.9rem;
        padding:12px 10px;
    }

    .product-name{
        font-size:0.92rem;
    }

    .qty-btn{
        width:30px;
        height:30px;
        font-size:16px;
    }

    .qty-number{
        font-size:0.95rem;
    }

    .action-btn{
        width:100%;
        margin-bottom:12px;
    }

    .btn-group-mobile{
        display:flex;
        flex-direction:column;
    }

}

@media(max-width:480px){

    .cart-title{
        font-size:1.2rem;
    }

    .table td,
    .table th{
        font-size:0.82rem;
    }

    .qty-box{
        gap:6px;
    }

    .qty-btn{
        width:28px;
        height:28px;
        font-size:15px;
    }

}

</style>
</head>

<body>

<%@ include file="components/navbar.jsp"%>

<c:if test="${empty activeUser}">
    <c:redirect url="login.jsp"></c:redirect>
</c:if>

<div class="container py-3">

    <div class="row justify-content-center">
        <div class="col-12">

            <div class="cart-card">

                <div class="card-body p-lg-4 p-3">

                    <h2 class="text-center cart-title mb-4">
                        🛒 Your Shopping Cart
                    </h2>

                    <!-- SUCCESS MESSAGE -->

                    <c:if test="${not empty addCart}">
                        <div class="alert alert-success alert-dismissible fade show text-center">
                            ${addCart}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="addCart" scope="session"/>
                    </c:if>

                    <c:if test="${not empty succMsg}">
                        <div class="alert alert-success text-center alert-dismissible fade show">
                            ${succMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="succMsg" scope="session"/>
                    </c:if>

                    <c:if test="${not empty errorMsg}">
                        <div class="alert alert-danger text-center alert-dismissible fade show">
                            ${errorMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="errorMsg" scope="session"/>
                    </c:if>

                    <!-- TABLE -->

                    <div class="table-responsive">

                        <table class="table table-hover align-middle text-center">

                            <thead>
                                <tr>
                                    <th class="text-start ps-3">Product</th>
                                    <th>Price</th>
                                    <th>Qty</th>
                                    <th>Subtotal</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>

                            <%

                            User u = (User) session.getAttribute("activeUser");

                            CartDao dao = new CartDao(HibernateUtil.getSessionFactory());

                            List<Cart> cart = dao.getCartByUser(u.getId());

                            Double grandTotal = 0.0;

                            if(cart != null && !cart.isEmpty()){

                                for(Cart c : cart){

                                    grandTotal += c.getTotalPrice();

                            %>

                                <tr>

                                    <!-- PRODUCT -->

                                    <td class="text-start ps-3">

                                        <div class="product-name">
                                            <%= c.getProductName() %>
                                        </div>

                                    </td>

                                    <!-- PRICE -->

                                    <td class="fw-semibold">
                                        ₹ <%= c.getPrice() %>
                                    </td>

                                    <!-- QUANTITY -->

                                    <td>

                                        <div class="qty-box">

                                            <a href="update_cart_qty?cid=<%= c.getCartId() %>&action=dec"
                                               class="qty-btn text-danger">
                                               -
                                            </a>

                                            <span class="qty-number">
                                                <%= c.getQuantity() %>
                                            </span>

                                            <a href="update_cart_qty?cid=<%= c.getCartId() %>&action=inc"
                                               class="qty-btn text-success">
                                               +
                                            </a>

                                        </div>

                                    </td>

                                    <!-- SUBTOTAL -->

                                    <td class="fw-bold text-dark">
                                        ₹ <%= c.getTotalPrice() %>
                                    </td>

                                    <!-- REMOVE -->

                                    <td>

                                        <a href="remove_item?cid=<%= c.getCartId() %>"
                                           class="btn btn-outline-danger btn-sm remove-btn">
                                           Remove
                                        </a>

                                    </td>

                                </tr>

                            <%
                                }

                            } else {
                            %>

                                <tr>

                                    <td colspan="5">

                                        <div class="empty-cart text-center">

                                            <h4 class="fw-bold text-muted">
                                                Your cart is empty 😔
                                            </h4>

                                            <p class="text-secondary mt-2">
                                                Add amazing sanitary products to continue shopping.
                                            </p>

                                            <a href="index.jsp"
                                               class="btn btn-primary rounded-pill px-4 mt-2">
                                               Continue Shopping
                                            </a>

                                        </div>

                                    </td>

                                </tr>

                            <%
                            }
                            %>

                            <!-- GRAND TOTAL -->

                            <tr class="grand-total-row">

                                <td colspan="3" class="text-end fw-bold">
                                    <h5 class="mb-0 fw-bold">
                                        Total Bill Amount :
                                    </h5>
                                </td>

                                <td>
                                    <h5 class="mb-0 fw-bold text-danger">
                                        ₹ <%= grandTotal %>
                                    </h5>
                                </td>

                                <td></td>

                            </tr>

                            </tbody>

                        </table>

                    </div>

                    <!-- ACTION BUTTONS -->

                    <div class="btn-group-mobile d-flex justify-content-center align-items-center gap-3 mt-4">

                        <a href="index.jsp"
                           class="btn btn-outline-secondary action-btn">
                           ← Add More Items
                        </a>

                        <% if(grandTotal > 0){ %>

                        <a href="user/Checkout.jsp"
                           class="btn btn-success action-btn shadow">
                           Proceed to Checkout
                        </a>

                        <% } %>

                    </div>

                </div>

            </div>

        </div>
    </div>

</div>

</body>
</html>