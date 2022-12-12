<%@page import="java.util.ArrayList"%>
<%@page import="model.dto.DTOShop"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
ArrayList chart = (ArrayList)request.getAttribute("Chart");
%>
<c:set value="<%=chart %>" var="chart"/>
    
<footer> 	
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="/shop/ShopAdmin//assets/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>    
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
    <script>
    
    (function () {
    	  // Graphs
    	  var ctx = document.getElementById('myChart')
    	  // eslint-disable-next-line no-unused-vars
    	  var myChart = new Chart(ctx, {
    	    type: 'line',
    	    data: {
    	      labels: [
    	    	 <%for(int i=0;i<chart.size();i++){
    	    		 DTOShop d = (DTOShop)chart.get(i);%>
    	    		 <%if(i == chart.size()-1){%>
    	    		 '<%=d.getpName()%>'
    	    		 <%}else{%>
    	    		 '<%=d.getpName()%>',
    	    		 <%}%>
    	    	 <%}%>
    	      ],
    	      datasets: [{
    	        data: [
    	        	<%for(int i=0;i<chart.size();i++){
       	    		 DTOShop d = (DTOShop)chart.get(i);%>
       	    		 <%if(i == chart.size()-1){%>
       	    		 '<%=d.getSum()%>'
       	    		 <%}else{%>
       	    		 '<%=d.getSum()%>',   
       	    		 <%}%>
       	    	 <%}%>
    	        ],
    	        lineTension: 0,
    	        backgroundColor: 'transparent',
    	        borderColor: '#007bff',
    	        borderWidth: 4,
    	        pointBackgroundColor: '#007bff'
    	      }]
    	    },
    	    options: {
    	      scales: {
    	        yAxes: [{
    	          ticks: {
    	            beginAtZero: false
    	          }
    	        }]
    	      },
    	      legend: {
    	        display: false
    	      }
    	    }
    	  })
    	})
    </script>
	
</footer>
</body>
</html>