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
	// 카테고리별 품목 수를 출력
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryList();
	
	String category = request.getParameter("category");
	System.out.println("goodsList param category --> " + category);

	// 페이징을 구하는 controller
	int totalCnt = 0;

	//각 카테고리별 전체 수 구하기
	for (HashMap m : categoryList){
		if(m.get("category").equals(category)){
			 totalCnt = (Integer)(m.get("cnt")); // HashMap<String, Object>의 Object 값은 참조이기 때문에 형변환 할 때 Integer을 사용한다.
		}
	}
	
	System.out.println("totalCnt --> "+totalCnt);
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("goodsList currentPage --> " + currentPage);
	int rowPerPage = 10;
	int startRow = 10 * currentPage;
	int lastPage = 0;
	if (totalCnt % 10 == 0){
		 lastPage = totalCnt / 10 - 1;
		 System.out.println("딱이야");
	} else {
		lastPage = totalCnt / 10;
		System.out.println("딱이아니야");
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
	
	
	// GoodsDAO에서 전체 list와 각 카테고리별 list를 페이징 모델
	
	ArrayList<HashMap<String, Object>> selectGoodsList = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
	
	//전체 품목의 수
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link rel="stylesheet" href="/shop/css/goods.css">
	
	<style>
		.yo{
			float:left;
			margin: 50px;
		}
	</style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid container">
    <a class="navbar-brand" href="#">coonpang</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a href="/shop/customer/goodsList.jsp?order=<%=order %>&goodsTitle=<%=goodsTitle %>" 
          class="nav-link active" aria-current="page">전체</a>
        </li>
        <%
			for(HashMap m : categoryList) {
		%>
	        <li class="nav-item">
	          <a class="nav-link" href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>"><%=(String)(m.get("category"))%>(<%=(Integer)(m.get("cnt"))%>)
	          </a>
	        </li>
	    <%
			}
		%>
        <li class="nav-item">
          <a href="addCustomerForm.jsp" class="nav-link">회원가입</a>
        </li>
         <li class="nav-item">
          <a href="/shop/customer/logout.jsp" class="nav-link">로그아웃</a>
        </li>
      </ul>
      <form method="get" action="/shop/customer/goodsList.jsp" class="d-flex" role="search">
        <input class="form-control me-2" 
        		type="text" placeholder="상품이름" 
        		aria-label="Search" name="goodsTitle"  
        		value="<%=goodsTitle %>">
        <button class="btn btn-outline-success" type="submit">search</button>
        
      </form>
    </div>
  </div>
</nav>
		
		<!-- 상품 이미지 정보등 표시 -->
		<%
			for(HashMap m : selectGoodsList) {
		%>
				<!-- 한 물품의 정보 -->
				<div class="yo">
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
			<div class="d-flex justify-content-center btn-group position-absolute bottom-0 start-50 translate-middle-x" role="group" aria-label="Basic example">
				<button type="button" class="btn btn-light"  >
				<%
					if(currentPage > 1){
				%>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">처음</a>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">이전</a>
				<%
					}
				%>
					</button>
					<button type="button" class="btn btn-light" id="currentNum"><%=currentPage%></button>
					<button type="button" class="btn btn-light">
				<%
					if(currentPage < lastPage){
				%>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">다음</a>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">마지막</a>
				<%
					} 
				%>
					</button>
			</div>
</body>
</html>