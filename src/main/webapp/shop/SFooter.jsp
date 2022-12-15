<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

</body>
<footer>
    footer
</footer>
<script>
 $(document).ready(function(){//footer위치
	 var uri = "<%=URI%>";
	 if(uri=="/shop/cartMains.jsp"){//장바구니 페이지 일 때
		 $.ajax({
				type : 'POST',//전송방식
				url : '/productCntupdate.pn',//실행하려는 url지정
				dataType : 'json',//가져오는 데이터 형태
				data : ({
					  "pid" : no,
				      "cnt" : name,				      
				    }),
				success : function(data) {
					//json.stringify?
					//데이터를 문자형으로 변환
					queryObject = eval('(' + JSON.stringify(data) + ')');
					queryObjectLen = queryObject.inbodyDetails.length;
				},
				error : function(xhr, type) {
					alert('server error occoured:'+xhr)
				}
		});
	 }
 	//footer margin
	var footerhei = $('warpper').outerHeight(true);
	$('.footer').css('margin-top',footerhei);
	
	var sumFunction=function(){
		
	}
});
 </script>
</html>
