<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
			
			 <div class="form-group">
				<label>Bno</label><input class="form-control" name='bno'
				value='<c:out value="${board.bno }"/>' readonly="readonly">
			</div>
			
			<div class="form-group">
				<label>Title</label> <input class="form-control" name='title'
				value='<c:out value="${board.title }"/>' readonly="readonly">
			</div>
			
			<div class="form-group">
				<label>Text area</label>
				<textarea class="form-control" row="3" name='content'
				readonly="readonly"><c:out value="${board.content }"/>
				</textarea>
			</div>
			
			<div class="form-group">
				<label>Writer</label><input class="form-control" name='writer'
				value='<c:out value="${board.writer }"/>' readonly="readonly">
			</div>
			
			<sec:authentication property="principal" var="pinfo"/>
			
				<sec:authorize access="isAuthenticated()">
				
				<c:if test="${pinfo.username eq board.writer }">
			
			<button data-oper='modify' class="btn btn-default">Modify</button>
			
			</c:if>
			</sec:authorize>
			
			<button data-oper='list' class="btn btn-info">List</button>
			
			<form id='operForm' action="/board/modify" method="get">
				<input type='hidden' id='bno' name='bno' 
				value='<c:out value="${board.bno }"/>'>
				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
				<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
				<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			</form>
			
		</div>
		<!-- end panel-body -->
		
		</div>
		<!-- end panel body -->
		</div>
		<!-- end panel -->
		</div>
		<!-- /.row -->
		
		<div class='row'>
			<div class="col-lg-12">
			
			<!-- /.panel -->
			<div class="panel panel-default">
			<!-- <div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
			</div> -->
			
			<div class="panel-heading">
			<i class="fa fa-comments fa-fw"></i> Reply
			<sec:authorize access="isAuthenticated()">
				<button id = 'addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			</sec:authorize>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
					<!-- start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2018-01-01 13:13</small>
							</div>
							<p>Good job!</p>
						</div>
						</li>
						<!-- end reply -->
				</ul>
				<!-- ./ end ul -->
			</div>
			<!--  /.panel .chat-panel -->
			
			
			<div class="panel-footer">
				footer
			</div>
			
			
			</div>
			</div>
			<!-- ./ end row -->
		</div>
		
		<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>	
							<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label>Reply</label>
								<input class="form-control" name='reply' value='New Reply!!!!'>
							</div>
							<div class="form-group">
								<label>Replyer</label>
								<input class="form-control" name='replyer' value='replyer' readonly="readonly">
							</div>
							<div class="form-group">
								<label>Reply Date</label>
								<input class="form-control" name='replyDate' value=''>
							</div>
						</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
						<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
						<button id='modalCloseBtn' type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
						<button id='modalRegisterBtn' type="button" class="btn btn-success">Register</button>
					</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!--  /.modal-dialog -->
			</div>
			<!-- /.modal -->
		
		<script type="text/javascript" src="/resources/js/reply.js"></script>
		
		<style> .chat>li:hover{cursor:pointer} </style>
		
		<script>
		
		
		
		$(document).ready(function (){
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
			showList(1);
			
			function showList(page){
				
				console.log("show list " + page);
				
				replyService.getList({bno:bnoValue, page: page|| 1}, 
				function(replyCnt, list){
					
					console.log("replyCnt: " + replyCnt);
				//	console.log("list: " + list);
				//	console.log("list: " + JSON.stringify(list));
					console.log(list);
					
					if(page == -1){
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
					
					var str="";
					
					if(list == null || list.length == 0){
						return;
					}
					
					for(var i=0, len=list.length || 0; i<len; i++){
						str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						str +="  <div><div class='header'><strong class='primary-font'>" 
						+ list[i].replyer + "</strong>";
						str +="   <small class='pull-right text-muted'>" + 
						replyService.displayTime(list[i].updateDate || list[i].replyDate) + "</small></div>";
						str +="   <p>"+list[i].reply+"</p></div></li>";
						}
					
					replyUL.html(str);
					
					console.log("str: " + str);
					
					showReplyPage(replyCnt);
					
					console.log("replyCnt: " + replyCnt);
					
				}); //end function
				
			} //end showList
			
			
			//댓글 페이징 처리
			var pageNum = 1;
			var replyPageFooter = $(".panel-footer");
			
			function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum -9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
			}
			
			for(var i = startNum; i<= endNum; i++){
			
				var active = pageNum == i? "active":"";
				
				str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str+= "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			
			str+= "</ul></div>";
			
			console.log("페이징 처리 확인: " + str);

			replyPageFooter.html(str);
			
			}
			
			// 페이징 처리 끝
			
			// 페이지 번호 클릭 이벤트 처리
			replyPageFooter.on("click", "li a", function(e){
				e.preventDefault();
				console.log("page click");
				
				var targetPageNum = $(this).attr("href");
				
				console.log("targetPageNum: " + targetPageNum);
				
				pageNum = targetPageNum;
				
				showList(pageNum);
			});
			
			
			var modal = $(".modal");
			var modalInputReply = modal.find("input[name='reply']");
			var modalInputReplyer = modal.find("input[name='replyer']");
			var modalInputReplyDate = modal.find("input[name='replyDate']");
			
			var modalModBtn = $("#modalModBtn");
			var modalRemoveBtn = $("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");
			
			
			var replyer = null;
			
			<sec:authorize access="isAuthenticated()">
			
			replyer = '<sec:authentication property="principal.username"/>';
			
			</sec:authorize>
			
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			
			//Ajax spring security header...
			$(document).ajaxSend(function(e, xhr, options){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});
			
			
			$("#addReplyBtn").on("click", function(e){
				
				
				
				modal.find("input").val("");
				modal.find("input[name='replyer']").val(replyer);
				modalInputReplyDate.closest("div").hide();
				modal.find("button[id !='modalCloseBtn']").hide();
				
				modalRegisterBtn.show();
				
				$(".modal").modal("show");
				
			});
			
			//댓글 등록
			modalRegisterBtn.on("click", function(e){
				
				var reply = {
						reply: modalInputReply.val(),
						replyer : modalInputReplyer.val(),
						bno:bnoValue
					};
				replyService.add(reply, function(result){
						
					alert(result);
					
					modal.find("input").val("");
					modal.modal("hide");
					//showList(1);
					showList(-1);
					
				});
			});	
			
			
			//댓글 클릭 이벤트 처리 --> 이벤트 위험
			$(".chat").on("click", "li", function(e){
				
				var rno = $(this).data("rno");
				
				// console.log(rno);
				
				replyService.get(rno, function(reply){
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
					.attr("readonly", "readonly");
					modal.data("rno", reply.rno);
					
					modal.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					modal.modal("show");
				})
			});
			
			//댓글 수정
			modalModBtn.on("click", function(e){
				
				var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
				
				replyService.update(reply, function(result){
					
					alert(result);
					modal.modal("hide");
					showList(pageNum);
					
				});
				
			});
			
			//댓글 삭제
			modalRemoveBtn.on("click", function(e){
				
			var rno = modal.data("rno");
			
			console.log("RNO: " + rno);
			console.log("REPLYER: " + replyer);
			
			if(!replyer){
				alert("로그인후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			var originalReplyer = modalInputReplyer.val();
			
			console.log("Original Replyer: " + originalReplyer); //댓글의 원래 작성자
			
			if(replyer != originalReplyer){
				
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			replyService.remove(rno, originalReplyer, function(result){
				
				alert(result);
				modal.modal("hide");
				
				 // 댓글 목록을 다시 불러와서 처리
		        replyService.getList({bno: bnoValue, page: pageNum}, function(replyCnt, list){
		        	
		            // list가 null, undefined일 경우 빈 배열로 처리
		            if (!Array.isArray(list)) {
		                list = [];  // list가 배열이 아니라면 빈 배열로 설정
		            }

		            console.log("리스트목록: " + list);
		            console.log("페이지넘버: " + pageNum);
		            console.log("전체댓글 수: " + replyCnt);

		            // list가 비어있는지 확인
		            if (list.length === 0) {
		            	pageNum = pageNum-1;
		                console.log("댓글이 없거나 비어 있습니다.");
		                console.log("빈 페이지넘버: " + pageNum);
		                showList(pageNum);  // 이전 페이지로 이동
		            } else {
		                console.log("댓글 목록이 있습니다.");
		                showList(pageNum);  // 현재 페이지 그대로 유지
		            }
						
							
						}); 
				
				
				
				
			});
		});
			
			
			
			
			
			
		});
		
		
		//for replyService add test
		/* replyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue}
			,
			function(result){
				alert("RESULT: " + result);
			}
		); */
		
		//reply List test
		/* replyService.getList({bno:bnoValue, page:1}, function(list){
			
			for(var i = 0, len = list.length||0; i < len; i++){
				console.log(list[i]);
			}
		}); */
		
		// 6번 댓글 삭제 테스트
		/* replyService.remove(6, function(count){
			
			console.log(count);
			
			if(count === "success"){
				alert("REMOVED");
			}
		}, function(err){
			alert('ERROR...');
		}); */
		
		// 7번 댓글 수정 테스트
		/*  replyService.update({
			rno : 7,
			bno : bnoValue,
			reply : "Modified Reply...."
		}, function(result){
			alert("수정 완료...");
		
		}); */	
		
		// 특정 댓글 조회
		  /* replyService.get(10, function(data){
			console.log(data);
		});   */
	
		</script>
		
		<script type="text/javascript">
		$(document).ready(function() {
			
			var operForm = $("#operForm");
			
			$("button[data-oper='modify']").on("click", function(e){
				
				if ($("#bno").length === 0) {
					operForm.append("<input type='hidden' id='bno' name='bno' value='" + $("input[name='bno']").val() + "'>");
				}
				//list 를 누른 뒤 뒤로가기로 다시 와서 누르게 되면 bno값이 없는데 그 때 bno 값을 가져오는 코드
				operForm.attr("action","/board/modify").submit();
				
			});
			
			$("button[data-oper='list']").on("click", function(e){
				
				operForm.find("#bno").remove();
				operForm.attr("action","/board/list")
				operForm.submit();
			});
			
		});
		</script>
	
	<%@include file="../includes/footer.jsp"%>