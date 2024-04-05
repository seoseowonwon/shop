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
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	<div>카테고리 리스트</div>
	<form method="get" action="/shop/emp/categoryList.jsp">
		<input type="text" name="category" placeholder="카테고리" value="<%=category %>">
		<button type="submit">검색</button>
	</form>
	<table>
		<tr>
			<th>카테고리</th>
			<th>생성 날짜</th>
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
	
	<div><a href="/shop/emp/addCategoryForm.jsp">카테고리 추가</a></div>

</body>
</html>