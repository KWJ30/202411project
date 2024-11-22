package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachFileDTO {
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;

}
