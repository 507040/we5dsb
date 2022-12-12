<%@page import="java.io.Console"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="org.apache.catalina.webresources.Cache"%>
<%@page import="model.dto.DTOPage"%>
<%@page import="model.dto.DTOShop"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%
	ArrayList p = (ArrayList)request.getAttribute("productlist");
	ArrayList pagelist = (ArrayList)request.getAttribute("page");
%>
<main role="main" class="col-9 ml-sm-auto col-10 px-4" style="min-height:100%;height: auto">
      <div class="d-flex justify-content-between flex-wrap flex-nowrap align-items-center pt-3 pb-2 mb-3">
          <h1 class="h2">상품 관리</h1>
      </div>
      <div class="table-responsive">
       <form id="checkbox" name="checkbox" action="/AdminProductDelete.pn" method="post">
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
	          <%if(p!=null){%>
	          	         
	        	  <%for(int i=0;i<p.size();i++) {
	          		DTOShop d = (DTOShop)p.get(i);%>
	          		<tr class="text-center">	       
	          		   		
		          		<td><input type="checkbox" id="check" name="check" value="<%=d.getpId()%>"></td>
		          		<td class="text-center"><a href="/productView.pn?pid=<%=d.getpId()%>" style="text-decoration-line:none;" target="_blank"><%=d.getpId()%></a></td>
		          		<td><a href="/productView.pn?pid=<%=d.getpId()%>" style="text-decoration-line:none;" target="_blank"><%=d.getpName()%></a></td>
		          		<td><a href="/ShopadminPage.pn" style="text-decoration-line:none;"><%=session.getAttribute("nicname") %></a></td>
		          		<td class="text-right"><fmt:formatNumber value="<%=d.getpPrice()%>" pattern="#,###"/>원</td>
		          		<td>orderSign</td>
		          		<td class="text-right">commentCnt</td>
		          		<td class="text-right"><%=d.getOrderCnt()%></td>
		          		<td class="text-right"><fmt:formatNumber value="<%=d.getSum()%>" pattern="#,###"/></td>
	          		</tr>          		         		
	       		<%}%>
	       		
	       		<%}else{%>
	       			<tr>
	       				<td colspan="9">등록 된 상품이 없습니다.</td>
	       			</tr> 
	       		<%} %>
       		
       		         
       		<%
			if(pagelist!=null){
				DTOPage pg = (DTOPage)pagelist.get(0);
				int pageNum = 0;
				try{
					String asd = request.getParameter("p");
					if(asd!=null){
						pageNum = Integer.parseInt(asd);
					}else{
						pageNum=1;
					}					
				}catch(Exception e){
					e.printStackTrace();					
				}			
			%>			
				<tr>
					<td class="text-right px-2" style="vertical-align: middle;align-items: center;" colspan="9">					
						<c:set value="<%=pg.getStartPage() %>" var="startPage"/>			
						<c:set value="<%=pg.getEndpage()%>" var="endPage"/>
						<c:set value="<%=pg.isPrev() %>" var="prev"/>
						<c:set value="<%=pg.isNext() %>" var="next"/>
						<c:set value="<%=pg.getTotal() %>" var = "total"/>			
						<c:set value="<%=pageNum-1 %>" var="prevPage"/>
						<c:set value="<%=pageNum+1 %>" var="nextPage"/>
						<c:set value="<%=pageNum %>" var="pagenum"/>
						<c:if test="${endPage != 1}">				
							<c:choose>
								<c:when test="${prev==true}">
									<span class="btn btn-sm" data-page="${page}" style="vertical-align: middle;height:30px;border:1px solid #ddd;border-radius:5px;color:black;cursor: default;" ><i class="bi bi-chevron-left"></i></span>
								</c:when>
								<c:otherwise>
									<a href="/Productadmin.pn?p=${prevPage}" class="btn btn-sm" data-page="${page}" style="vertical-align: middle;height:30px;border:1px solid #ddd;border-radius:5px;color:#007bff"><i class="bi bi-chevron-left"></i></a>						
								</c:otherwise>				
							</c:choose>				
							<c:forEach var="page" begin="${startPage}" step="1" end="${endPage}">
								<c:if test='${page != pagenum}'>								
									<a href="/Productadmin.pn?p=${page}" id="pagingnum" class="btn btn-sm" data-page="${page}" style="color:black;"><c:out value="${page}"/></a>
								</c:if>
								<c:if test='${page == pagenum}'>								
									<a href="/Productadmin.pn?p=${page}" id="pagingnum" class="btn btn-sm" data-page="${page}" style="color:#007bff;"><c:out value="${page}"/></a>
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${next==true}">
									<span class="btn btn-sm" data-page="${page}" style="vertical-align: middle;height:30px;border:1px solid #ddd;border-radius:5px;color:black;cursor: default;" ><i class="bi bi-chevron-right"></i></span>
								</c:when>
								<c:otherwise>
									<a href="/Productadmin.pn?p=${nextPage}" class="btn btn-sm" data-page="${page}" style="vertical-align: middle;height:30px;border:1px solid #ddd;border-radius:5px;color:#007bff"><i class="bi bi-chevron-right"></i></a>						
								</c:otherwise>				
							</c:choose>
						</c:if>
						<c:forEach var="page" begin="${startPage}" step="1" end="${endPage}">
							<c:if test="${endPage == 1}">
								<a id="pagingnum" class="btn btn-sm" data-page="${page}" style="color:#007bff;cursor: default;"><c:out value="${page}"/></a>
							</c:if>
						</c:forEach>
					</td>
		  	  	</tr>  
	  	  	<%} %>
	  	  	<tr>
	  	  		<td class="text-right" colspan="9">
	  	  			<a class="btn btn-sm btn-outline-danger" onclick="document.checkbox.submit();">삭제</a>	  	  		
	  	  		</td>
	  	  	</tr>
          </tbody>
        </table>
        </form>        
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
    });
</script>