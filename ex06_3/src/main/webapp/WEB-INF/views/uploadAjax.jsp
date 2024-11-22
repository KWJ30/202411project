<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>


<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img{
	width:600px;
}
</style>



</head>
<body>
	<h1>uploadAjax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple">
	</div>
	<button id="uploadBtn">Upload</button>
	
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		</div>
	</div>
	
	<script type="text/javascript">	
	
	function showImage(fileCallPath){
		console.log("fileCallPath : " + fileCallPath);
		$(".bigPictureWrapper").css("display", "flex").show();
		$(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath)+"'>")
			.animate({width:'100%', height: '100%'}, 1000);
	};
	
	$(document).ready(function(){
			
			//        aaaa.alz               
			let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			
			let maxSize = 5242880; //5MB
			
			function checkExtentsion(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				
				return true;
			}  //end checkExtentsion
			
			let cloneObj = $(".uploadDiv").clone();  //초기화
			
			$("#uploadBtn").on("click", function(e){
				let formData = new FormData();
				
				let inputFile = $("input[name='uploadFile']");
				let files = inputFile[0].files;
				
				console.log(files);
				
				for(let i=0; i<files.length; i++){
					
					if( !checkExtentsion(files[i].name, files[i].size) ){
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'post',
					dataType: 'json',
					success: function(result){
						console.log(result)
						showUploadFile(result);
						$(".uploadDiv").html(cloneObj.html());
					}
				}); //end ajax
			}); //end uploadBtn
			
			let uploadResult = $(".uploadResult ul");
			function showUploadFile(uploadResultArr){
				
				let str = "";
				
				$(uploadResultArr).each(function(i, obj){
					
					if(!obj.image){
						
						let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName)
						
						str += "<li><a href='/download?fileName="+fileCallPath+"'>" +"<img src='/resources/img/attach.png'>" + obj.fileName + "</a></li>";
						
					}else{
						//이미지 파일인 경우
						
						let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						let originPath = obj.uploadPath + "\\" + obj.uuid + "_" +obj.fileName;
						
						console.log("originPath before :  " +  originPath);
					
						originPath = originPath.replace(new RegExp(/\\/g), "/");
						console.log("originPath after :  " +  originPath);
						
						str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src= '/display?fileName="+fileCallPath+"'></a></li>";
					}
				});
				uploadResult.append(str);
			}  //end showUploadFile
			
		});  //end document
	</script>
</body>
</html>