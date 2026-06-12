<%@page import="com.entity.category"%>
<%@page import="com.entity.product"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.db.HibernateUtil"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Bhavani Sanitary - Category View</title>

<%@include file="../components/all_css.jsp"%>

<style>

/* =========================
        BODY
========================= */

body{
    background-color:#f7f8f9;
    overflow-x:hidden;
    padding-top:80px;
}

/* =========================
     CATEGORY HEADER
========================= */

.category-header{
    background:#ffffff;
    padding:30px;
    border-radius:20px;
    margin-bottom:35px;
    border-left:6px solid #000;
    box-shadow:0 2px 12px rgba(0,0,0,0.05);
}

.category-header h1{
    font-size:35px;
}

.category-header p{
    font-size:15px;
}

/* =========================
       PRODUCT CARD
========================= */

.product-card{
    border:none;
    border-radius:18px;
    transition:0.3s;
    background:#fff;
    overflow:hidden;
}

.product-card:hover{
    transform:translateY(-5px);
    box-shadow:0 10px 20px rgba(0,0,0,0.12) !important;
}

/* IMAGE CHOTI KI HAI */

.product-img-box{
    padding:15px;
}

.product-img{
    height:120px;
    width:100%;
    object-fit:contain;
}

.product-title{
    font-size:15px;
    font-weight:600;
    min-height:38px;
}

.product-price{
    font-size:22px;
    font-weight:bold;
    color:#198754;
}

.stock-badge{
    font-size:12px;
    padding:5px 10px;
    border-radius:20px;
}

.qty-input{
    width:45px;
    text-align:center;
    border:1px solid #ddd;
    font-weight:bold;
    border-radius:5px;
    height:32px;
}

/* =========================
      BUTTONS
========================= */

.btn-cart{
    background:#0d6efd;
    color:white;
    border:none;
}

.btn-cart:hover{
    background:#0b5ed7;
    color:white;
}

.btn-details:hover{
    background:#000;
    color:white;
}

/* =========================
       RESPONSIVE
========================= */

/* TABLET */

@media(max-width:992px){

    .category-header h1{
        font-size:30px;
    }

    .product-img{
        height:100px;
    }

}

/* MOBILE */

@media(max-width:768px){

    body{
        padding-top:70px;
    }

    .container{
        padding-left:12px;
        padding-right:12px;
    }

    .category-header{
        padding:20px;
        border-radius:15px;
        margin-bottom:25px;
    }

    .category-header h1{
        font-size:24px;
    }

    .category-header p{
        font-size:13px;
    }

    .product-card{
        border-radius:15px;
    }

    .product-img{
        height:90px;
    }

    .product-title{
        font-size:13px;
        min-height:35px;
    }

    .product-price{
        font-size:18px;
    }

    .stock-badge{
        font-size:10px;
    }

    .qty-input{
        width:40px;
        height:28px;
        font-size:13px;
    }

    .btn{
        font-size:12px;
        padding:6px 10px;
    }

}

/* SMALL MOBILE */

@media(max-width:576px){

    .product-img{
        height:75px;
    }

    .product-title{
        font-size:12px;
    }

    .product-price{
        font-size:16px;
    }

    .btn{
        font-size:11px;
    }

    .stock-badge{
        font-size:9px;
        padding:4px 8px;
    }

}

</style>

</head>

<body>

<%@include file="../components/navbar.jsp"%>

<div class="container mb-5">

<%

String cidStr = request.getParameter("category");

if(cidStr != null){

    int cid = Integer.parseInt(cidStr);

    ProductDao pdao =
            new ProductDao(HibernateUtil.getSessionFactory());

    CategoryDao cdao =
            new CategoryDao(HibernateUtil.getSessionFactory());

    category currentCat = cdao.getCategoryById(cid);

    List<product> list =
            pdao.getAllProductsByCategoryId(cid);

%>

<!-- =========================
      CATEGORY HEADER
========================= -->

<div class="category-header">

    <h1 class="fw-bold text-capitalize">

        <%= (currentCat != null)
            ? currentCat.getCategoryTitle()
            : "Products" %>

    </h1>

    <p class="text-muted mb-0">

        <%= (currentCat != null)
            ? currentCat.getCategoryDescription()
            : "" %>

    </p>

</div>

<div class="row g-3">

<%

if(list == null || list.isEmpty()){

%>

<div class="col-12 text-center mt-5">

    <h4 class="text-muted mt-3">

        No products found in this category.

    </h4>

    <a href="../index.jsp"
       class="btn btn-dark mt-3">

        Back to Home

    </a>

</div>

<%

}else{

    for(product p : list){

        double finalPrice =
                p.getpPrice()
                - (p.getpPrice()
                * p.getpDiscount() / 100.0);

        int availableQty = p.getpQauntity();

%>

<!-- =========================
         PRODUCT CARD
========================= -->

<div class="col-lg-3 col-md-4 col-6">

    <div class="card product-card h-100 shadow-sm text-center">

        <div class="product-img-box">

            <img src="${pageContext.request.contextPath}/images/<%= p.getpPhoto() %>"
                 class="product-img"
                 alt="<%= p.getpName() %>">

        </div>

        <div class="card-body pt-0">

            <h6 class="product-title text-truncate">

                <%= p.getpName() %>

            </h6>

            <div class="product-price mb-2">

                ₹ <%= Math.round(finalPrice) %>

            </div>

            <div class="mb-2">

            <% if(availableQty > 0){ %>

                <span class="badge bg-light text-dark border stock-badge">

                    Available :
                    <%= availableQty %> Pcs

                </span>

            <% } else { %>

                <span class="badge bg-danger stock-badge">

                    Out of Stock

                </span>

            <% } %>

            </div>

            <% if(availableQty > 0){ %>

            <div class="d-flex justify-content-center align-items-center mb-3">

                <button type="button"
                        class="btn btn-sm btn-outline-danger"
                        onclick="changeQty('<%= p.getpId() %>', -1)">

                    -

                </button>

                <input type="text"
                       id="qty<%= p.getpId() %>"
                       class="qty-input mx-2"
                       value="1"
                       readonly>

                <button type="button"
                        class="btn btn-sm btn-outline-success"
                        onclick="changeQty('<%= p.getpId() %>', 1, <%= availableQty %>)">

                    +

                </button>

            </div>

            <% } %>

            <div class="d-grid gap-2">

            <% if(availableQty > 0){ %>

                <c:choose>

                    <c:when test="${not empty activeUser}">

                        <button
                            onclick="addToCart(
                            '<%= p.getpId() %>',
                            '${activeUser.id}',
                            '<%= p.getpName() %>',
                            '<%= Math.round(finalPrice) %>',
                            '<%= p.getpDiscount() %>',
                            '<%= p.getpPhoto() %>')"

                            class="btn btn-cart btn-sm">

                            Add to Cart

                        </button>

                    </c:when>

                    <c:otherwise>

                        <a href="../login.jsp"
                           class="btn btn-danger btn-sm">

                            Add to Cart

                        </a>

                    </c:otherwise>

                </c:choose>

            <% } else { %>

                <button class="btn btn-secondary btn-sm" disabled>

                    Unavailable

                </button>

            <% } %>

                <a href="../product_details.jsp?pid=<%= p.getpId() %>"
                   class="btn btn-outline-dark btn-details btn-sm">

                    Details

                </a>

            </div>

        </div>

    </div>

</div>

<%

    }

}

%>

</div>

<%

}

%>

</div>

<script>

function changeQty(pid, val, max){

    let input =
            document.getElementById("qty" + pid);

    let current =
            parseInt(input.value);

    if(val === 1 && current < max){

        input.value = current + 1;

    }
    else if(val === -1 && current > 1){

        input.value = current - 1;

    }

}

function addToCart(pid, uid, pname, price, discount, image){

    let qty =
            document.getElementById("qty" + pid).value;

    window.location.href =
            "${pageContext.request.contextPath}/add_to_cart"
            + "?pid=" + pid
            + "&uid=" + uid
            + "&pname=" + pname
            + "&price=" + price
            + "&discount=" + discount
            + "&image=" + image
            + "&qty=" + qty;

}

</script>

</body>
</html>