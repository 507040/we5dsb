<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/SHeader.jsp" %>
<%ArrayList v=(ArrayList)request.getAttribute("Pview");
if(v==null){%>
	<script>
		alert("상품이 없습니다.");
		location.href="/SMain.pn";
	</script>
<%} %>
<c:set value='<%=session.getAttribute("level") %>' var="lev"/>
<c:if test="${lev>8}">
	<c:set value="true" var="level"/>
</c:if>


<div class="col-12 row m-0 p-0">
    <div class="col-2" style="" id="lside">
    </div>
    
    <div class="col-8" style="margin-top: 100px" id="main">
        <div class="col-12 mb-3 p-2" style="display: flex;flex-wrap: nowrap;height: auto;border: 1px solid gray;border-radius: 10px;">
            <div class="container">
            <div class="row">
           	<c:forEach items="<%=v %>" var="v">
           	<c:set value="${v.pId}" var="pid"/>           	
                <div class="col-md-5 m-0 p-0" >
                    <img class="img col-12" src="/resources/img/product/${v.pImg}" style="object-fit:cover">
                </div>		
                <div class="col-md-7">
                
                	<c:set value="${v.category}" var="category" />
                    <h3><c:out value="${v.pName }"/></h3>
                    <p><c:out value="${v.pContent }"/>                    
                    <p><b>가격</b>:<span style="font-weight: bold"><fmt:formatNumber value="${v.pPrice}" pattern="#,###"/></span>
                    <p><b>판매자:</b><a href="/ShopPage.pn?owner=${v.id}"><c:out value="${v.id}"/></a>
                    <p><b>분류:</b>
	                    <c:if test='${category==1}'>자유</c:if>
	                    <c:if test='${category==2}'>카테고리A</c:if>
	                    <c:if test='${category==3}'>카테고리B</c:if>
                    <p><b>재고수:</b><c:out value="${v.pInStork}"/>
                    <p>                   
           
                   <a class="btn btn-outline-info btn-sm" onclick="">상품목록</a>
                   <a class="btn btn-outline-info btn-sm" onclick="">장바구니</a>
                   <a class="btn btn-outline-info btn-sm" onclick="">상품구매</a>
                   <c:if test="${level eq true }">
	                   <form id="update" name="update" action="/productUpdate.pn" method="post">
	     	         		<input type="hidden" value="${pid}" name="pid" id="pid">
	                   		<a class="btn btn-outline-secondary btn-sm" onclick="document.update.submit();">상품수정</a>
	                   </form>
                   </c:if>                                     
                </div>
           	</c:forEach> 
            </div>    	
        </div>
           
        </div>
    </div>


    <div class="col-2 m-0 p-0" style="" id="rside">
     </div>
</div>
</body>
</html>