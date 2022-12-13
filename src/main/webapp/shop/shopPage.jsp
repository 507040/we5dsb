<%@page import="model.dto.DTOShopPage"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/SHeader.jsp" %>
<%
ArrayList slist = (ArrayList)request.getAttribute("SList");
DTOShopPage sp = (DTOShopPage)slist.get(0);
String id = sp.getId();
String content = sp.getCentent();
int vister = sp.getVister();
int favor = sp.getFavorites();
%>
<c:set value="<%=slist %>" var="list"/>
<div class="col-12 row m-0 p-0" style="margin-top: 10px;">
     <div class="col-1" style="" id="lside">
     </div>     
     <div class="col-10" style=" " id="main">
         <div class="col-12 mb-3 p-2" style="display: flex;flex-wrap:wrap;height: auto;">
             <div class="container">
	             <div class="row">	             	
	                    <div style="border-bottom: 1px solid black;" class="col-12 p-2 mb-3">
	                        <img class="img" style="width:100%;height:130px;object-fit: fill;" src="‪D:\java\project\src\main\webapp\resources\img\1.jpg">
	                        <p class="text-center mb-1" style="font-weight: bold"><%=id %></p>
	                        <p class="mb-1 text-center"><%=content %></p>
	                        <p class="text-center">방문자 : <%=vister %>&nbsp;&nbsp;&nbsp;즐겨찾기 : <%=favor %></p>
	                    </div> 
	                    <c:if test="${list!=null }">
		                    <c:forEach items="${list}" var="s">										                    	
			                    <div class="col-4 mb-2" style="display: flex;flex-wrap: nowrap;border-radius: 5px">			                    
			                        <span class="col-4">
			                            <img class="img" src="/resources/img/product/${s.pimg}" style="width:100%;height:150px">
			                        </span>
			                        <span class="col-8" >
				                        <a href="/productView.pn?pid=${s.pid}" id="spagea" target="_blank">
				                            <p>상품명 : ${s.pname}</p>
				                            <p>가격 : ${s.price}</p>			                            
				                            <p>상품설명 : 
					                            <c:choose>
													<c:when test="${fn:length(s.pcontent) > 11}">
														<c:out value="${fn:substring(s.pcontent,0,10)}"/>....
													</c:when>
													<c:otherwise>
														<c:out value="${s.pcontent}"/>
													</c:otherwise> 
												</c:choose>
											</p>
				                            <p>리뷰 : revierCnt / 주문수 : ${s.ordercnt}</p>
			                            </a>
			                        </span>
			                    </div>
		                    </c:forEach>
	                    </c:if>
	                    <c:if test="${list==null }">
		                    <div class="col-4" style="display: flex;flex-wrap: nowrap">		                        
		                        <span class="col-12" >
		                            <p>상품이 없습니다.</p>
		                        </span>
		                    </div>
	                    </c:if>
	             </div>                                                    
             </div>                       	
         </div>            
     </div>

	<div class="col-1 m-0 p-0" style="" id="rside">
	</div>
</div>
