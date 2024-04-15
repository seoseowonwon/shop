<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String customerEmail = request.getParameter("customerEmail");
	String customerPw = request.getParameter("customerPw");
	
	System.out.println(customerEmail + "<-- loginAction param customerEmail");
	System.out.println(customerPw + "<-- loginAction param customerPw");

	String sql = null;
	sql = "select mail, pw, name, birth, gender from customer where mail =? and pw = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerEmail);
	stmt.setString(2, customerPw);
	System.out.println(stmt);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	if(rs.next()){
		//로그인 성공
		System.out.println("로그인성공");
		Map<String, Object> loginCustomer =  new HashMap<String, Object>();
		loginCustomer.put("customerEmail", rs.getString("mail"));
		loginCustomer.put("customerName", rs.getString("name"));;
		loginCustomer.put("birth", rs.getString("birth"));;
		loginCustomer.put("gender", rs.getString("gender"));;
		
		session.setAttribute("loginCustomer", loginCustomer);
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("customerEmail")));
		System.out.println((String)(m.get("customerName")));
		System.out.println((String)(m.get("birth")));
		System.out.println((String)(m.get("gender")));
		
		response.sendRedirect("/shop/customer/goodsList.jsp");
	} else {
			//로그인 실패
			System.out.println("로그인 실패");
			String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
			response.sendRedirect("/shop/customer/loginForm.jsp?errMsg=" + errMsg);
	}
%>