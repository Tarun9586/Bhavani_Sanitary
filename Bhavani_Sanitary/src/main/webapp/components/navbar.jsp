<%@ page import="com.dao.CategoryDao" %>
<%@ page import="com.db.HibernateUtil" %>
<%@ page import="com.entity.category" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<%
    CategoryDao navCdao = new CategoryDao(HibernateUtil.getSessionFactory());
    List<category> navClist = navCdao.getAllCategories();
    request.setAttribute("navClist", navClist);
%>

<style>

/* =========================
   GLOBAL
========================= */

html,
body{
    margin:0;
    padding:0;
    overflow-x:hidden;
    background:#fff;
}

/* =========================
   MOBILE
========================= */

@media(max-width:991px){

    body{
        padding-top:72px;
        padding-bottom:65px;
    }

    .desktop-navbar{
        display:none !important;
    }

}

@media(min-width:992px){

    .mobile-navbar,
    .mobile-bottom-navbar{
        display:none !important;
    }

}

/* =========================
   TOP LOADER
========================= */

#top-loader{
    position:fixed;
    top:0;
    left:0;
    width:0%;
    height:4px;
    background:#0d6efd;
    z-index:999999;
    transition:0.4s;
}

/* =========================
   PAGE LOADER
========================= */

#page-overlay{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,0.7);
    z-index:999998;
    display:flex;
    justify-content:center;
    align-items:center;
    transition:0.5s;
}

.loader-hidden{
    opacity:0;
    visibility:hidden;
}

/* =========================
   MOBILE TOP NAVBAR
========================= */

.mobile-navbar{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    background:#000;
    padding:10px 12px;
    z-index:999999;
    border-bottom:1px solid #222;
}

.mobile-navbar-inner{
    display:flex;
    justify-content:space-between;
    align-items:center;
}

/* BUTTON */

.nav-icon-btn{
    width:42px;
    height:42px;
    border:none;
    border-radius:12px;
    background:#0d6efd;
    color:white;
    font-size:18px;
}

/* LOGO */

.mobile-logo{
    color:white;
    font-size:17px;
    font-weight:700;
    display:flex;
    align-items:center;
}

.mobile-logo i{
    color:#0d6efd;
    margin-right:7px;
}

/* =========================
   OFFCANVAS
========================= */

.offcanvas{
    width:270px !important;
}

.offcanvas-body{
    padding:10px;
}

/* CATEGORY LINK */

.category-link{
    display:flex;
    justify-content:space-between;
    align-items:center;
    text-decoration:none;
    color:#222;
    background:#f7f7f7;
    padding:14px 15px;
    border-radius:12px;
    margin-bottom:10px;
    font-weight:600;
}

.category-link:hover{
    background:#0d6efd;
    color:white;
}

/* PROFILE DROPDOWN */

.profile-dropdown{
    min-width:180px;
    border:none;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 5px 20px rgba(0,0,0,0.15);
}

.profile-dropdown .dropdown-item{
    padding:12px 15px;
    font-weight:500;
}

/* =========================
   MOBILE BOTTOM NAVBAR
========================= */

.mobile-bottom-navbar{
    position:fixed;
    bottom:0;
    left:0;
    width:100%;
    height:60px;
    background:#fff;
    border-top:1px solid #ddd;
    display:flex;
    justify-content:space-evenly;
    align-items:center;
    z-index:999999;
    box-shadow:0 -2px 10px rgba(0,0,0,0.08);
}

/* NAV ITEM */

.bottom-nav-item{
    flex:1;
    height:100%;
    text-decoration:none;
    color:#444;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    font-size:11px;
}

.bottom-nav-item i{
    font-size:19px;
    margin-bottom:2px;
}

.bottom-nav-item.active{
    color:#0d6efd;
}

/* =========================
   SEARCH BAR
========================= */

.mobile-search-container{
    max-height:0;
    overflow:hidden;
    transition:0.4s ease;
}

.mobile-search-container.show-search{
    max-height:80px;
    margin-top:12px;
}

.mobile-search-form{
    display:flex;
    gap:8px;
}

.mobile-search-form input{
    flex:1;
    height:42px;
    border:none;
    outline:none;
    border-radius:30px;
    padding:0 15px;
}

.mobile-search-form button{
    width:42px;
    height:42px;
    border:none;
    border-radius:50%;
    background:#0d6efd;
    color:white;
}

/* =========================
   DESKTOP NAVBAR
========================= */

.desktop-navbar{
    background:#000;
    border-bottom:1px solid #222;
    padding:12px 18px;
}

.search-form{
    width:100%;
    max-width:420px;
    display:flex;
    gap:8px;
}

.search-form input{
    border-radius:10px;
}

.search-form button{
    width:45px;
    border-radius:10px;
}

</style>

<!-- =========================
     TOP LOADER
========================= -->

<div id="top-loader"></div>

<!-- =========================
     PAGE OVERLAY
========================= -->

<div id="page-overlay">
    <div class="spinner-border text-primary"></div>
</div>

<!-- =========================
     MOBILE TOP NAVBAR
========================= -->

<div class="mobile-navbar d-lg-none">

    <div class="mobile-navbar-inner">

        <!-- CATEGORY -->

        <button class="nav-icon-btn"
                data-bs-toggle="offcanvas"
                data-bs-target="#mobileCategoryMenu">

            <i class="bi bi-grid"></i>

        </button>

        <!-- LOGO -->

        <div class="mobile-logo">

            <i class="bi bi-droplet-fill"></i>

            Bhavani Sanitary

        </div>

        <!-- PROFILE -->

        <div class="dropdown">

            <button class="nav-icon-btn"
                    data-bs-toggle="dropdown">

                <i class="bi bi-person-fill"></i>

            </button>

            <ul class="dropdown-menu dropdown-menu-end profile-dropdown">

                <!-- NOT LOGIN -->

                <c:if test="${empty activeUser}">

                    <li>
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/login.jsp">
                            Login
                        </a>
                    </li>

                    <li>
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/register.jsp">
                            Register
                        </a>
                    </li>

                </c:if>

                <!-- NORMAL USER -->

                <c:if test="${not empty activeUser && activeUser.role ne 'admin'}">

                    <li>

                        <span class="dropdown-item-text fw-bold">

                            ${activeUser.name}

                        </span>

                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>

                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/user/my_orders.jsp">

                            My Orders

                        </a>

                    </li>

                    <li>

                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/all_products.jsp">

                            Cart

                        </a>

                    </li>

                    <li>

                        <a class="dropdown-item text-danger"
                           href="${pageContext.request.contextPath}/logout">

                            Logout

                        </a>

                    </li>

                </c:if>

                <!-- ADMIN -->

                <c:if test="${not empty activeUser && activeUser.role eq 'admin'}">

                    <li>

                        <span class="dropdown-item-text fw-bold text-primary">

                            Admin : ${activeUser.name}

                        </span>

                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>

                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/user/admin.jsp">

                            <i class="bi bi-speedometer2 me-2"></i>

                            Admin Panel

                        </a>

                    </li>

                    <li>

                        <a class="dropdown-item text-danger"
                           href="${pageContext.request.contextPath}/logout">

                            Logout

                        </a>

                    </li>

                </c:if>

            </ul>

        </div>

    </div>

</div>

<!-- =========================
     CATEGORY MENU
========================= -->

<div class="offcanvas offcanvas-start"
     tabindex="-1"
     id="mobileCategoryMenu">

    <div class="offcanvas-header">

        <h5 class="offcanvas-title">

            Categories

        </h5>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="offcanvas">
        </button>

    </div>

    <div class="offcanvas-body">

        <c:forEach var="c" items="${navClist}">

            <a href="${pageContext.request.contextPath}/user/view_category.jsp?category=${c.categoryID}"
               class="category-link">

                <span>${c.categoryTitle}</span>

                <i class="bi bi-chevron-right"></i>

            </a>

        </c:forEach>

    </div>

</div>

<!-- =========================
     MOBILE BOTTOM NAVBAR
========================= -->

<div class="mobile-bottom-navbar d-lg-none">

    <!-- HOME -->

    <a href="${pageContext.request.contextPath}/index.jsp"
       class="bottom-nav-item active">

        <i class="bi bi-house-fill"></i>

        <span>Home</span>

    </a>

    <!-- CART -->

    <c:if test="${empty activeUser}">

        <a href="${pageContext.request.contextPath}/login.jsp"
           class="bottom-nav-item">

            <i class="bi bi-cart-fill"></i>

            <span>Cart</span>

        </a>

    </c:if>

    <c:if test="${not empty activeUser}">

        <a href="${pageContext.request.contextPath}/all_products.jsp"
           class="bottom-nav-item">

            <i class="bi bi-cart-fill"></i>

            <span>Cart</span>

        </a>

    </c:if>

    <!-- ORDERS -->

    <c:if test="${empty activeUser}">

        <a href="${pageContext.request.contextPath}/login.jsp"
           class="bottom-nav-item">

            <i class="bi bi-bag-fill"></i>

            <span>Orders</span>

        </a>

    </c:if>

    <c:if test="${not empty activeUser}">

        <a href="${pageContext.request.contextPath}/user/my_orders.jsp"
           class="bottom-nav-item">

            <i class="bi bi-bag-fill"></i>

            <span>Orders</span>

        </a>

    </c:if>

    <!-- SEARCH -->

    <a href="#"
       class="bottom-nav-item"
       onclick="toggleSearchBar()">

        <i class="bi bi-search"></i>

        <span>Search</span>

    </a>

</div>

<!-- =========================
     SEARCH BAR
========================= -->

<div class="mobile-search-container d-lg-none"
     id="mobileSearchContainer"
     style="
        position:fixed;
        bottom:70px;
        left:10px;
        right:10px;
        z-index:999999;
     ">

    <form class="mobile-search-form"
          action="search.jsp"
          method="get">

        <input type="search"
               name="ch"
               placeholder="Search products...">

        <button type="submit">

            <i class="bi bi-search"></i>

        </button>

    </form>

</div>

<!-- =========================
     DESKTOP NAVBAR
========================= -->

<nav class="navbar navbar-expand-lg navbar-dark fixed-top desktop-navbar">

    <div class="container-fluid">

        <a class="navbar-brand fw-bold"
           href="${pageContext.request.contextPath}/index.jsp">

            <i class="bi bi-droplet-fill me-1"></i>

            Bhavani Sanitary

        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse"
             id="navbarSupportedContent">

            <!-- LEFT -->

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">

                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/index.jsp">

                        Home

                    </a>

                </li>

                <li class="nav-item dropdown">

                    <a class="nav-link active dropdown-toggle"
                       href="#"
                       data-bs-toggle="dropdown">

                        Categories

                    </a>

                    <ul class="dropdown-menu">

                        <c:forEach var="c"
                                   items="${navClist}">

                            <li>

                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/user/view_category.jsp?category=${c.categoryID}">

                                    ${c.categoryTitle}

                                </a>

                            </li>

                        </c:forEach>

                    </ul>

                </li>

            </ul>

            <!-- SEARCH -->

            <form class="search-form mx-auto"
                  action="search.jsp"
                  method="get">

                <input class="form-control"
                       type="search"
                       name="ch"
                       placeholder="Search products...">

                <button class="btn btn-outline-light"
                        type="submit">

                    <i class="bi bi-search"></i>

                </button>

            </form>

            <!-- RIGHT -->

            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">

                <c:if test="${empty activeUser}">

                    <li class="nav-item">

                        <a class="nav-link active"
                           href="${pageContext.request.contextPath}/register.jsp">

                            Register

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link active"
                           href="${pageContext.request.contextPath}/login.jsp">

                            Login

                        </a>

                    </li>

                </c:if>

                <!-- NORMAL USER -->

                <c:if test="${not empty activeUser && activeUser.role ne 'admin'}">

                    <li class="nav-item">

                        <a class="nav-link active"
                           href="${pageContext.request.contextPath}/user/my_orders.jsp">

                            My Orders

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link active"
                           href="${pageContext.request.contextPath}/all_products.jsp">

                            Cart

                        </a>

                    </li>

                    <li class="nav-item dropdown">

                        <a class="nav-link dropdown-toggle active"
                           href="#"
                           data-bs-toggle="dropdown">

                            ${activeUser.name}

                        </a>

                        <ul class="dropdown-menu dropdown-menu-end">

                            <li>

                                <a class="dropdown-item text-danger"
                                   href="${pageContext.request.contextPath}/logout">

                                    Logout

                                </a>

                            </li>

                        </ul>

                    </li>

                </c:if>

                <!-- ADMIN -->

                <c:if test="${not empty activeUser && activeUser.role eq 'admin'}">

                    <li class="nav-item dropdown">

                        <a class="nav-link dropdown-toggle active text-warning"
                           href="#"
                           data-bs-toggle="dropdown">

                            Admin

                        </a>

                        <ul class="dropdown-menu dropdown-menu-end">

                            <li>

                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/user/admin.jsp">

                                    Admin Panel

                                </a>

                            </li>

                            <li>

                                <a class="dropdown-item text-danger"
                                   href="${pageContext.request.contextPath}/logout">

                                    Logout

                                </a>

                            </li>

                        </ul>

                    </li>

                </c:if>

            </ul>

        </div>

    </div>

</nav>

<!-- =========================
     SCRIPT
========================= -->

<script>

function toggleSearchBar(){

    const searchBox =
        document.getElementById("mobileSearchContainer");

    searchBox.classList.toggle("show-search");

}

/* LOADER */

document.getElementById('top-loader').style.width = "30%";

window.addEventListener("load", function(){

    const loaderBar =
        document.getElementById("top-loader");

    const overlay =
        document.getElementById("page-overlay");

    loaderBar.style.width = "100%";

    setTimeout(() => {

        overlay.classList.add("loader-hidden");

        setTimeout(() => {

            loaderBar.style.display = "none";

        }, 500);

    }, 400);

});

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>