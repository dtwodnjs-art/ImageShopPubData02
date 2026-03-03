<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<hr>
<div align="center">
    <h3>댓글</h3>
    <sec:authorize access="isAuthenticated()">
        <table border="1">
            <tr>
                <td>작성자</td>
                <td><input type="text" id="newReplyWriter" value="<sec:authentication property='principal.username' />" readonly></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea id="newReplyText" rows="3" cols="50"></textarea></td>
            </tr>
        </table>
        <button type="button" id="btnReplyAdd">댓글 등록</button>
    </sec:authorize>
    <br><br>
    <table border="1" id="repliesList" width="600"></table>
</div>

<script>
$(document).ready(function() {
    const noticeNo = $("#noticeNo").val();
    const loginId = "<sec:authentication property='principal.username' />";
    let isAdmin = false;
    <sec:authorize access="hasRole('ROLE_ADMIN')"> isAdmin = true; </sec:authorize>

    function getReplyList() {
        $.getJSON("/replies/list/" + noticeNo, function(data) {
            let str = "";
            $(data).each(function() {
                str += "<tr>"
                    + "<td>" + this.replyer + "</td>"
                    + "<td>" + this.replyText + "</td>";
                if (isAdmin || loginId === this.replyer) {
                    str += "<td><button type='button' class='btnReplyDel' data-rno='" + this.replyNo + "' data-writer='" + this.replyer + "'>삭제</button></td>";
                } else {
                    str += "<td></td>";
                }
                str += "</tr>";
            });
            $("#repliesList").html(str);
        });
    }

    // 댓글 등록 - CSRF 제거 버전
    $("#btnReplyAdd").on("click", function() {
        const replyer = $("#newReplyWriter").val();
        const replyText = $("#newReplyText").val();

        $.ajax({
            type: 'post',
            url: '/replies/register',
            headers: { "Content-Type": "application/json" },
            // SecurityConfig에서 csrf.disable() 했으므로 beforeSend(토큰 설정) 필요 없음
            data: JSON.stringify({ noticeNo: noticeNo, replyer: replyer, replyText: replyText }),
            success: function(result) {
                if (result === "SUCCESS") {
                    alert("등록되었습니다.");
                    $("#newReplyText").val("");
                    getReplyList();
                }
            },
            error: function(xhr) {
                alert("등록 실패: " + xhr.status); // 이제 0 대신 다른 코드가 뜨거나 성공해야 합니다.
            }
        });
    });

    // 댓글 삭제 - CSRF 제거 버전
    $(document).on("click", ".btnReplyDel", function() {
        const rno = $(this).data("rno");
        const writer = $(this).data("writer");
        if(confirm("삭제하시겠습니까?")) {
            $.ajax({
                type: 'delete',
                url: '/replies/' + rno,
                headers: { "Content-Type": "application/json" },
                data: JSON.stringify({ replyer: writer }),
                success: function(res) { if(res === "SUCCESS") getReplyList(); },
                error: function(xhr) { alert("삭제 실패: " + xhr.status); }
            });
        }
    });

    getReplyList();
});
</script>