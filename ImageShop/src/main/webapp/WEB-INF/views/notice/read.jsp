<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>
<link rel="stylesheet" href="/css/board/read.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div align="center">
		<h2><spring:message code="notice.header.read" /></h2>

		<form:form modelAttribute="notice" id="notice">
			<form:hidden path="noticeNo" id="noticeNo" /> 
			<table>
				<tr>
					<td><spring:message code="notice.title" /></td>
					<td><form:input path="title" readonly="true" /></td>
				</tr>
				<tr>
					<td><spring:message code="notice.content" /></td>
					<td><form:textarea path="content" readonly="true" /></td>
				</tr>
			</table>
		</form:form>

		<div style="margin-top: 15px;">
			<sec:authentication property="principal" var="principal" />
			
			<sec:authorize access="hasAnyAuthority('ROLE_ADMIN', 'ADMIN')">
				<button type="button" id="btnEdit">
					<spring:message code="action.edit" />
				</button>
				<button type="button" id="btnRemove">
					<spring:message code="action.remove" />
				</button>
			</sec:authorize>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>

		 
		<div style="margin-top:20px; color:red; font-size:12px; border:1px solid #ccc; width:400px;">
			[디버그 정보]<br>
			아이디: <sec:authentication property="principal.username" /><br>
			권한목록: <sec:authentication property="principal.authorities" />
		</div> 
		

		<jsp:include page="reply.jsp" />
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
$(document).ready(function() {
    // 1. 공지사항 번호 가져오기
    const noticeNo = $("#noticeNo").val();
    console.log("현재 공지사항 번호:", noticeNo);

    // 2. 편집(수정) 버튼 클릭
    // ID(#btnEdit)로 안 잡힐 경우를 대비해 텍스트로도 잡히게 설정
    $(document).on("click", "#btnEdit, button:contains('편집')", function(e) {
        e.preventDefault();
        if(noticeNo) {
            console.log("수정 페이지로 이동합니다.");
            self.location = "/notice/modify?noticeNo=" + noticeNo;
        } else {
            alert("공지사항 번호를 찾을 수 없습니다.");
        }
    });

    // 3. 삭제 버튼 클릭
    $(document).on("click", "#btnRemove, button:contains('삭제')", function(e) {
        e.preventDefault();
        if(confirm("정말 이 공지사항을 삭제하시겠습니까?")) {
            console.log("삭제를 진행합니다.");
            self.location = "/notice/remove?noticeNo=" + noticeNo;
        }
    });

    // 4. 목록 버튼 클릭
    $(document).on("click", "#btnList, button:contains('목록')", function(e) {
        e.preventDefault();
        self.location = "/notice/list";
    });
});
</script>
</body>
</html>