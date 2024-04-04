<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String goodsNo = request.getParameter("goodsNo");
	System.out.println("goodsList category --> "+goodsNo);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	//상세보기 정보
	String sql1 = "select goods_no goodsNo, emp_id empId, category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate, create_date createDate from goods where goods_no = ?";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1,goodsNo);
	rs1 = stmt1.executeQuery();
	
	
	ArrayList<HashMap<String, Object>> oneList =
			new ArrayList<HashMap<String, Object>>();
	if(rs1.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("goodsNo", rs1.getString("goodsNo"));
		m.put("category", rs1.getString("category"));
		m.put("empId", rs1.getString("empId"));
		m.put("goodsTitle", rs1.getString("goodsTitle"));
		m.put("goodsContent", rs1.getString("goodsContent"));
		m.put("goodsPrice", rs1.getString("goodsPrice"));
		m.put("goodsAmount", rs1.getString("goodsAmount"));
		m.put("updateDate", rs1.getString("updateDate"));
		m.put("createDate", rs1.getString("createDate"));
		oneList.add(m);
	}
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsListOne</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<table class="table table-hover">
		<%
			for(HashMap m : oneList) {
		%>
			<tr>
				<td>goodsNo</td>
				<td><%=(String)(m.get("goodsNo")) %></td>
			</tr>
			<tr>
				<td>category</td>
				<td><%=(String)(m.get("category")) %></td>
			<tr>
				<td>empId</td>
				<td><%=(String)(m.get("empId")) %></td>
			</tr>
			<tr>
				<td>goodsTitle</td>
				<td><%=(String)(m.get("goodsTitle")) %></td>
			</tr>
			
			<tr>
				<td>goodsContent</td>
				<td><%=(String)(m.get("goodsContent")) %></td>
			</tr>
			
			<tr>
				<td>goodsPrice</td>
				<td><%=(String)(m.get("goodsPrice")) %></td>
			</tr>
			<tr>
				<td>goodsAmount</td>
				<td><%=(String)(m.get("goodsAmount")) %></td>
			</tr>
			<tr>
				<td>updateDate</td>
				<td><%=(String)(m.get("updateDate")) %></td>
			</tr>
			<tr>
				<td>createDate</td>
				<td><%=(String)(m.get("createDate")) %></td>
			</tr>				
		<%		
			}
		%>
		</table>
	</div>
</body>
</html>