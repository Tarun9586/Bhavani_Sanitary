<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<%@ include file="components/all_css.jsp"%>

<style>
body { min-height: 100vh; margin: 0; background: linear-gradient(135deg, #f4f7f6, #ffffff); }
.register-container { margin-top: 140px; }
.card { border-radius: 15px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15); }
.card-header { background-color: #00796b; color: white; border-radius: 15px 15px 0 0; text-align: center; font-size: 22px; font-weight: bold; }
.btn-custom { background-color: #00796b; color: white; border-radius: 10px; }
.btn-custom:hover { background-color: #00695c; color: white; }
.error-msg { color: red; font-size: 0.85rem; display: none; }
</style>
</head>

<body>
	<%@ include file="components/navbar.jsp"%>

	<div class="container register-container">
		<div class="row justify-content-center">
			<div class="col-md-5 col-lg-4">
				<div class="card">
					<div class="card-header"><i class="fa-solid fa-user-plus"></i> Create Account</div>
					<div class="card-body">

						<c:if test="${not empty sessionScope.msg}">
							<c:choose>
								<c:when test="${sessionScope.msg == 'Registration Successful! Please Login.'}">
									<div class="alert alert-success text-center">${sessionScope.msg}</div>
								</c:when>
								<c:otherwise>
									<div class="alert alert-danger text-center">${sessionScope.msg}</div>
								</c:otherwise>
							</c:choose>
							<c:remove var="msg" scope="session" />
						</c:if>

						<form action="userRegister" method="post" id="regForm">
							<div class="mb-3">
								<label class="form-label"><i class="fa-solid fa-user"></i> Full Name</label> 
								<input type="text" name="name" class="form-control" placeholder="Enter name" required>
							</div>

							<div class="mb-3">
								<label class="form-label"><i class="fa-solid fa-envelope"></i> Email</label> 
								<input type="email" name="email" class="form-control" placeholder="email@example.com" required>
							</div>

							<div class="mb-3">
								<label class="form-label"><i class="fa-solid fa-phone"></i> Phone Number</label> 
								<input type="tel" name="phno" id="phno" class="form-control" placeholder="10 digit number" required> 
								<span id="phnoError" class="error-msg">Valid 10-digit number required.</span>
							</div>

							<div class="mb-3">
								<label class="form-label"><i class="fa-solid fa-lock"></i> Password</label> 
								<input type="password" name="password" id="password" class="form-control" placeholder="Min 6 characters" required>
								<span id="passError" class="error-msg">Min 6 characters required.</span>
							</div>

							<div class="d-grid">
								<button type="submit" class="btn btn-custom">Register</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		document.getElementById("regForm").onsubmit = function(e) {
			let valid = true;
			const phno = document.getElementById("phno").value;
			const pass = document.getElementById("password").value;
			
			if (!/^[0-9]{10}$/.test(phno)) {
				document.getElementById("phnoError").style.display = "block";
				valid = false;
			} else { document.getElementById("phnoError").style.display = "none"; }

			if (pass.length < 6) {
				document.getElementById("passError").style.display = "block";
				valid = false;
			} else { document.getElementById("passError").style.display = "none"; }

			if (!valid) e.preventDefault();
		};
	</script>
</body>
</html>