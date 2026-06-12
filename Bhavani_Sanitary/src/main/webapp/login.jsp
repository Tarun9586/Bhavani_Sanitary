<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<%
    // Cookies se data nikalne ka logic
    String cookieEmail = "";
    String cookiePwd = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("uEmail")) cookieEmail = c.getValue();
            if (c.getName().equals("uPwd")) cookiePwd = c.getValue();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page | Bhavani Sanitary</title>
    <%@ include file="components/all_css.jsp"%>
    <style>
        body { min-height: 100vh; margin: 0; background: linear-gradient(135deg, #e0f7fa, #ffffff); }
        .login-container { margin-top: 140px; }
        .card { border-radius: 15px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); }
        .card-header { background-color: #00796b; color: white; border-radius: 15px 15px 0 0; text-align: center; font-size: 22px; font-weight: bold; }
        .btn-custom { background-color: #00796b; color: white; border-radius: 10px; }
        .btn-custom:hover { background-color: #00695c; color: white; }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp"%>

    <div class="container login-container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card">
                    <div class="card-header"><i class="fa-solid fa-right-to-bracket"></i> Login</div>
                    <div class="card-body">
                        <c:if test="${not empty msg}">
                            <p class="text-danger text-center fw-bold">${msg}</p>
                            <c:remove var="msg" scope="session" />
                        </c:if>

                        <form action="login" method="post">
                            <div class="mb-3">
                                <label class="form-label"><i class="fa-solid fa-envelope"></i> Email</label>
                                <input type="email" name="email" value="<%= cookieEmail %>" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label"><i class="fa-solid fa-lock"></i> Password</label>
                                <input type="password" name="password" value="<%= cookiePwd %>" class="form-control" required>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe" name="remember">
                                <label class="form-check-label" for="rememberMe">Keep me signed in</label>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-custom">Log In</button>
                            </div>
                        </form>
                        <hr>
                        <p class="text-center mb-0">Don't have an account? <a href="register.jsp" class="text-decoration-none fw-bold text-success">Register</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>