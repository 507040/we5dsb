<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String URI = request.getRequestURI();
int urllen = URI.length();
int cxvz= URI.lastIndexOf("/")+1;
String accheck = URI.substring(cxvz,urllen);    
%>
    


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