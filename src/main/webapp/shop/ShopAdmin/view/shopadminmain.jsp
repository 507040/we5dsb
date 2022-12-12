<%@page import="model.dto.DTOShop"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%ArrayList p = (ArrayList)request.getAttribute("productlist"); %>    
    <main role="main" class="col-9 ml-sm-auto col-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">Dashboard</h1>
      </div>

      <canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>
	
      <h2>상품 관리</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr class="text-center">
              <th>no</th>              
              <th>PID</th>
              <th>상품이름</th>
              <th>판매자</th>
              <th>가격</th>
              <th>상태</th>
              <th>리뷰</th>
              <th>판매량</th>
              <th>총액</th>
            </tr>
          </thead>
          <tbody>     
          <%if(p!=null){
        	  for(int i=0;i<p.size();i++) {
          		DTOShop d = (DTOShop)p.get(i);%>
          		<tr class="text-center">
          			<td><%=i+1 %></td>	          		
	          		<td class="text-center"><a href="/productView.pn?pid=<%=d.getpId()%>" style="text-decoration-line:none;" target="_blank"><%=d.getpId()%></a></td>
	          		<td><a href="/productView.pn?pid=<%=d.getpId()%>" style="text-decoration-line:none;" target="_blank"><%=d.getpName()%></a></td>
	          		<td><a href="/ShopadminPage.pn" style="text-decoration-line:none;"><%=session.getAttribute("nicname") %></a></td>
	          		<td class="text-right"><fmt:formatNumber value="<%=d.getpPrice()%>" pattern="#,###"/>원</td>
	          		<td>orderSign</td>
	          		<td class="text-right">commentCnt</td>
	          		<td class="text-right"><%=d.getOrderCnt()%></td>
	          		<td class="text-right"><fmt:formatNumber value="<%=d.getSum()%>" pattern="#,###"/></td>
	          		
          		</tr>        
       		<%}
       		}else{%>
       			<tr>
       				<td colspan="9">등록 된 상품이 없습니다.</td>
       			</tr> 
       		<%} %>  
	       		<tr>
       				<td  class="text-right px-2" colspan="9"><a href="/Productadmin.pn">+더 보기</a></td>
       			</tr>      	    
          </tbody>
        </table>
      </div>
    </main>
  </div>
</div>
<%@include file="footer.jsp" %>
