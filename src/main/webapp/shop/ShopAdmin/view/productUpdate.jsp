<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<%ArrayList v=(ArrayList)request.getAttribute("Pview");
if(v==null){%>
	<script>
		alert("상품이 없습니다.");
		location.href="/SMain.pn";
	</script>
<%} %>
 <main role="main" class="col-9 ml-sm-auto col-10 px-4" style="min-height:100%;height: auto">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">상품수정</h1>
      </div>
      
      <div class="col-12 mb-3 p-2" style="display: flex;flex-wrap: nowrap;height: auto;">
           <div class="col-2"></div>
           <div class="col-8" style="border: 1px solid gray;border-radius: 10px;">
            <div class="container" >
            <div class="row" id="productupdate" style="align-items: center;">	            
	            <c:forEach items="<%=v %>" var="v">
	           	<c:set value="${v.pId}" var="pid"/>
	           	<c:set value="${v.category}" var="category"/>         
	                <div class="col-md-5 m-0 p-0">
	                     <img data-img="img" class="img col-12" id="img" src="/resources/img/product/${v.pImg}" style="heihgt:500px;object-fit:cover">
	                </div>		
	                <div class="col-md-7">
	                 <form id="pIfmt"  name="pIfmt" action="/productInsert.up" method="post">
	                  	<input type="hidden" id="file" name="file" alt="">
	                    <p><span style="">Pname&nbsp;&nbsp;</span><input name="Pname" value="${v.pName}" placeholder="상품명을 입력하세요">
	                    <p>pcontent<br><textarea id="content" name="content" placeholder="상품설명을 입력하세요">${v.pContent}</textarea>
	                    <p>분류
	                    
							<select id="categoryU" name="category" class="selectBoxForm">
								<option value="0" <c:if test="${category==0}">selected</c:if>>분류</option>
								<option value="1" <c:if test="${category==1}">selected</c:if>>자유</option>
								<option value="2" <c:if test="${category==2}">selected</c:if>>카테고리A</option>
								<option value="3" <c:if test="${category==3}">selected</c:if>>카테고리B</option>
							</select>
	                   	
	                    <p>가격:<input name="price" name="price" value="${v.pPrice}" placeholder="가격을 입력하세요">
	                    <p>판매자:${v.id }               
	                    <p>재고수:<input type="number" name="instork" value="${v.pInStork}" placeholder="수량을 입력하세요" min="1" >
	                    </form>        	                                    
		                    <p>이미지등록:<input type="file" id="files" name="files"></p>
		                    <a class="btn btn-outline-info" onclick=" fn_submit();">수정 &raquo;</a>		                    					            
	                </div>
	                </c:forEach>
            </div>    	
        </div>
         </div>
          <div class="col-2"></div>
           
        </div>
        <div class="col-1"></div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="/shop/ShopAdmin/assets/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    //이미지 미리보기
    var sel_file;
 
    $(document).ready(function() {    	
    	var screenH=screen.height;
    	var screenW=screen.width;
    	$('#shopBody').css("height",screenH);
    	$('#shopBody').css("width",screenW);
    	$('#sidebarMenu').css("height",screenH);     
    	$('#nav').css("width",screenW);
    	
    	$("#files").on("change", handleImgFileSelect);
    });
 
    function handleImgFileSelect(e) {   	
    	var ab = $('#file').val();
		alert(ab);
		 var url = "http://localhost:8080//productUpdate.up";
		$.ajax({
            type: "POST",
            url: url,
            dataType: "text",
            data: {                
                GNS: "N"
            },
            success: function(data) {

            },
            error: function(request, status, error) {

            }

        }); 	
    	
    	var File = $("#files").val();
    	var steste=File.length;
		var StrFile=File.substring(12,steste);
		$('#file').val(StrFile);		
    	
        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
 
        var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
 
        filesArr.forEach(function(f) {
            if (!f.type.match(reg)) {
                alert("확장자는 이미지 확장자만 가능합니다.");
                return;
            }
 
            sel_file = f;
 
            var reader = new FileReader();
            reader.onload = function(e) {            	
                $("#img").attr("src", e.target.result);
            }
            reader.readAsDataURL(f);
        });
    }
</script>
</body>
</html>
<!-- --------------------------------------------------------------------------------------------------------------------------------------------- -->


