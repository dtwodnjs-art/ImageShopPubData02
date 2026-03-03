package com.project.mapper;

import java.util.List;

import com.project.domain.Reply;

public interface ReplyMapper {
	
	// 댓글 생성
    public void create(Reply reply) throws Exception;
    
    // 댓글 목록 조회
    public List<Reply> list(int noticeNo) throws Exception;
    
    // 댓글 수정
    public void update(Reply reply) throws Exception;
    
    // 댓글 삭제
    public void delete(int replyNo) throws Exception;

}
