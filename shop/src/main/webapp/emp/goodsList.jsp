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
	System.out.println("goodsList param category --> " + category);
	
	
	ArrayList<HashMap<String, Object>> alList = GoodsDAO.alList();
	
%>

<%
//페이징을 구하는 controller
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
	int rowPerPage = 8;
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

	
	ArrayList<HashMap<String, Object>> selectGoodsList = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<style>
		.bordered-div {
	        border: 1px solid gray; /* 테두리 스타일을 지정합니다. */
	        padding: 10px; /* 내용과 테두리 사이의 여백을 지정합니다. */
	        width: 250px;
	        float:left;
			margin: 50px;
   		 }
		a{
			text-decoration: none;
			color: black;
		}
		.round {
		
			display:
			inline-block;
		
			border-width:
			1px;
		
			border-style:
			solid;
		}
		
	</style>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

	<div class="row">
   		<div class="col-2">
   			<div>
	   			<table class="table">
	   				<tr>
	   					<td>
	   						<a href="/shop/emp/goodsList.jsp" 
	          					class="nav-link active" aria-current="page">전체</a>
	   					</td>
	   					<td></td>
	   				</tr>
	   			<%
					for(HashMap m : categoryList) {
				%>
			          <tr>
			          	<td>
				          	<a class="nav-link" href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>"><%=(String)(m.get("category"))%>
				          		</a>
			          	</td>
			          	<td>
			          		<a class="nav-link" href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">(<%=(Integer)(m.get("cnt"))%>)
			          		</a>
			          	</td>
			          </tr>
			    <%
					}
				%>
	   			</table>
   			</div>
   		</div>
	<!-- 서브메뉴 카테고리별 상품리스트 -->
		<div class="col-10">
	
		<div>
		
		<%
				for(HashMap ms : selectGoodsList){
		%>
						<div class="bordered-div">
							<div><img alt="이미지" src="/shop/upload/<%=(String)(ms.get("filename"))%>" width="200" height ="200"></div>
							<div>카테고리: <%=(String)(ms.get("category")) %></div>
							<div>번호: <a href="/shop/emp/goodsListOne.jsp?goodsNo=<%=(Integer)(ms.get("goodsNo")) %>"><%=(String)(ms.get("goodsTitle")) %></a></div>
							<div>가격: <%=(Integer)(ms.get("goodsPrice")) %></div>
							<div>수량: <%=(Integer)(ms.get("goodsAmount")) %></div>
						</div>
					
		<%			 
				}
		%>
		</div>
		<div class="d-flex justify-content-center btn-group position-absolute bottom-0 start-50 translate-middle-x" role="group" aria-label="Basic example">
				<%
					if(currentPage > 1){
				%>
						  	<a href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">처음</a>
						  	<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">이전</a>
				<%
					}
					if(currentPage < lastPage){
				%>
						  	<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">다음</a>
						  	<a href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&startRow=<%=startRow%>&rowPerPage=<%=rowPerPage%>">마지막</a>
				<%
					} 
				%>
		</div>
	</div>
</body>
</html>