<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/SHeader.jsp" %>
<%
ArrayList cnt = (ArrayList)request.getAttribute("plOrdercnt");
ArrayList date = (ArrayList)request.getAttribute("plregDate");
ArrayList sale = (ArrayList)request.getAttribute("plSale");
%>


<main>
    <div class="col-12 row m-0 p-0">
        <div class="col-1" id="lside">
        </div>

        <div class="col-9" id="main">

            <div class="col-12 my-3">
                <p>인기상품</p>                
                <div class="col-12" style="display: flex;justify-content: space-around;border-radius: 5px;border:1px solid #bbb">
	                <c:forEach items="<%=cnt %>" var="c"> 
	                <c:set value="${c.sale}" var="csale"/>	                
	                    <div class="item-sell col-2" >	                    
	                        <img src="/resources/img/product/${c.pImg}" class="img img-tumbnail p-1 mb-2" style="width:100%;height:200px;">
	                        <a><br>${c.pName}<br></a><a class="alt" href="/productView.pn?pid=${c.pId}" target="_blank">
	                        <c:if test="${csale != 0 }">
	                        	<span style="text-decoration: line-through;color:gray;font-size: 12px;">${c.pPrice}원</span>&nbsp;&nbsp;<fmt:formatNumber value="${c.rePrice}" pattern="#"/>원<br>
	                        </c:if>
	                        <c:if test="${csale == 0 }">
	                        	<fmt:formatNumber value="${c.pPrice}" pattern="#"/>원<br>
	                        </c:if>
	                        ${c.pContent}</a>
	                    </div>
	                </c:forEach>
                </div>                
            </div>

            <div class="col-12 mb-3">
                <p>신상품</p>
                <div class="col-12" style="display: flex;justify-content: space-around;border-radius: 5px;border:1px solid #bbb">
                    <c:forEach items="<%=date %>" var="d">
                    <c:set value="${d.sale}" var="dsale"/>	    
	                    <div class="item-sell col-2">
	                        <img src="/resources/img/product/${d.pImg}" class="img img-tumbnail p-1 mb-2" style="width:100%;height:200px;">
	                        <a><br>${d.pName}<br></a><a class="alt" href="/productView.pn?pid=${d.pId}" target="_blank">
	                        <c:if test="${dsale != 0 }">
	                        	<span style="text-decoration: line-through;color:gray;font-size: 12px;">${d.pPrice}원</span>&nbsp;&nbsp;<fmt:formatNumber value="${d.rePrice}" pattern="#"/>원<br>
	                        </c:if>
	                        <c:if test="${dsale == 0 }">
	                        	<fmt:formatNumber value="${d.pPrice}" pattern="#"/>원<br>
	                        </c:if>
	                        ${d.pContent}</a>
	                    </div>
	                </c:forEach>                   
                </div>
            </div>

            <div class="col-12 mb-3">
                <p>세일상품</p>
                <div class="col-12" style="display: flex;justify-content: space-around;border-radius: 5px;border:1px solid #bbb">
                    <c:forEach items="<%=sale %>" var="s"> 
                    <c:set value="${s.sale}" var="ssale"/>
	                    <div class="item-sell col-2">
	                    	<c:if test="${ssale != 0 }">
	                    		<div class="text-center" style="position:absolute;border-radius: 50px;background-color:tomato; width:30px;height: 35px;z-index: 1000;top: 5px;left:18px;opacity: 80%">${s.sale}%</div>
	                    	</c:if>
	                        <img src="/resources/img/product/${s.pImg}" class="img img-tumbnail p-1 mb-2" style="width:100%;height:200px;">
	                        <a><br>${s.pName}<br></a><a class="alt" href="/productView.pn?pid=${s.pId}" target="_blank">
	                        <c:if test="${ssale != 0 }">
	                        	<span style="text-decoration: line-through;color:gray;font-size: 12px;">${s.pPrice}원</span>&nbsp;&nbsp;<fmt:formatNumber value="${s.rePrice}" pattern="#"/>원<br>
	                        </c:if>
	                        <c:if test="${ssale == 0 }">
	                        	<fmt:formatNumber value="${s.pPrice}" pattern="#"/>원<br>
	                        </c:if>
	                        ${s.pContent}</a>
	                    </div>
	                </c:forEach>                 
                </div>
            </div>


        </div>


        <div class="col-2 m-0 p-0 pr-4" id="rside">
            <div class="rside col-12 p-0 m-0" style="display: flex;flex-wrap: wrap">

                <div class="col-12 text-center  p-0 m-0 mb-2" style="border:1px solid #bbb;border-radius: 5px">
                    <span><b>최근 본 상품</b></span>
                    <div class="col-12 p-0 m-0"><a><img class="img"></a></div>
                </div>

                <div class="col-12 text-center p-0 m-0 mb-2" style="border:1px solid #bbb;border-radius: 5px">
                    <span><b>특가</b></span>
                    <div class="col-12 p-0 m-0">
                        <div class="block_rside">
                            <ul id="ticker_rside">
                                <li><a href="#"><img src="/resources/img/고양이.jpg"><br>1</a></li>
                                <li><a href="#"><img src="/resources/img/dano.jpg"><br>2</a></li>
                                <li><a href="#"><img src="/resources/img/고양이.jpg"><br>3</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-12 text-center p-0 m-0 mb-2" style="border:1px solid #bbb;border-radius: 5px">
                    <span><b>소식</b></span>
                    <div class="col-12 p-0 m-0">
                        <div class="block_brand">
                            <ul id="ticker_brand">
                                <li><a href="#"><img src="/resources/img/고양이.jpg"><br>1</a></li>
                                <li><a href="#"><img src="/resources/img/dano.jpg"><br>2</a></li>
                                <li><a href="#"><img src="/resources/img/고양이.jpg"><br>3</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-12 text-center p-0 m-0 mb-2" style="display: flex;flex-wrap: wrap;justify-content: space-around;border:1px solid #bbb;border-radius: 5px">
                    <span class="col-12 py-2" style="border-bottom:1px solid #bbb;align-items: center;vertical-align: middle;"><b style="font-family:'고딕'">신상품</b></span>
                    <div class="col-12 p-2 m-0" style="display: flex;flex-wrap: wrap;justify-content: space-around;">
                    	<c:forEach items="<%=date %>" var="d">                    
	                    	<span class="col-6 pb-2 "><a><img class="img img-tumbnail p-0 m-0" style="height:100px;width:100%;" src="/resources/img/product/${d.pImg}" ><br>이름:${d.pName}<br>가격${d.pPrice}원</a></span>	                    
	                	</c:forEach>
	                </div>
                </div>
            </div>
        </div>
    </div>
</main>