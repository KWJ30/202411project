package org.zerock.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * create table tbl_reply(
    rno number(10,0),
    bno NUMBER(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate    
);
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReplyVO {
	private Long rno;
	private Long bno;
	
	private String reply;
	private String replyer;
	
	private Date replyDate;
	private Date updateDate;
}
