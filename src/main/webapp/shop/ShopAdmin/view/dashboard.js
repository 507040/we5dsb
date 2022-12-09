/* globals Chart:false, feather:false */

(function () {
  'use strict'

  feather.replace()

  // Graphs
  var ctx = document.getElementById('myChart')
  // eslint-disable-next-line no-unused-vars
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: [
    	    	 <%for(int i=0;i<chart.size();i++){
    	    		 DTOShop d = (DTOShop)chart.get(i);%>
    	    		 <%if(chart.size()==10){%>
    	    		 '<%=d.getpName()%>'
    	    		 <%}%>
    	    		 '<%=d.getpName()%>',   	    		 
    	    	 <%}%>
    	      ],
    	      datasets: [{
    	        data: [
    	        	<%for(int i=0;i<chart.size();i++){
       	    		 DTOShop d = (DTOShop)chart.get(i);%>
       	    		 <%if(chart.size()==10){%>
       	    		 '<%=d.getSum()%>'
       	    		 <%}%>
       	    		 '<%=d.getSum()%>',   	    		 
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
