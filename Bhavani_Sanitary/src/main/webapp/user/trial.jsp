<%@page import="com.db.HibernateUtil"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.entity.User"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Expense Tracker</title>
	<%@include file="../components/all_css.jsp"%>

	<style>
		body {
			margin: 0;
			padding: 0;
			height: 100vh;
			background-image: url('https://static.vecteezy.com/system/resources/thumbnails/016/287/458/small_2x/notebooks-pens-watches-and-calculators-on-the-wooden-desk-computational-elements-business-finance-time-expenses-photo.jpg');
			background-repeat: repeat-x;
			background-size: auto 100%;
			animation: moveBg 30s linear infinite;
		}

		@keyframes moveBg {
			0% { background-position: -100% 0; }
			100% { background-position: 100% 0; }
		}

		.content {
			position: relative;
			z-index: 1;
			text-align: center;
			padding: 50px;
			background-color: #e0f7fa;
			margin: 100px auto;
			width: 50%;
			border-radius: 12px;
			color: black;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
		}
	</style>
</head>
<body>

<%@include file="../components/navbar.jsp"%>


<div class="content">
<h1>Hello world</h1>
</div>

</body>
</html>
