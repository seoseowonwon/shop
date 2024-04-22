<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<nav class="navbar navbar-expand-lg bg-light">
	<div class="container-fluid container">
		<a class="navbar-brand" href="#">coonpang</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a href="/shop/emp/empList.jsp"
					class="nav-link">사원관리</a></li>
				<li class="nav-item"><a href="/shop/emp/categoryList.jsp"
					class="nav-link">카테고리관리</a></li>
				<li class="nav-item"><a href="/shop/emp/goodsList.jsp"
					class="nav-link">상품관리</a></li>
				<li class="nav-item"><a href="/shop/emp/addGoodsForm.jsp"
					class="nav-link">상품등록</a></li>
				<li class="nav-item"><a href="/shop/emp/empOne.jsp?empId=<%=(String)(loginMember.get("empId"))%>"
					class="nav-link"><%=(String)(loginMember.get("empName"))%>님</a></li>
				<li class="nav-item"><a href="/shop/emp/empLogoutAction.jsp"
					class="nav-link">로그아웃</a></li>
			</ul>
			<form method="get" action="/shop/customer/goodsList.jsp"
				class="d-flex" role="search">
				<input class="form-control me-2" type="text" placeholder="상품이름"
					aria-label="Search" name="goodsTitle">
				<button class="btn btn-outline-success" type="submit">search</button>

			</form>
		</div>
	</div>
</nav>
