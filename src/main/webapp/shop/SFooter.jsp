<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

</body>
<footer>
    footer
</footer>
<script>
 $(document).ready(function(){//footer위치
	 var uri = "<%=URI%>";
	 if(uri=="/shop/cartMain.jsp"){//장바구니 페이지 일 때
		 $('input[type="number"]').change(function(){
			 var qtyUp = $(this);//현재 객체의 값을 가져와 변수에 대입
			 var table = qtyUp.parent().parent().parent();//현재행
			 var tr = qtyUp.parent().parent();//현재행
			 var td = tr.children();//현재행 td 정보
			 var rowNum = tr.index() + 1;//현재 작업중인 행번호			 
			 var text = Number(td.eq(8).text());
			 var cntNum= Number($(this).val());
			 var cal = text*cntNum;
			 td.eq(8).text(cal);			 
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
