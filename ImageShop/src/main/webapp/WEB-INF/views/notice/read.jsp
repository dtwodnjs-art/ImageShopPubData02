<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <h2>공지사항 상세보기</h2>

        <form:form modelAttribute="notice">
            <form:hidden path="noticeNo" id="noticeNo" /> 
            <table>
                <tr>
                    <td>제목</td>
                    <td><form:input path="title" readonly="true" /></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><form:textarea path="content" readonly="true" /></td>
                </tr>
            </table>
        </form:form>

        <div style="margin-top: 20px;">
            <%-- [체크 1] zeus의 권한이 ROLE_ADMIN인 것을 확인했으므로 이 조건문이 작동해야 합니다. --%>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <button type="button" id="btnEdit" style="background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">편집</button>
                <button type="button" id="btnRemove" style="background-color: #dc3545; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">삭제</button>
            </sec:authorize>
            
            <button type="button" id="btnList" style="padding: 10px 20px;">목록</button>
        </div>

        <%-- [체크 2] 여전히 안 보인다면 아래 코드가 '보임'으로 나오는지 확인하세요 --%>
        <div style="font-size: 10px; color: #ccc;">
            권한 체크 결과: 
            <sec:authorize access="hasRole('ROLE_ADMIN')">보임</sec:authorize>
            <sec:authorize access="!hasRole('ROLE_ADMIN')">안보임</sec:authorize>
        </div>

        <jsp:include page="reply.jsp" />
    </div>

    <script>
        $(document).ready(function() {
            const noticeNo = $("#noticeNo").val();

            // 편집 버튼 이벤트 (on 메서드 사용으로 확실하게 바인딩)
            $(document).on("click", "#btnEdit", function() {
                if(noticeNo) {
                    self.location = "/notice/modify?noticeNo=" + noticeNo;
                }
            });

            // 삭제 버튼 이벤트
            $(document).on("click", "#btnRemove", function() {
                if(confirm("정말 이 공지사항을 삭제하시겠습니까?")) {
                    self.location = "/notice/remove?noticeNo=" + noticeNo;
                }
            });

            $("#btnList").on("click", function() {
                self.location = "/notice/list";
            });
        });
    </script>
</body>
</html>