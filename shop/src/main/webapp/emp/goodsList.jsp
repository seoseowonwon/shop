<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.GoodsDAO" %>

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
	/*
	String category = request.getParameter("category");
	System.out.println("goodsList category --> "+category);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select category, count(*) cnt from goods group by category order by category asc";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
	while(rs1.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs1.getString("category"));
		m.put("cnt", rs1.getInt("cnt"));
		categoryList.add(m);
	}
	// 디버깅
	System.out.println(categoryList);
	*/
	
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryList();
	
	//카테고리별 선택
	/*
	String sql2 = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice, goods_amount goodsAmount from goods where category = ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,category);
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> list =
			new ArrayList<HashMap<String, Object>>();
	while(rs2.next()) {
		HashMap<String, Object> ms = new HashMap<String, Object>();
		ms.put("goodsNo", rs2.getString("goodsNo"));
		ms.put("category", rs2.getString("category"));
		ms.put("goodsTitle", rs2.getString("goodsTitle"));
		ms.put("filename", rs2.getString("filename"));
		ms.put("goodsPrice", rs2.getString("goodsPrice"));
		ms.put("goodsAmount", rs2.getString("goodsAmount"));
		list.add(ms);
	}
	*/
	
	String category = request.getParameter("category");
	ArrayList<HashMap<String, Object>> list = GoodsDAO.list(category);
	
	
	/*
	//전체 리스트
	String sql3 = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice, goods_amount goodsAmount from goods";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String, Object>> alList =
			new ArrayList<HashMap<String, Object>>();
	while(rs3.next()) {
		HashMap<String, Object> all = new HashMap<String, Object>();
		all.put("goodsNo", rs3.getString("goodsNo"));
		all.put("category", rs3.getString("category"));
		all.put("goodsTitle", rs3.getString("goodsTitle"));
		all.put("filename", rs3.getString("filename"));
		all.put("goodsPrice", rs3.getString("goodsPrice"));
		all.put("goodsAmount", rs3.getString("goodsAmount"));
		alList.add(all);
	}
	System.out.println("alList --> "+alList);
	*/
	ArrayList<HashMap<String, Object>> alList = GoodsDAO.alList();
		
%>

<%
	/*
	//현재 페이지 값 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보이는 인원수
	int rowPerPage = 10;
	
	// DB에서 시작 페이지 값 설정 = (현재 페이지-1) *   한 페이지에 보이는 인원수
	int startRow = (currentPage-1)* rowPerPage;
	
	
	//전체 회원의 수 구하기
	String sql4 = "SELECT count(*) cnt FROM goods";
	PreparedStatement stmt4 = null;
	ResultSet rs4 = null; 
	stmt4 = conn.prepareStatement(sql4);
	rs4 = stmt4.executeQuery();
	
	// 전체 회원수 
	int totalRow = 0;
	
	if(rs4.next()){
		totalRow = rs4.getInt("cnt");
		System.out.println("goodsList totalRow --> "+totalRow);
	}
	
	// 마지막 페이지 계산하기 = 전체 회원수 / 한 페이지에서 보이는 인원수
	int lastPage = totalRow / rowPerPage;
	
	//인원수가 남을 때 마지막 페이지는 +1 해준다. 
	//예) 회원수가 11명이라면 한 페이지당 10명씩 1페이지가 나와야하는데 1명이 더 있기 때문에 총 페이지는 2페이지가 된다.
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	
	//System.out.println(lastPage + " lastPage 회원보기 페이지");
	//System.out.println(totalRow + "<----totalRow 전체 회원수 ");
	//System.out.println(rowPerPage + "<----rowPerPage 한 페이지당 보고싶은 인원수");
	//System.out.println(startRow);
	//System.out.println(rowPerPage);
	*/
%>


<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>



	<!-- 서브메뉴 카테고리별 상품리스트 -->
	
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
				</a>	
		<%		
			}
		%>
	</div>

	<div>
	<%
		if(category == null){
	%>
			
	<%	
			for(HashMap all : alList){
	%>
				<div><img alt="이미지" src="/shop/upload/<%=(String)(all.get("filename"))%>" width="200"></td></div>
				<div>번호: <a href='/shop/emp/goodsListOne.jsp?goodsNo=<%=(Integer)(all.get("goodsNo")) %>'><%=(String)(all.get("goodsTitle")) %></a></div>
				<div>카테고리: <%=(String)(all.get("category")) %></div>
				<div>가격: <%=(Integer)(all.get("goodsPrice")) %></div>
				<div>수량: <%=(Integer)(all.get("goodsAmount")) %></div>
	<%			
			}
		} else if(category != null) {
	
			for(HashMap ms : list){
	%>
				
					<div><img alt="이미지" src="/shop/upload/<%=(String)(ms.get("filename"))%>" width="200"></div>
					<div>카테고리: <%=(String)(ms.get("category")) %></div>
					<div>번호: <a href="/shop/emp/goodsListOne.jsp?goodsNo=<%=(Integer)(ms.get("goodsNo")) %>"><%=(String)(ms.get("goodsTitle")) %></a></div>
					<div>가격: <%=(Integer)(ms.get("goodsPrice")) %></div>
					<div>수량: <%=(Integer)(ms.get("goodsAmount")) %></div>
				
	<%			 
			}
		}
	%>
	</table>
	</div>
</body>
</html>