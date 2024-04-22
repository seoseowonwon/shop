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
	
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryList();
	
	String category = request.getParameter("category");
	ArrayList<HashMap<String, Object>> list = GoodsDAO.list(category);
	
	ArrayList<HashMap<String, Object>> alList = GoodsDAO.alList();
		
%>

<%
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
<style>
	.yo{
			float:left;
			margin: 50px;
		}
</style>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid container">
    
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
      </form>
    </div>
  </div>
</nav>


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
				<div class="yo">
					<div><img alt="이미지" src="/shop/upload/<%=(String)(all.get("filename"))%>" width="200" height ="200"></td></div>
					<div>번호: <a href='/shop/emp/goodsListOne.jsp?goodsNo=<%=(Integer)(all.get("goodsNo")) %>'><%=(String)(all.get("goodsTitle")) %></a></div>
					<div>카테고리: <%=(String)(all.get("category")) %></div>
					<div>가격: <%=(Integer)(all.get("goodsPrice")) %></div>
					<div>수량: <%=(Integer)(all.get("goodsAmount")) %></div>
				</div>
	<%			
			}
		} else if(category != null) {
	
			for(HashMap ms : list){
	%>
					<div class="yo">
						<div><img alt="이미지" src="/shop/upload/<%=(String)(ms.get("filename"))%>" width="200" height ="200"></div>
						<div>카테고리: <%=(String)(ms.get("category")) %></div>
						<div>번호: <a href="/shop/emp/goodsListOne.jsp?goodsNo=<%=(Integer)(ms.get("goodsNo")) %>"><%=(String)(ms.get("goodsTitle")) %></a></div>
						<div>가격: <%=(Integer)(ms.get("goodsPrice")) %></div>
						<div>수량: <%=(Integer)(ms.get("goodsAmount")) %></div>
					</div>
				
	<%			 
			}
		}
	%>
	</div>
	<div>
			<%
				if(currentPage > 1){
			%>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">처음</a>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">이전</a>
			<%
				}
				if(currentPage < lastPage){
			%>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">다음</a>
					  	<a href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">마지막</a>
			<%
				} 
			%>
	</div>
</body>
</html>