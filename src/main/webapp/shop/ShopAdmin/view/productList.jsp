<%@page import="model.dto.DTOShop"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%ArrayList p = (ArrayList)request.getAttribute("productlist"); %>
<main role="main" class="col-9 ml-sm-auto col-10 px-4" style="min-height:100%;height: auto">
      <div class="d-flex justify-content-between flex-wrap flex-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">상품등록</h1>
      </div>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr class="text-center">
              <th></th>
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
	          		<td><input type="checkbox" name="check"></td>
	          		<td class="text-left"><%=d.getpId()%></td>
	          		<td><%=d.getpName()%></td>
	          		<td><%=session.getAttribute("nicname") %></td>
	          		<td class="text-right"><fmt:formatNumber value="<%=d.getpPrice()%>" pattern="#,###"/></td>
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
          </tbody>
        </table>
      </div>    
</main>
</div>
</div>
</body>
</html>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
   
    $(document).ready(function() {    	
    	var screenH=screen.height;
    	var screenW=screen.width;
    	$('#shopBody').css("height",screenH);
    	$('#shopBody').css("width",screenW);
    	$('#sidebarMenu').css("height",screenH);     
    	$('#nav').css("width",screenW);
    	
    	$("#files").on("change", handleImgFileSelect);
    });
</script>