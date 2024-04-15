<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%

	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("goodsList currentPage --> " + currentPage);
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String order = request.getParameter("order");
	System.out.println("goodsList param category --> " + category);
	System.out.println("goodsList param goodsTitle --> " + goodsTitle);
	System.out.println( "goodsList param order --> " + order);
	
	if(goodsTitle == null){
		goodsTitle = "";
	}
	
	if(order == null){
		order = "create_date";
	}
	
	String sql = null;
	sql = "select category, count(*) cnt from goods where goods_title like ? group by category order by category";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, "%" + goodsTitle + "%");
	System.out.println(stmt);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();		
		m.put("category", rs.getString("category"));
		m.put("cnt", rs.getInt("cnt"));
		
		categoryList.add(m);
		
	}
	
	int lastPage = 0;
	int cnt = 0;
	for(HashMap m : categoryList) {
		if(((String)(m.get("category"))).equals(category)){
			cnt = (Integer)(m.get("cnt"));
			break;
		}
		
		// 전체면 모든 카테고리의 카운트 값을 더함. 맞는게있으면 그 값을 cnt에 대입하고 break;
		cnt += (Integer)(m.get("cnt"));
	}
	
	if(cnt % rowPerPage == 0){
		lastPage = cnt / rowPerPage;
	} else {
		lastPage = cnt / rowPerPage + 1;
	}
	
	String sql2 = null;
	PreparedStatement stmt2 = null;
	if(category == null || category.equals("null")){
		sql2 = "select goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice" + 
				" from goods where goods_title like ? order by " + order  + " desc limit ?, ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, "%" + goodsTitle + "%");
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		System.out.println(stmt2);
	} else {
		sql2 = "select goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice" + 
				" from goods where category = ? and goods_title like ? order by " + order  + " desc limit ?, ?";
		
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, category);
		stmt2.setString(2, "%" + goodsTitle + "%");
		stmt2.setInt(3, startRow);
		stmt2.setInt(4, rowPerPage);
		System.out.println(stmt2);
	}
	
	
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
	
	while(rs2.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("goodsNo", rs2.getInt("goodsNo"));
		m.put("goodsTitle", rs2.getString("goodsTitle"));
		m.put("filename", rs2.getString("filename"));
		m.put("goodsPrice", rs2.getInt("goodsPrice"));
		
		goodsList.add(m);
		
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/shop/css/goods.css">
</head>
<body>

	<div>
		<a href="addCustomerForm.jsp">회원가입</a>
	</div>
	
	<div>
		<form method="get" action="/shop/customer/goodsList.jsp">
			<input type="text" name="goodsTitle" placeholder="상품 이름" value="<%=goodsTitle %>">
			<button type="submit">검색</button>
		</form>
	</div>
	
	<div>
		<a href="/shop/customer/goodsList.jsp?order=<%=order %>&goodsTitle=<%=goodsTitle %>">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category")) %>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">
					<%=(String)(m.get("category")) %>
					(<%=(Integer)(m.get("cnt")) %>)
				</a>
		<%
			}
		%>
	</div>
	
	<div>
		<a href="/shop/customer/goodsList.jsp?order=goods_title&category=<%=category%>&goodsTitle=<%=goodsTitle %>">이름순</a>
		<a href="/shop/customer/goodsList.jsp?order=goods_price&category=<%=category%>&goodsTitle=<%=goodsTitle %>">가격순</a>
		<a href="/shop/customer/goodsList.jsp?order=create_date&category=<%=category%>&goodsTitle=<%=goodsTitle %>">최신순</a>
	</div>
	
	<div>
		<ul class="goodsList">
			<%
				for(HashMap m : goodsList) {
			%>
					<li class="goods">
						<div class="goodsImg">
							<a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
								<img src="../upload/<%=(String)(m.get("filename")) %>">
							</a>
						</div>
						<div class="goodsInfo">
							<a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
								<%=(String)(m.get("goodsTitle")) %>
							</a>
							<p><%=(Integer)(m.get("goodsPrice")) %></p>
						</div>
					</li>
			<%
				}
			%>
		</ul>
	</div>
	
	<div>
		<%
			if(currentPage > 1){
		%>
				  	<a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">처음</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">이전</a>
		<%
			}
			if(currentPage < lastPage){
		%>
				  	<a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">다음</a>
				  	<a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">마지막</a>
		<%
			} 
		%>
	</div>
</body>
</html>