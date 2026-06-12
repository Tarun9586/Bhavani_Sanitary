<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.db.HibernateUtil" %>
<%@ page import="com.dao.ProductDao" %>
<%@ page import="com.dao.CategoryDao" %>
<%@ page import="com.entity.product" %>
<%@ page import="com.entity.category" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Bhavani Sanitary | Home</title>

<%@include file="components/all_css.jsp" %>

<style>

body{
    background-color:#ffffff;
    padding-top:70px;
    overflow-x:hidden;
}

/* =========================
        SLIDER CSS
========================= */

.slider-container{
    width:90%;
    max-width:1200px;
    margin:20px auto 35px auto;
    overflow:hidden;
    border-radius:20px;
    background:#ffffff;
    position:relative;
}

/* 🔥 FIXED */
.slider-content{
    display:flex;
    gap:20px;
    width:max-content;
    animation:sliderMove 18s linear infinite;
    align-items:center;
}

/* 🔥 FIXED */
.slider-content img{
    width:350px;
    height:220px;
    border-radius:20px;
    object-fit:cover;
    flex-shrink:0;
    cursor:pointer;
}

/* 🔥 FIXED KEYFRAMES */
@keyframes sliderMove{

    0%{
        transform:translateX(0);
    }

    100%{
        transform:translateX(calc(-370px * 3));
    }

}

/* =========================
      CATEGORY NAVBAR
========================= */

.cat-nav-container{
    background:transparent;
    padding:10px 0;
    display:flex;
    margin:20px auto;
    width:90%;
    gap:50px;
    overflow-x:auto;
    white-space:nowrap;
    border-bottom:1px solid rgba(0,0,0,0.05);
    scrollbar-width:none;
}

.cat-nav-container::-webkit-scrollbar{
    display:none;
}

.cat-item{
    text-align:center;
    text-decoration:none;
    color:#212121;
    transition:0.2s;
    position:relative;
    display:flex;
    flex-direction:column;
    align-items:center;
    padding-bottom:10px;
    flex-shrink:0;
}

.cat-item:hover{
    color:#2874f0;
}

.cat-item::after{
    content:"";
    position:absolute;
    bottom:0;
    left:0;
    width:0%;
    height:3px;
    background-color:#2874f0;
    transition:width 0.3s ease;
    border-radius:10px;
}

.cat-item:hover::after{
    width:100%;
}

.cat-icon-box{
    width:64px;
    height:64px;
    margin-bottom:5px;
    transition:transform 0.3s ease;
    display:flex;
    align-items:center;
    justify-content:center;
}

.cat-item:hover .cat-icon-box{
    transform:scale(1.1);
}

.cat-icon-box i{
    font-size:32px;
    color:#444;
}

.cat-item:hover .cat-icon-box i{
    color:#2874f0;
}

.cat-name{
    font-size:14px;
    font-weight:600;
}

/* =========================
      CATEGORY SECTION
========================= */

.category-container{
    width:90%;
    max-width:1300px;
    margin:40px auto;
    border-radius:25px;
    padding:20px;
}

.tap-content{
    display:flex;
    flex-wrap:wrap;
    gap:20px;
    justify-content:flex-start;
}

/* =========================
       PRODUCT CARD
========================= */

.product-card-link{
    width:23%;
    min-width:250px;
    text-decoration:none !important;
    color:inherit !important;
    display:block;
}

.product-card{
    background:#fff;
    border-radius:15px;
    padding:15px;
    text-align:center;
    width:100%;
    transition:transform 0.3s ease;
    cursor:pointer;
    box-shadow:0 4px 8px rgba(0,0,0,0.05);
}

.product-card-link:hover .product-card{
    transform:scale(1.03);
}

/* IMAGE SMALL */
.product-card img{
    width:100%;
    height:90px;
    border-radius:10px;
    object-fit:contain;
    margin-bottom:10px;
}

.product-title{
    display:block;
    font-size:1rem;
    font-weight:600;
    color:#444;
}

.product-offer{
    display:block;
    font-size:1.1rem;
    font-weight:bold;
    color:#2e7d32;
}

.product-price{
    font-size:0.9rem;
    color:#888;
    text-decoration:line-through;
}

/* =========================
        FOOTER
========================= */

.info-link{
    transition:all 0.3s ease;
    display:inline-block;
}

.info-link:hover{
    color:#2874f0 !important;
    transform:translateX(8px);
}

.social-links .btn:hover{
    transform:translateY(-3px);
    transition:0.3s;
}

/* =========================
      RESPONSIVE DESIGN
========================= */

@media (max-width:992px){

    .product-card-link{
        width:48%;
        min-width:unset;
    }

    .product-card img{
        height:85px;
    }

    .tap-content{
        justify-content:space-between;
    }

    .slider-content img{
        width:280px;
        height:180px;
    }

}

@media (max-width:768px){

    body{
        padding-top:65px;
    }

    .slider-container{
        width:95%;
        margin:15px auto;
    }

    .slider-content{
        gap:15px;
    }

    .slider-content img{
        width:220px;
        height:140px;
        border-radius:12px;
    }

    .cat-nav-container{
        width:95%;
        gap:20px;
        padding:10px 5px;
    }

    .cat-icon-box{
        width:55px;
        height:55px;
    }

    .cat-icon-box i{
        font-size:24px;
    }

    .cat-name{
        font-size:12px;
    }

    .category-container{
        width:95%;
        padding:15px;
        border-radius:18px;
    }

    .tap-header h2{
        font-size:20px;
    }

    .tap-header .btn{
        padding:6px 14px;
        font-size:13px;
    }

    .product-card-link{
        width:48%;
    }

    .product-card{
        padding:12px;
        border-radius:14px;
    }

    .product-card img{
        height:75px;
    }

    .product-title{
        font-size:13px;
    }

    .product-offer{
        font-size:17px;
    }

    .product-price{
        font-size:12px;
    }

}

@media (max-width:480px){

    .tap-content{
        gap:12px;
    }

    .product-card-link{
        width:48%;
    }

    .product-card{
        padding:10px;
    }

    .product-card img{
        height:65px;
    }

    .product-title{
        font-size:12px;
    }

    .product-offer{
        font-size:15px;
    }

    .product-price{
        font-size:11px;
    }

    .badge{
        font-size:10px;
    }

    .slider-content img{
        width:180px;
        height:120px;
    }

}

</style>

</head>

<body>

<%@include file="components/navbar.jsp" %>

<!-- =========================
          SLIDER
========================= -->

<div class="slider-container">

    <div class="slider-content">

      <img src="https://www.jaquar.com/images/thumbs/0059244_fusion-prime_400.jpeg" alt="1">

      <img src="https://www.jaquar.com/images/thumbs/0055445_arc_400.webp" alt="2">

      <img src="https://www.jaquar.com/images/thumbs/0055443_blush-sensor-faucets_400.webp" alt="3">

      <img src="https://www.jaquar.com/images/thumbs/0059244_fusion-prime_400.jpeg" alt="1">

      <img src="https://www.jaquar.com/images/thumbs/0055445_arc_400.webp" alt="2">

      <img src="https://www.jaquar.com/images/thumbs/0055443_blush-sensor-faucets_400.webp" alt="3">

    </div>

</div>

<!-- =========================
      CATEGORY NAVBAR
========================= -->

<div class="cat-nav-container">

<%

    try{

        CategoryDao catDao =
                new CategoryDao(HibernateUtil.getSessionFactory());

        List<category> navCats =
                catDao.getAllCategories();

        for(category c : navCats){

            String iconClass = "";

            String title =
                    (c.getCategoryTitle() != null)
                    ? c.getCategoryTitle().toLowerCase().trim()
                    : "";

            if(title.contains("tap")
               || title.contains("faucet")
               || title.contains("fitting")){

                iconClass = "fa-solid fa-faucet";

            }
            else if(title.contains("shower")
                    || title.contains("wellness")){

                iconClass = "fa-solid fa-shower";

            }
            else if(title.contains("basin")
                    || title.contains("sink")
                    || title.contains("washbasin")){

                iconClass = "fa-solid fa-sink";

            }
            else if(title.contains("jet")
                    || title.contains("toilet")
                    || title.contains("closet")
                    || title.contains("commode")){

                iconClass = "fa-solid fa-toilet";

            }
            else{

                iconClass = "fa-solid fa-faucet";

            }

%>

<a href="user/view_category.jsp?category=<%= c.getCategoryID() %>"
   class="cat-item">

    <div class="cat-icon-box">

        <i class="<%= iconClass %>"></i>

    </div>

    <span class="cat-name">

        <%= c.getCategoryTitle() %>

    </span>

</a>

<%

        }

    }catch(Exception e){

        e.printStackTrace();

    }

%>

</div>

<!-- =========================
        PRODUCT LIST
========================= -->

<%

try{

    CategoryDao cdao =
            new CategoryDao(HibernateUtil.getSessionFactory());

    ProductDao pdao =
            new ProductDao(HibernateUtil.getSessionFactory());

    List<category> cList =
            cdao.getAllCategories();

    String[] colors = {
        "#E6F7ED",
        "#FFF3E0",
        "#E3F2FD",
        "#F3E5F5",
        "#FBE9E7"
    };

    int colorIndex = 0;

    for(category c : cList){

        List<product> pList =
                pdao.getAllProductsByCategoryId(
                        c.getCategoryID()
                );

        if(pList != null && !pList.isEmpty()){

            String currentColor =
                    colors[colorIndex % colors.length];

            colorIndex++;

%>

<div class="category-container shadow-sm mb-5"
     style="background-color:<%= currentColor %>;">

    <div class="tap-header d-flex justify-content-between align-items-center mb-4">

        <h2 class="mb-0 fw-bold text-dark">

            <%= c.getCategoryTitle() %>

        </h2>

        <a href="user/view_category.jsp?category=<%= c.getCategoryID() %>"
           class="btn btn-outline-dark rounded-pill px-4">

            View All

        </a>

    </div>

    <div class="tap-content">

<%

    int count = 0;

    for(product p : pList){

        if(count >= 4)
            break;

        double price = p.getpPrice();

        double discount = p.getpDiscount();

        double currentOfferPrice =
                price - (price * discount / 100);

%>

<a href="product_details.jsp?pid=<%= p.getpId() %>"
   class="product-card-link">

    <div class="product-card">

        <img src="img/products/<%= p.getpPhoto() %>"
             onerror="this.src='https://www.jaquar.com/images/thumbs/0055445_arc_400.webp';"
             alt="<%= p.getpName() %>">

        <span class="product-title text-truncate">

            <%= p.getpName() %>

        </span>

        <span class="product-offer">

            ₹ <%= Math.round(currentOfferPrice) %>

        </span>

        <span class="product-price">

            MRP: ₹ <%= Math.round(price) %>

        </span>

        <span class="badge bg-danger rounded-pill mt-1">

            <%= Math.round(discount) %>% Off

        </span>

    </div>

</a>

<%

        count++;

    }

%>

    </div>

</div>

<%

        }

    }

}catch(Exception e){

    out.println(
        "<div class='container mt-3 alert alert-danger'>"
        + e.getMessage()
        + "</div>"
    );

}

%>

<!-- =========================
           FOOTER
========================= -->

<div class="container-fluid mt-5 py-5"
     style="background-color:#ffffff;
            border-top:1px solid #dee2e6;">

    <div class="container">

        <div class="row">

            <div class="col-md-4 mb-4">

                <h4 class="fw-bold text-dark mb-3">

                    <i class="bi bi-droplet-fill text-primary"></i>

                    Bhavani Sanitary

                </h4>

                <p class="text-muted"
                   style="line-height:1.8;
                          font-size:0.95rem;">

                    Redefining luxury and comfort for your
                    personal spaces.

                </p>

                <div class="social-links mt-4">

                    <a href="#"
                       class="btn btn-outline-primary btn-sm rounded-circle me-2">

                        <i class="bi bi-facebook"></i>

                    </a>

                    <a href="#"
                       class="btn btn-outline-danger btn-sm rounded-circle me-2">

                        <i class="bi bi-instagram"></i>

                    </a>

                    <a href="#"
                       class="btn btn-outline-success btn-sm rounded-circle">

                        <i class="bi bi-whatsapp"></i>

                    </a>

                </div>

            </div>

            <div class="col-md-4 mb-4 ps-md-5">

                <h5 class="fw-bold text-dark mb-4">

                    Quick Navigation

                </h5>

                <ul class="list-unstyled">

                    <li>

                        <a href="#"
                           class="text-decoration-none text-muted info-link">

                            Home

                        </a>

                    </li>

                    <li>

                        <a href="#"
                           class="text-decoration-none text-muted info-link">

                            About Our Journey

                        </a>

                    </li>

                </ul>

            </div>

            <div class="col-md-4 mb-4">

                <h5 class="fw-bold text-dark mb-4">

                    Contact Details

                </h5>

                <div class="d-flex mb-3">

                    <i class="bi bi-geo-alt-fill text-primary me-3"></i>

                    <span class="text-muted">

                        Surat, Gujarat

                    </span>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>