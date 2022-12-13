<%@page import="model.dto.DTOShop"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String URI = request.getRequestURI();
int urllen = URI.length();
int cxvz= URI.lastIndexOf("/")+1;
String accheck = URI.substring(cxvz,urllen);    

ArrayList p = (ArrayList)request.getAttribute("productlist"); %>
    


<!doctype html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>shop관리자</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/dashboard/">

    

    <!-- Bootstrap core CSS -->
	<link href="/shop/ShopAdmin/assets/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
	<link rel="stylesheet" href="/resources/css/basic.css">



    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      .nav-link{
      color: gray;
       }
       #av{
       color:#007bff
       }
       .chart-area {
  display: flex; 
}
.chart-area > div {
  width: 50%;
}
.chart-info {
  padding:0 0 0 45px;
}

@media screen and (max-width: 1024.98px) {
  .chart-area {
    display: block;
  }
  .chart-area > div {
    width: auto;
  }
}
    </style>

    
    <!-- Custom styles for this template -->    
  </head>
  <body id="shopBody">
    
<nav class="navbar navbar-dark sticky-top bg-dark flex-nowrap p-0 shadow" id="nav">
  <a class="navbar-brand col-3 col-2 mr-0 px-3" href="/ShopadminPage.pn"><%=session.getAttribute("nicname")%></a>  
  <ul class="navbar-nav px-3">  	
    <li class="nav-item text-nowrap" style="display:flex;flex-wrap: nowrap;">
     <!-- session.id/session_lev check -->
      <span><a class="nav-link" href="/SMain.pn">Home</a></span>
      <span><a class="nav-link">&nbsp;&nbsp;&nbsp;&nbsp;</a></span>
      <span><a class="nav-link" href='/logout?URI=/'>Sign out</a></span>
    </li>
  </ul>
</nav>
<div class="container-fluid">
  <div class="row" >
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
      <div class="sidebar-sticky pt-3">
        <ul class="nav flex-column">       

          <li class="nav-item">
            <a class="nav-link" href="/ShopadminPage.pn" <%if(accheck.equals("shopadminmain.jsp")){%>id="av"<%}%>>
              <span style="width: 24px;height: 24px;vertical-align: bottom;color: gray;font-size: 17px;margin-right: 2px;">
            	<i class="bi bi-house" <%if(accheck.equals("shopadminmain.jsp")){%>id="av"<%}%>></i>&nbsp;
            </span>
              Main
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
              <span style="width: 24px;height: 24px;vertical-align: bottom;color: gray;font-size: 17px;margin-right: 2px;">
            	<i class="bi bi-clipboard2"></i>&nbsp;
            </span>
              주문관리
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/Productadmin.pn" <%if(accheck.equals("productList.jsp")){%>id="av"<%}%>> 
              <span style="width: 24px;height: 24px;vertical-align: bottom;color: gray;font-size: 17px;margin-right: 2px;">
            	<i class="bi bi-cart" <%if(accheck.equals("productList.jsp")){%>id="av"<%}%>></i>&nbsp;
            </span>
              상품관리
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
              <span style="width: 24px;height: 24px;vertical-align: bottom;color: gray;font-size: 17px;margin-right: 2px;">
            	<i class="bi bi-people"></i>&nbsp;
            </span>
              고객관리
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/Product.pn" <%if(accheck.equals("productInsert.jsp")||accheck.equals("productUpdate.jsp")){%>id="av"<%}%>>
              <span style="width: 24px;height: 24px;vertical-align: bottom;color: gray;font-size: 17px;margin-right: 2px;">
            	<i class="bi bi-bag-plus" <%if(accheck.equals("productInsert.jsp")||accheck.equals("productUpdate.jsp")){%>id="av"<%}%>></i>&nbsp;
            </span>
              <span>상품등록</span>
            </a>
          </li>                             
        </ul>       
      </div>
    </nav>
    
    
    
    
    

    <main role="main" class="col-9 ml-sm-auto col-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">Dashboard</h1>
      </div>
      <div class="chart-area">
  <div class="chart">
    <div id="columnchart_material" style="width: 100%; height: 300px;"></div>
  </div>
  </div>

	
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

<footer> 	
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="/shop/ShopAdmin//assets/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js"></script>    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
     
    function drawChart() {
        var data = google.visualization.arrayToDataTable([
            ['Pid', '주문량', '판매금액'],
            ['2014', 1000, 400],
            ['2015', 1170, 460],
            ['2016', 660, 1120],
            ['2017', 1030, 540]
        ]);
     
        var options = {
            chart: {
            title: '수익 순위',            
            }
        };
     
        var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
     
        chart.draw(data, google.charts.Bar.convertOptions(options));
    }
    </script>
</footer>
</body>
</html>
