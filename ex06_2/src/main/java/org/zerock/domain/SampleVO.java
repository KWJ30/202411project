package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SampleVO {
	
	private Integer mno;  //int 와의 차이점: Integer는 null 값 허용
	private String firstName;
	private String lastName;

}
