package com.project.service;

import java.util.List;

import com.project.domain.Reply;

public interface ReplyService {

	// 댓글 등록
    public void register(Reply reply) throws Exception;
    
    // 특정 공지사항의 댓글 목록 조회
    public List<Reply> list(int noticeNo) throws Exception;
    
    // 댓글 수정
    public void modify(Reply reply) throws Exception;
    
    // 댓글 삭제 (컨트롤러에서 호출하는 부분)
    public void remove(int replyNo) throws Exception;

}
