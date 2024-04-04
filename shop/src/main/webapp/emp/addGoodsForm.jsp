<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<!-- Model Layer -->
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select category from category";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	ArrayList<String> categoryList =
			new ArrayList<String>();
	while(rs1.next()) {
		categoryList.add(rs1.getString("category"));
	}
	// 디버깅
	System.out.println(categoryList);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<h1>상품등록</h1>
	<form method="post" action="/shop/emp/addGoodsAction.jsp">
		<table>
			<tr>
				<td>category :</td>
				<td>
					<select name="category">
						<option value="">선택</option>
						<%
							for(String c : categoryList) {
						%>
								<option value="<%=c%>"><%=c%></option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
		<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
		<tr>
			<td>goodsTitle :</td>
			<td><input type="text" name="goodsTitle"></td>
		</tr>
		<tr>
			<td>goodsPrice :</td>
			<td><input type="number" name="goodsPrice"></td>
		</tr>
		<tr>
			<td>goodsAmount :</td>
			<td><input type="number" name="goodsAmount"></td>
		</tr>
		</table>
		<div>
			<textarea rows="5" cols="50" name="goodsContent" placeholder="content..."></textarea>
		</div>
		<div>
			<button type="submit">상품등록</button>
		</div>
	</form>
</body>
</html>
