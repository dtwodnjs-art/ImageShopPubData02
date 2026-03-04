<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

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
		<h2>
			<spring:message code="useritem.header.read" />
		</h2>

		<form:form modelAttribute="userItem">
			<form:hidden path="userItemNo" />

			<table>
				<tr>
					<td><spring:message code="useritem.itemName" /></td>
					<td><form:input path="itemName" readonly="true" /></td>
					<td><font color="red"><form:errors path="itemName" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="useritem.itemPrice" /></td>
					<td><form:input path="price" readonly="true" /></td>
					<td><font color="red"><form:errors path="price" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="useritem.itemFile" /></td>
					<td><img src="/item/display?itemId=${userItem.itemId}" width="210"></td>
				</tr>
				<tr>
					<td><spring:message code="useritem.itemDescription" /></td>
					<td><form:textarea path="description" readonly="true" /></td>
					<td><font color="red"><form:errors path="description" /></font></td>
				</tr>
			</table>

		</form:form>

		<div>
			<button type="submit" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			let formObj = $("#userItem");
			

			$("#btnList").on("click", function() {
				self.location = "/useritem/list";
			});
		});
	</script>
</body>
</html>