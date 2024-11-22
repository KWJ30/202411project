<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>SAMPLEDTO ${sampleDTO }</h2>
	<!-- Spring은 객체의 클래스 이름(SampleDTO)의 첫 글자를 소문자로 변환하여, 해당 이름을 속성 이름으로 사용합니다. 
	그래서 JSP에서는 ${sampleDTO}로 객체에 접근할 수 있게 됩니다. -->
	<h2>PAGE ${page }</h2>
</body>
</html>