<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board Read</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		
		<div class="row">
		 <div class="col-lg-12">
		  <div class="panel panel-default">
		  
		   <div class="panel-heading">Board Read Page</div>
		<!-- /.panel-heading -->
			<div class="panel-body">
			
			<form role="form" action="/board/modify" method="post">
			
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
			
			<!-- 추가 -->
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
			
			
			
			 <div class="form-group">
				<label>Bno</label><input class="form-control" name='bno'
				value='<c:out value="${board.bno }"/>' readonly="readonly">
			</div>
			
			<div class="form-group">
				<label>Title</label> <input class="form-control" name='title'
				value='<c:out value="${board.title }"/>' >
			</div>
			
			<div class="form-group">
				<label>Text area</label>
				<textarea class="form-control" row="3" name='content'
				><c:out value="${board.content }"/>
				</textarea>
			</div>
			
			<div class="form-group">
				<label>Writer</label><input class="form-control" name='writer'
				value='<c:out value="${board.writer }"/>' readonly="readonly">
			</div>
			
			<div class="form-group">
				<label>RegDate</label>
				<input class="form-control" name='regDate'
				  value='<fmt:formatDate pattern = "yyyy/MM/dd" 
				  value = "${board.regdate }"/>' readonly="readonly">
			</div>
			
			<div class="form-group">
				<label>Update Date</label>
				<input class="form-control" name='updateDate'
				  value='<fmt:formatDate pattern = "yyyy/MM/dd" 
				  value = "${board.updateDate }"/>' readonly="readonly">
			</div>
			
			<sec:authentication property="principal" var="pinfo"/>
			
				<sec:authorize access="isAuthenticated()">
				
				<c:if test="${pinfo.username eq board.writer }">
			
			<button type="submit" data-oper='modify' class="btn btn-default">
			Modify</button>
			<button type="submit" data-oper='remove' class="btn btn-danger">
			Remove</button>
			
			</c:if>
			</sec:authorize>
			
			<button type="submit" data-oper='list' class="btn btn-info">
			List</button>
			
			</form>
			
		</div>
		<!-- end panel-body -->
		
		</div>
		<!-- end panel body -->
		</div>
		<!-- end panel -->
		</div>
		<!-- /.row -->
		
		<script type="text/javascript">
		$(document).ready(function() {
			
			var formObj = $("form");
			
			$('button').on("click", function(e) {
			
				e.preventDefault();
				
				var operation = $(this).data("oper");
				
				console.log(operation);
				
				if(operation === 'remove'){
					formObj.attr("action", "/board/remove");
				}else if(operation === 'list'){
					//move to list
					/* self.location = "/board/list";
					return; */
					//페이지 이동만 필요할 때 사용합니다. 브라우저 주소를 변경하고 페이지를 새로 로드하는 방식
					
					formObj.attr("action","/board/list").attr("method","get");
					var pageNumTag = $("input[name='pageNum']").clone();
					var amountTag = $("input[name='amount']").clone();
					var typeTag = $("input[name='type']").clone();
					var keywordTag = $("input[name='keyword']").clone();
					
					
					formObj.empty();  //데이터 비우기
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(typeTag);
					formObj.append(keywordTag);
					//폼을 통해 데이터를 서버로 전송하면서 이동하고 싶을 때 사용
				}
				formObj.submit();
			});
		});

		</script>
	
	<%@include file="../includes/footer.jsp"%>