package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Component
@ToString
@Getter
// @AllArgsConstructor 인스턴스 변수로 선언된 모든것을 파라미터로 받는 생성자를 작성 
@RequiredArgsConstructor  // 여러개의 인스턴스 변수들 중에서 특정한 변수에 대해서만 생성자를 작성하고 싶을 때
// @NonNull이나 final 이 붙은 인스턴스 변수에 대한 생성자를 만들어냄
public class SampleHotel {
	@NonNull
	private Chef chef;
	
}
