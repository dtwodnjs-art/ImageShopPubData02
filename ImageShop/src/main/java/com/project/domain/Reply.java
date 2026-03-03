package com.project.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Reply {
	private int replyNo;
    private int noticeNo;
    private String replyText;
    private String replyer;
    private Date regDate;
    private Date updateDate;

}
