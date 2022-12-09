<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
    <main role="main" class="col-9 ml-sm-auto col-10 px-4" style="min-height:100%;height: auto">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">상품등록</h1>
      </div>
      
      <div class="col-12 mb-3 p-2" style="display: flex;flex-wrap: nowrap;height: auto;">
           <div class="col-2"></div>
           <div class="col-8" style="border: 1px solid gray;border-radius: 10px;">
            <div class="container" >
            <div class="row" id="productupdate" style="align-items: center;">
                <div class="col-5 m-0 p-0">
                    <img style="width:100%;height:100%" id="img">
                </div>		
                <div class="col-7">
                <form id="fmt" name="fmt" action="/insertProduct.pn" method="post">
                <input type="hidden" id="file" name="file" alt="">
                    <p><span style="">Pname&nbsp;&nbsp;</span><input name="Pname" placeholder="상품명을 입력하세요">
                    <p>pcontent<br><textarea id="content" name="content" placeholder="상품설명을 입력하세요"></textarea>
                    <p>분류
                    
						<select id="categoryU" name="category" class="selectBoxForm">
							<option value="0" >분류</option>
							<option value="1">자유</option>
							<option value="2">카테고리A</option>
							<option value="3">카테고리B</option>
						</select>
                   	
                    <p>가격:<input type="text" id="price" name="price" placeholder="가격을 입력하세요">
                    <p class="cellid">판매자:<%=session.getAttribute("nicname") %>
                    <p>재고수:<input type="number" name="instork" placeholder="수량을 입력하세요">
                    
                </form>
                	<p>
                		<label for="file1">이미지등록:</label> 
	                	<input type="file" id="files" name="files">	                	
                	</p>
                    <a class="btn btn-outline-info" onclick="fn_submit();" >등록 &raquo;</a>
                    <a href="./products.jsp" class="btn btn-outline-secondary">취소 &raquo;</a>					                    
                </div>
            </div>    	
        </div>
         </div>
          <div class="col-2"></div>
           
        </div>
        <div class="col-1"></div>
    </main>
  </div>
</div>

<!-- --------------------------------------------------------------------------------------------------------------------------------------------- -->
<footer>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    <script src="/shop/ShopAdmin/assets/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    //이미지 미리보기
    var sel_file;
 
    $(document).ready(function() {
    	
    	var screenH=screen.height;
    	$('#shopBody').css("height",screenH);
    	$('#sidebarMenu').css("height",screenH);
        $("#files").on("change", handleImgFileSelect);        
    });
 
    function handleImgFileSelect(e) {   	
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
    
<script>
//파일 업로드
function fn_submit(){
        
        var form = new FormData();
        form.append("files", $("#files")[0].files[0]);
        
         jQuery.ajax({
             url : "/productInsert.up"
           , type : "POST"
           , processData : false
           , contentType : false
           , data : form
           , success:function(response) {        	            
           }
           ,error: function (jqXHR) 
           { 
               alert(jqXHR.responseText); 
           }
       });
        $('#fmt').submit();
}
</script>
</footer>
</body>
</html>

