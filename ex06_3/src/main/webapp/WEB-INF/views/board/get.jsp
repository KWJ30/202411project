<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

  
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
                	<label>Bno</label><input class="form-control" name="bno" value="${board.bno}" readonly="readonly">
                </div>
                <div class="form-group">
                	<label>Title</label><input class="form-control" name="title" value="${board.title}" readonly="readonly">
                </div>
                <div class="form-group">
                	<label>Text area</label><textarea rows="3" class="form-control" name="content" readonly>
                	<c:out value="${board.content}"></c:out></textarea>
                </div>
                <div class="form-group">
                	<label>Writer</label><input class="form-control" name="writer" value="${board.writer}" readonly="readonly">
                </div>
                
                
               <sec:authentication property="principal" var="pinfo" />
                	<sec:authorize access="isAuthenticated()">
                		<c:if test="${pinfo.username eq board.writer}">		                
		                	<button data-oper="modify" class="btn btn-default">Modify</button>
		                </c:if>                		
                	</sec:authorize>
                
                <button data-oper="list" class="btn btn-info">List</button>
                
                <form id="operForm" action="/board/modify" method="get">
                	<input type="hidden" id="bno" name="bno" value="${board.bno}">
                	<input type="hidden" name="pageNum" value="${cri.pageNum}">
                	<input type="hidden" name="amount" value="${cri.amount}">
                	
                	<input type="hidden" name="type" value="${cri.type}">
                	<input type="hidden" name="keyword" value="${cri.keyword}">
                </form>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div> <!-- end row -->           

<!-- 댓글 처리 -->
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
            	<i class="fa fa-comments fa-fw"></i> Reply
            	
            	<sec:authorize access="isAuthenticated()">
	            	<button id='addReplyBtn' class="btn btn-primary btn-xs pull-right">
	            		New Reply
	            	</button>
            	</sec:authorize>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
               <ul class="chat">
               </ul>
            </div>
            
            <div class="panel-footer">
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div> <!-- end row -->   
<!-- / 댓글 처리 -->

<!-- modal start -->
<div id="myModal" class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">REPLY MODAL</h5>      
      </div>
      <div class="modal-body">
        <div class="form-group">
        	<label>Reply</label>
        	<input class="form-control" name="reply", value="New Reply!">
        </div>
        <div class="form-group">
        	<label>Replyer</label>
        	<input class="form-control" name="replyer", value="New Replyer!">
        </div>
        <div class="form-group">
        	<label>Reply UpdateDate</label>
        	<input class="form-control" name="updateDate", value="">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="modalModBtn">Modify</button>
        <button type="button" class="btn btn-danger" id="modalRemoveBtn">Remove</button>
        <button type="button" class="btn btn-info" id="modalRegisterBtn">Register</button>
        <button type="button" class="btn btn-default"  id="modalCloseBtn" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->

<script src="/resources/js/reply.js"></script>

<style>
	.chat>li:hover {
		cursor:pointer
	}
</style>
<script>
	$(document).ready(function(){
		console.log("---------------------------");
		console.log("JS TEST");
		
		let bnoValue = '<c:out value="${board.bno}"/>';
		
		let replyUL = $(".chat");
		
		showList(1);
		
		function showList(page) {
			
			replyService.getList(
					
				{ bno:bnoValue, page:page || 1 },
				
				function(replyCnt, list){
				
					if(page == -1){
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
					
					let str= "";
					
					if(list== null || list.length == 0){
						replyUL.html("");
						return;
					}
					
					for(let i=0, len=list.length || 0 ; i<len; i++){
						str+= "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						str+= "<div class='header'>";
						str+= "<strong class='primary-font'>"+list[i].replyer+"</strong>";
						str+= "<small class='pull-right text-muted'>"+
								replyService.displayTime(list[i].updateDate)+"</small>";
						str+= "</div>";
						str+= "<p>"+list[i].reply+"</p>";
						str+= "</li>";
					}
					
					replyUL.html(str);
					
					showReplyPage(replyCnt);  //페이징처리 호출
				}
			)
		} // end showList
		
		let modal = $("#myModal");
		let modalInputReply = modal.find("input[name='reply']");
		let modalInputReplyer = modal.find("input[name='replyer']");
		let modalInputReplyDate = modal.find("input[name='updateDate']");
		
		let modalModBtn = $("#modalModBtn");
		let modalRemoveBtn = $("#modalRemoveBtn");
		let modalRegisterBtn = $("#modalRegisterBtn");
		
		let replyer = null;
		
		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		//new reply 팝업
		$("#addReplyBtn").on("click", function(){
			modal.find("input").val("");
			
			modal.find("input[name='replyer']").val(replyer);
			
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			modal.modal("show");
		});
		
		
		//댓글 등록
		modalRegisterBtn.on("click", function(){
			let reply ={
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno: bnoValue						
			};
			
			replyService.add(reply, function(result){
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
//				showList(1);
				showList(-1);
			});		
			
		});
		
		//댓글 클릭 이벤트 처리 --> 이벤트위험
		$(".chat").on("click", "li", function(e){
			let rno = $(this).data("rno");
			//console.log(rno)
			
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime( reply.updateDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				modal.modal("show");
			})
		});
		
		//댓글 수정
		modalModBtn.on("click", function(e){
			let reply = {
				rno: modal.data("rno"),
				reply: modalInputReply.val()
			};
			
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});	
		});
		
		//댓글 삭제		
		modalRemoveBtn.on("click", function(e){
			let rno = modal.data("rno");
			
			replyService.remove(rno, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			})
			
		});   
		
		//페이징 처리
		let pageNum = 1;
		let replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
		
			let endNum = Math.ceil(pageNum /10.0) * 10;
			let startNum = endNum - 9;
			
			let prev = startNum != 1;  //이전버튼
			let next = false;          //다음버튼
			
			//real page( 끝 페이지 재계산)
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			//next버튼 유무 조건?
			if(endNum *10 < replyCnt){ 
				next = true;
			}
			
			let str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str+= "<li class='page-item'>"
				str+= "<a class='page-link' href='"+(strNum-1)+"'>Previous</a></li>";
			}
			
			for(let i=startNum; i<=endNum; i++){
				let active = pageNum == i? "active":"";
				
				str+= "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>" + i + "</a></li>";
			}
			
			if(next){
				str+= "<li class='page-item'>"
				str+= "<a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			
			str+= "</ul>";
			
			console.log(str);
			
			replyPageFooter.html(str);
			
		}  //end showReplyPage
		
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			
			let targetPageNum = $(this).attr("href");
			
			pageNum = targetPageNum;
			
			showList(pageNum);
			
		}); //end replyPageFooter
		
	});	//end ready
</script>

<script>
	$(document).ready(function(){
		
		/* console.log("---------------------------");
		console.log("JS TEST");
		
		let bnoValue = '<c:out value="${board.bno}"/>'; */
		
		/*  replyService.add(
			{reply:"JS TEST", replyer:"tester", bno:bnoValue},
		
			function(result){
				alert("RESULT : " + result);
			}
		);  */
		
		/* replyService.getList(
			{bno:bnoValue, page:1 },
			function(list){
				for(let i=0, len = list.length||0; i<len; i++){
					console.log(list[i]);
				}
			}
		 );  */
		 
		/* replyService.remove(
			14,
			function(msg){
				if(msg == "success"){
					alert("REMOVED");
				}				
			},
			function(err){
				alert("ERROR......");
			}
		); */
		
		/* replyService.update(
			{
				rno: 13,
				reply: 'Modified reply....'
			},
			function(msg){
				alert("수정 완료 : " + msg);
			}
		); */
		
		/* replyService.get(
				13,
				function(result){
					console.log(result);
				}				
		); */
		
	})
</script>

<script>
$(document).ready(function(){
	
	let  operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();
	});

	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove(); 
		operForm.attr("action", "/board/list").submit();
	});
});
</script>

<%@ include file="../includes/footer.jsp" %> 