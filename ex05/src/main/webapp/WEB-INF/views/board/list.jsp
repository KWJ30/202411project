<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Board List Page
                        <button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                
                                <c:forEach items="${list }" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno }"/></td>
                                		<td><a class='move' href='<c:out value="${board.bno}"/>'>
                                			<c:out value="${board.title }"/> <b>[  <c:out value="${board.replyCnt }"/>  ] </b></a>
                                		</td>
                                		<%-- <c:out>은 주로 HTML에서 특수 문자가 포함된 내용을 안전하게 출력하기 위해 사용하지만, 이 경우에는 ${}를 사용해도 문제가 없습니다. --%>
                                		<td><c:out value="${board.writer }"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/></td>
                                	</tr>
                                </c:forEach>
                             </table> 
                             <!-- table 태그의 끝 -->
                             
                             <div class='row'>
                             	<div class="col-lg-12">
                             	<form id='searchForm' action="/board/list" method='get'>
                             		<select name='type'>
                             			<option value=""
                             				<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
                             				<option value="T"
                             				<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
                             				<option value="C"
                             				<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
                             				<option value="W"
                             				<c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
                             				<option value="TC"
                             				<c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
                             				<option value="TW"
                             				<c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자</option>
                             				<option value="TWC"
                             				<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
                             		</select>
                             		<input type='text' name='keyword' 
                             		value='<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>'/>
                             		<input type='hidden' name='pageNum' 
                             		value='<c:out value="${pageMaker.cri.pageNum }"/>'/>
                             		<input type='hidden' name='amount' 
                             		value='<c:out value="${pageMaker.cri.amount }"/>'/>
                             		<button class='btn btn-default'>Search</button>
                             	</form>
                             	</div>
                             </div>
                             
                             <!-- 페이징처리 시작-->
<div class="pull-right">
	<ul class="pagination">
    
    <c:if test="${pageMaker.prev }">
    	<li class="paginate_button previous">
    	<a href="${pageMaker.startPage-1 }">Previous</a>
    	</li>
    </c:if>
    
    <c:forEach var="num" begin="${pageMaker.startPage }"
    end="${pageMaker.endPage }">
    <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} ">
    <a href="${num} ">${num }</a>
    </li>
    </c:forEach>
    
    <c:if test="${pageMaker.next }">
    	<li class="paginate_button next">
    	<a href="${pageMaker.endPage+1 }">Next</a>
    	</li>
    </c:if>
    </ul>
    
</div>
                             <!-- 페이징 처리 끝 -->
                             
<form id='actionForm' action="/board/list" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value = '<c:out value="${pageMaker.cri.type }"/>'>
	<input type='hidden' name='keyword' value = '<c:out value="${pageMaker.cri.keyword }"/>'>
</form>
                             
                             
                 <!-- Modal 추가 -->
                 <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                 aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                   <div class="modal-content">
                    <div class="modal-header">
                      <button type="button class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    </div>
                    <div class="modal-body"> 처리가 완료되었습니다.</div>
                    <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                     <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                   </div>
                   <!-- /.modal-content -->
                  </div>
                  <!-- /.modal-dialog -->
                 </div>
                 <!-- /.modal -->
                             
                        </div>
                              <!-- end panel-body -->
                       </div>
                            <!-- end panel -->
                      </div>
                    </div>
            <!-- /.	row -->
            
            <script type="text/javascript">
            
            $(document).ready(function(){
            	
            	var result = '<c:out value="${result}"/>';
            	
            	checkModal(result);
            	
            	history.replaceState({},null,null);
            	
            	function checkModal(result){
            		
            		if(result === '' || history.state){
            			return;
            		}
            		
            		if(parseInt(result) > 0){
            			$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.");
            		}
            		
            		$("#myModal").modal("show");
            	}
            	
            	$("#regBtn").on("click", function(){
            		
            		self.location = "/board/register";
            		
            	});
            	
            	var actionForm = $("#actionForm");
            	
            	$(".paginate_button a").on("click", function(e){
            		
            		e.preventDefault();
            		
            		console.log('click');
            		
            	   // 페이지 번호를 추출
             	   // var pageNum = $(this).attr("href");

               	   // 페이지 이동
            	   // window.location.href = "/board/list?pageNum=" + pageNum + "&amount=10&type=&keyword=";  // 경로를 정확히 설정
            		
            		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            		//actionForm.attr("action", "/board/list");  // action 경로 설정
            		actionForm.submit();
            		
            		 /* var pageNum = $(this).attr("href");
   					 actionForm.find("input[name='pageNum']").val(pageNum);  // 페이지 번호 설정
    				 actionForm.attr("action", "/board/list");  // action 경로 설정
    				 actionForm.submit();  // 폼 제출 */
            	});
            		
				$(".move").on("click", function(e){
            		
            		e.preventDefault(); // 링크(<a>)를 클릭하면 href 속성에 지정된 URL로 이동하는 걸 막음

            	    // 기존의 bno 값을 삭제
            	    actionForm.find("input[name='bno']").remove();
            		

            		actionForm.append("<input type='hidden' name='bno' value='"+
            	$(this).attr("href")+"'>");
            		actionForm.attr("action","/board/get");
            		actionForm.submit();
            	});
				
				var searchForm = $("#searchForm");
				
				$("#searchForm button").on("click", function(e){
					
					if(!searchForm.find("option:selected").val()){
						alert("검색종류를 선택하세요");
						return false;
					}
					
					if(!searchForm.find("input[name='keyword']").val()){
						alert("키워드를 입력하세요");
						return false;
					}
					
					searchForm.find("input[name='pageNum']").val("1");
					e.preventDefault();
					
					searchForm.submit();
					
				});
            	
            });
            </script>
            
<%@include file="../includes/footer.jsp" %>
