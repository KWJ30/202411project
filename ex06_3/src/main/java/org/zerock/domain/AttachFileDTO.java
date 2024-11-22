package org.zerock.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

	private String fileName;  // 원본 파일명
	private String uploadPath;  //경로명
	private String uuid;      // uuid 랜덤문자
	private boolean image;   //이미지 여부
}
