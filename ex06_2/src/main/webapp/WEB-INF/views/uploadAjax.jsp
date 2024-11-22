<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<h1>Upload with Ajax</h1>

<div class='uploadDiv'>
	<input type = 'file' name='uploadFile' multiple>
</div>



<style>
.uploadResult{
width:100%;
background-color: gray;
}

.uploadResult ul{
display:flex;
flex-flow: row;
justify-content: center;
align-itmes: center;
}

.uploadResult ul li {
list-style: none;
padding: 10px;
}

.uploadResult ul li img{
width:20px;
}
</style>


<div class='uploadResult'>
	<ul>
	
	</ul>
</div>

<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
</div>

<style>
.uploadResult{
width: 100%;
background-color: gray;}

.uploadResult ul{
display: flex;
flex-flow: row;
justify-content: center;
align-items: center;}

.uploadResult ul li{
list-style: none;
padding: 10px;
align-content: center;
text-align: center;}

.uploadResult ul li img{
width: 100px;}

.uploadResult ul li span {
color:white;}

.bigPictureWrapper {
position: absolute;
display: none;
justify-content: center;
align-items: center;
top:0%;
left:0%;
width:100%;
height:100%;
z-index: 100;
background: rgba(255,255,255,0.5);
}

.bigPicture{
position: relative;
display: flex;
justify-content: center;
align-items: center;
}

.bigPicture img{
width: 600px;}

</style>

<button id='uploadBtn'>Upload</button>

<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
  
<script>
//나중에 a 태그에서 직접 호출하기위해 ready 바깥에 작성
function showImage(fileCallPath){
	//alert(fileCallPath); //호출되는지 테스트용

$(".bigPictureWrapper").css("display","flex").show();
//$(".bigPictureWrapper").fadeIn(1000); 
	
$(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
.animate({ width: '100%', height: '100%' }, 1000);

}

$(document).ready(function(){
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){    // 5MB 이상이면 업로드 불가
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){   // exe,sh,zip,alz 의 업로드 불가
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	var cloneObj = $(".uploadDiv").clone();
	
	$("#uploadBtn").on("click", function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files);
		
		//add FIle Data to formData
		for(var i=0; i<files.length; i++){
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData : false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType:'json',
			success: function(result){
				//alert("Uploaded");
				 console.log("서버 응답 데이터:", result);
				 
				 showUploadedFile(result);
				 
				 $(".uploadDiv").html(cloneObj.html());
				 
				 result.forEach(file => {
			            console.log("파일명:", file.fileName);
			            console.log("업로드 경로:", file.uploadPath);
			            console.log("UUID:", file.uuid);
			            console.log("이미지 파일 여부:", file.image);
			        });
			}
		}); //$ajax
		
	});
	
	var uploadResult = $(".uploadResult ul");
	function showUploadedFile(uploadResultArr){
		
		var str = "";
		
		$(uploadResultArr).each(function(i,obj){
			
			if(!obj.image){
				
				var fileCallPath = encodeURIComponent( obj.uploadPath + "/" +
						obj.uuid + "_" + obj.fileName);
				
				str += "<li><a href='/download?fileName="+ fileCallPath+ "'>"
						+"<img src='/resources/img/attach.png'>" + obj.fileName + "</a></li>";
			}else{
				//이미지 파일인 경우
				//str += "<li>" + obj.fileName + "</li>";
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				var originPath = obj.uploadPath+ "\\"+obj.uuid+"_"+obj.fileName;
				
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				
				console.log("fileCallPath :");
				console.log(fileCallPath);
				str += "<li><a href=\"javascript:showImage('" + originPath + "')\">" +
			       "<img src='/display?fileName=" + fileCallPath + "'></a></li>";
			}
			});
		uploadResult.append(str);
		}
	
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
		setTimeout(() => {
			$(this).hide();
		}, 1000);
	});
	
});

</script>

</body>
</html>