package org.zerock.domain;

import java.util.Date;

import lombok.Builder;
import lombok.Data;

@Data
//@Builder
public class BoardVO {
	
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;
	
	@Builder
    public BoardVO(Long bno, String title, String content, String writer, Date regdate, Date updateDate) {
        this.bno = bno;
        this.title = title;
        this.content = content;
        this.writer = writer;
        this.regdate = regdate;
        this.updateDate = updateDate;
    }

}
