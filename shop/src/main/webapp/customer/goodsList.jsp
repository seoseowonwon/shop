<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
<%@ page import ="shop.dao.*" %>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
	
	// 페이징을 구하는 controller
	int totalCnt = GoodsDAO.totalCnt();
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("goodsList currentPage --> " + currentPage);
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	int lastPage = 0;
	if(lastPage % 10 != 0){
		lastPage = totalCnt / 10 + 1;
	}
	
	System.out.println("lastPage --> "+lastPage);
	String goodsTitle = request.getParameter("goodsTitle");
	String order = request.getParameter("order");
	System.out.println("goodsList param goodsTitle --> " + goodsTitle);
	System.out.println( "goodsList param order --> " + order);
	
	if(goodsTitle == null){
		goodsTitle = "";
	}
	
	if(order == null){
		order = "create_date";
	}
	
	
	String category = request.getParameter("category");
	System.out.println("goodsList param category --> " + category);
	
	// GoodsDAO에서 전체 list와 각 카테고리별 list를 페이징 모델
	ArrayList<HashMap<String, Object>> selectGoodsList = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryList();
	
	//전체 품목의 수
	
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
		<ul class="goodsList">
			<%
				for(HashMap m : selectGoodsList) {
			%>
					<!-- 한 물품의 정보 -->
					<div>
						<a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
							<img src="../upload/<%=(String)(m.get("filename")) %>" width="200" height ="200">
						</a>
						<div>
							<a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
								<%=(String)(m.get("goodsTitle")) %>
							</a>
						</div>
						<div>가격: <%=(Integer)(m.get("goodsPrice")) %></div>
					</div>
			<%
				}
			%>
		</ul>
	</div>
	
	<div>
		<%
			if(currentPage > 1){
		%>
				  	<a href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">처음</a>
				  	<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">이전</a>
		<%
			}
			if(currentPage < lastPage){
		%>
				  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">다음</a>
				  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">마지막</a>
		<%
			} 
		%>
	</div>
</body>
</html>