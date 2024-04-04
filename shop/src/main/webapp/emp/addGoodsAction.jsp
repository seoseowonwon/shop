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
	String category = request.getParameter("category");
	String empId = request.getParameter("empId");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	String goodsPrice = request.getParameter("goodsPrice");
	String goodsAmount = request.getParameter("goodsAmount");
	String updateDate = request.getParameter("updateDate");
	String createDate = request.getParameter("createDate");
	
	//디버깅
	System.out.println("addGoodsAction category --> "+category);	
	System.out.println("addGoodsAction empId --> "+empId);	
	System.out.println("addGoodsAction goodsTitle --> "+goodsTitle);	
	System.out.println("addGoodsAction goodsContent --> "+goodsContent);	
	System.out.println("addGoodsAction goodsPrice --> "+goodsPrice);	
	System.out.println("addGoodsAction goodsAmount --> "+goodsAmount);	
	System.out.println("addGoodsAction updateDate --> "+updateDate);	
	System.out.println("addGoodsAction createDate --> "+createDate);	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	//goods테이블에 새로운 값 추가 SQL
	String sql1 = 
	"insert into goods ( category, emp_id empId, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate, create_date createDate) goods values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, category);
	stmt1.setString(2, empId);
	stmt1.setString(3, goodsTitle);
	stmt1.setString(4, goodsContent);
	stmt1.setString(5, goodsPrice);
	stmt1.setString(6, goodsAmount);
	stmt1.setString(7, updateDate);
	stmt1.setString(8, createDate);
	rs1 = stmt1.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

</body>
</html>