<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="SHeader.jsp"%>
<%@include file="CartHeader.jsp" %>
<%ArrayList cart =(ArrayList)request.getAttribute("clist"); %>
<c:set value="<%=cart%>" var="c"/>
<%if(session.getAttribute("id")==null){ %>
<script>
	alert("로그인 후 이용해 주세요");
	history.back();
</script>
<%} %>
<div class="col-9" style="margin: 0 auto;padding: 0;margin-bottom:30px;  ">
    <div class="selectPost">
        <div class="Sel_Ac"><a class="Select" href="#">국내배송상품(#)</a></div>
        <div class="Sel"><a class="Select" href="#">해외배송상품(#)</a></div>
    </div>

    <div class="Sel_Product my-1">
        <span>선택상품(#)</span>
    </div>

    <div class="cartTable">
        <table class="table table-hover text-center mb-0">
            <tr>
                <th></th>
                <th colspan="2">상품정보</th>
                <th>가격</th>
                <th>수량</th>
                <th>적립금</th>
                <th>배송구분</th>
                <th>배송비</th>
                <th>합계</th>
                <th>선택</th>
            </tr>
            <c:forEach items="${c}" var="c">
	            <tr>
	            	<!--상품정보-->
	                <td>
	                    <input type="checkbox">
	                </td>	                
	                <!-- 상품이미지 -->
	                <td>
	                    <img src="/resources/img/product/${c.img}" style="width:50px;height:50px">
	                </td>
	                <!-- 상품이름 -->
	                <td>
	                    ${c.name}
	                </td>
	                <!--가격-->
	                <td>
	                    <fmt:formatNumber value="${c.price}" pattern="#,###"/><br>
	                    <fmt:formatNumber value="${c.rePrice}" pattern="#,###"/>
	                </td>
	                <!--수량-->
	                <td>
	                    <input type="number" max="99" min="1" value="${c.cnt}">
	                </td>
	                <!--적립금-->
	                <td>
	                    (우수)#
	                </td>
	                <!--배송부근-->
	                <td>
	                    기본배송<br>
	                </td>
	                <!--배송비-->
	                <td>
	                    #
	                </td>
	                <!--합계-->
	                <td>
	                	<input type="text" name="sumprice" id="sumprice" value='${c.sumPrice}'>	                    
	                </td>
	                <!--선택-->
	                <td style="display: flex;flex-wrap:wrap">
	                    <input type="button" class="orderbtn" onclick="location.href='order.pn?Op=2'" value="주문하기" style="width:100%;margin-bottom: 3px;">
	                    <input type="button" class="deletebtn" value="삭제" style="width:100%">
	                </td>
	            </tr>
            </c:forEach>
        </table>
        <div class="cartfoot">
            <div style="width:100%;">
                <span style="font-weight: bold;">[기본배송]</span>
                <span style="font-size: 13px;align-items: center;">상품 구매금액:##,### - 할인금액 ##,### = <b style="font-size: 15px;">합계 : ##,###원</b></span>
            </div>
        </div>
    </div>
</div>
<%@include file="SFooter.jsp" %>
