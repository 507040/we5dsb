<%@page import="model.dto.DTOPage"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.dto.DTOBoard"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String category = request.getParameter("c");
	ArrayList boardlist = null;
	if(category.equals("1")){
		boardlist = (ArrayList)request.getAttribute("blistA");//블로그 리스트 가져오기
	}else if(category.equals("2")){
		boardlist = (ArrayList)request.getAttribute("blistB");//블로그 리스트 가져오기
	}else if(category.equals("3")){
		boardlist = (ArrayList)request.getAttribute("blistC");//블로그 리스트 가져오기
	}	
	ArrayList pagelist = (ArrayList)request.getAttribute("page");
%>
<!DOCTYPE html>
<c:set value='<%=session.getAttribute("id") %>' var="masterId"/>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<c:set value='<%=request.getParameter("category")%>' var="category"/>
<jsp:include page="/include/topSearch.jsp"/>
<div class="mb-2"></div>
<div class="listBody">
	<div class="container">  
		<div class="board">
			<div class="category p-2">
			
			<div class="fir">
			<c:choose>
				<c:when test="${category eq 1}">
					<h5>카테고리a</h5>
				</c:when>
				<c:when test="${category eq 2 }">
					<h5>카테고리b</h5>
				</c:when>
				<c:when test="${category eq 3 }">
					<h5>카테고리c</h5>
				</c:when>
			</c:choose>
				
				<% 
					if(boardlist.size()>=1){
						for(int i=0;i<boardlist.size();i++){
						DTOBoard b = (DTOBoard)boardlist.get(i);
						
						String regDate = b.getRegDate();
	    				Date time=null;
	    				Date day_22=null;				
	
	    				//2일전 날짜
	    				Date today = new Date(); //오늘날짜
	    				Date day2 = new Date(today.getTime() - (long)(1000*60*60*24*2));//오늘 -2일
	    				SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd");
	    				String day_2 = bbb.format(day2);	            				
						day_22 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2);//2일 전
	    				
						time = new SimpleDateFormat("yyyy-MM-dd").parse(regDate);//게시물 등록일자
	    				
	    				String times= null;
	    				if(time.getTime()>=day_22.getTime()){//2일 내로 등록(신규글)
	    					times = "true";
	    				}else{//2일 보다 전에 등록
	    					times = "false";
	    				}
						
						String subject = b.getSubject();
						if(subject.length()<=20){
							subject= b.getSubject();
						}else{
							subject= subject.substring(0,20)+".....";
						}
						String FidThread= b.getFid()+b.getThread();
						
					%>	
					
					<c:set value="<%=times%>" var="time"/>
					<c:set value="<%=b.getGNS() %>" var="GNS"/>
					<div class="p-3" style="border-bottom: 1px solid #ddd">			
						<div>
							<a data-id="notice"><img style="width:50px;height:50px;border:0px;outline: none;"><%=b.getId()%></a>ㅣ<%=b.getRegDate() %>    
						</div>
						<div style="display:flex;flex-wrap: wrap;">
							<a href="/Myblog.do?list=<%=FidThread%>&bno=<%=b.getBno()%>&id=<%=b.getId()%>" data-master="<%=b.getId() %>" data-name="${GNS}" data-id="notice">
								<img class="col-3">							      
								<p class="text-break col-9">						
									<b><%=subject%>게시물</b>
									<c:if test="${GNS eq 'S'}">
           								<span style="color:gray;font-size:8px;">
           									<i class="bi bi-file-lock"></i>
           								</span>
           							</c:if>
           							<c:if test="${time==true }">
           								<span class="blinking" style="color:tomato;font-size:5px;">new</span>
           							</c:if><br>							
								<%=b.getComment()%>
							</a>
						</div>
						<p class="text-right text-primary mb-0"><a></a>
					</div> 
					<%}
				}else{%>
				
				<div class="col-12">
					<p class="text-center">게시물이 없습니다...</p>
				</div>
				
				<% }%>
			</div>
			
			<div class="col-12 pt-2">
			<table>
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
					<td class="text-right px-2" style="vertical-align: middle;align-items: center;">					
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
									<a href="/BloglistCategory.do?c=<%=request.getParameter("c") %>&search=<%=request.getParameter("search") %>&p=${prevPage}" class="btn btn-sm" data-page="${page}" style="vertical-align: middle;height:30px;border:1px solid #ddd;border-radius:5px;color:#007bff"><i class="bi bi-chevron-left"></i></a>						
								</c:otherwise>				
							</c:choose>				
							<c:forEach var="page" begin="${startPage}" step="1" end="${endPage}">
								<c:if test='${page != pagenum}'>								
									<a href="/BloglistCategory.do?c=<%=request.getParameter("c") %>&search=<%=request.getParameter("search") %>&p=${page}" id="pagingnum" class="btn btn-sm" data-page="${page}" style="color:black;"><c:out value="${page}"/></a>
								</c:if>
								<c:if test='${page == pagenum}'>								
									<a href="/BloglistCategory.do.pn?c=<%=request.getParameter("c") %>&search=<%=request.getParameter("search") %>&p=${page}" id="pagingnum" class="btn btn-sm" data-page="${page}" style="color:#007bff;"><c:out value="${page}"/></a>
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${next==true}">
									<span class="btn btn-sm" data-page="${page}" style="vertical-align: middle;height:30px;border:1px solid #ddd;border-radius:5px;color:black;cursor: default;" ><i class="bi bi-chevron-right"></i></span>
								</c:when>
								<c:otherwise>
									<a href="/BloglistCategory.do?c=<%=request.getParameter("c") %>&search=<%=request.getParameter("search") %>&p=${nextPage}" class="btn btn-sm" data-page="${page}" style="vertical-align: middle;height:30px;border:1px solid #ddd;border-radius:5px;color:#007bff"><i class="bi bi-chevron-right"></i></a>						
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
	  	  	<%}else{%>
	  	  		<tr><td>asd</td></tr>
	  	  	<%} %>
	  	  	</table>
			</div>
		</div>     
	</div>
</div>
<%@include file="/include/footer.jsp"%>
</body>
</html>