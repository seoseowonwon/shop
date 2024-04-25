<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
		return;
	}
%>
<%
	String category = request.getParameter("category");	
	System.out.println(category + "<-- categoryList param category");
	if(category == null){
		category = "";
	}

	String sql = "select category,  create_date createDate from category where category like ?;";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, "%" + category + "%");
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, String>> categoryList = new ArrayList<>();
	while(rs.next()){
		HashMap<String, String> m = new HashMap<>();
		m.put("category", rs.getString("category"));
		m.put("createDate", rs.getString("createDate"));
		
		categoryList.add(m);
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HANGER</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container bg-success" >
	<div class="row">
		<div class="col-1"></div>
		<div class="col-10 content bg-white shadow lgPgCenterDiv">
			<nav class="navbar navbar-expand-lg bg-light">
				<div class="container-fluid">
					<a class="navbar-brand" href="#">HANGER</a>
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
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
							<li class="nav-item"><a href="/shop/emp/empLogoutAction.jsp"
								class="nav-link">로그아웃</a></li>
						</ul>
						<form method="get" action="/shop/emp/categoryList.jsp"
							class="d-flex" role="search">
							<input class="form-control me-2" type="text" name="category"
								placeholder="카테고리 검색" value="<%=category%>" aria-label="Search">
							<button class="btn btn-outline-success" type="submit">search</button>

						</form>
					</div>
				</div>
			</nav>
			<table class="table">
				<tr>
					<td>카테고리</td>
					<td>생성 날짜</td>
				</tr>
				
				<%
					for(HashMap<String, String> m : categoryList){
				%>
					<tr>
						<td><%=m.get("category") %></td>
						<td><%=m.get("createDate") %></td>
					</tr>
				<%
					}
				%>
				</table>
				<br>
				<a class="btn btn btn-outline-secondary" href="/shop/emp/addCategoryForm.jsp" role="button">카테고리추가</a>
	  			<br>
	  			<br>
	  			<br>
	  			<br>
	  			<br>
	  			<br>
	  			<br>
	  			<br>
  			</div>
  			<div class="col-1"></div>
	</div>
</body>
</html>