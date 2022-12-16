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
		resultView();//수량변경 전	 
		var ttr = ($('#table > tbody tr').length)-1;
		$('#itemCnt').text(ttr);
		$('#itemCntSS').text(0);
		$('input[type="number"]').change(function(){//수량변경
			var qtyUp = $(this);//현재 객체의 값을 가져와 변수에 대입
			var table = qtyUp.parent().parent().parent();//현재행
			var tr = qtyUp.parent().parent();//현재행
			var td = tr.children();//현재행 td 정보
			var rowNum = tr.index() + 1;//현재 작업중인 행번호			 
			var text = Number(td.eq(8).text());//합계 값
			var cntNum= Number($(this).val());//수량수			 
			var price=Number(td.eq(3).children($('input[id="sumPrice"]')).val());//상품가격
			var cal = price*cntNum;//수량 변경 후 합계
			var fomet = $.number(cal);//합계 number fomet 변셩				 
			td.eq(8).text(fomet);//합계 view				 
		});
		
		$('.Sel').on('click',function(){
			$('.table').hide();
			$('#shippingType').text("[해외배송]");
			$('#sumResult').text(0);
			$('#saleResult').text(0);
			$('#priceResult').text(0);
		});
		
		$('.Sel_Ac').on('click',function(){
			$('.table').show();
			$('#shippingType').text("[기본배송]");
			$('#sumResult').text(sumResult);
			$('#saleResult').text(saleResult);
			$('#priceResult').text(priceResult);	
		});
	
	}
	
 	//footer margin
	var footerhei = $('warpper').outerHeight(true);
	$('.footer').css('margin-top',footerhei);	
	
function resultView(){
	var sumarray = new Array();
	var salearray = new Array();
	var pricearray = new Array();				 
	var ttr = $('#table > tbody tr').length;		
 	
 	for (var i = 1; i < ttr;i++) {	
 		sumarray[ttr];
 		salearray[ttr];
 		pricearray[ttr];
 		var td4 = $('#table tbody tr').eq(i).children().eq(4);
 		var td5 = $('#table tbody tr').eq(i).children().eq(5);
 		//alert(td4.children($('#salePrice')).val());
		var eachtd = $('#table tbody tr').eq(i).children().eq(8);//각 행의 합계
		var sumNumbertd = Number(eachtd.text());//합계 type number 변경
		var fometdefault = $.number(sumNumbertd);//sumNumbertd number fomet 변경
		eachtd.children($('#sumPrice')).val(sumNumbertd);//합계 input value 변경
		eachtd.text(fometdefault)//합계 view
		var sumPrice = sumNumbertd;//변경된 합계 값
		//alert("sum:"+sumPrice);
		var salePrice = Number(td4.children($('#salePrice')).val());//세일금액
		//alert("sale:"+salePrice);
		var Price = Number(td5.children($('input[id="Price"]')).val());//세일금액
		//alert("Price:"+Price);
		sumarray.push(sumPrice);//합계 array 추가
		salearray.push(salePrice);//sale array 추가
		pricearray.push(Price);
		//alert(fometdefault);
		//alert(asfdv)		 		
 	}
 	console.log(sumarray);
 	console.log(salearray);
 	console.log(pricearray);
 	
 	var sumResult = 0;
 	var saleResult = 0;	 
 	var priceResult = 0;	 
 	for(var i=0;i<sumarray.length;i++){	 	
 		var sumnum = sumarray[i];
 		var salenum = salearray[i];
 		var pricenum = pricearray[i];
 		sumResult += Number(sumnum);
 		saleResult += Number(salenum);
 		priceResult += Number(pricenum);
	}
 	//alert(sumResult+"/"+saleResult+"/"+priceResult);
 	$('#sumResult').text(sumResult);
 	$('#saleResult').text(saleResult);
 	$('#priceResult').text(priceResult);
}	
	
});
 </script>
</html>
