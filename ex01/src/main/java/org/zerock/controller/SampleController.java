package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample")  // *은 필수 아님. Spring의 URL 패턴 매칭이 하위 경로도 자동으로 지원
//  /*를 사용하면 /sample의 하위 모든 경로에 대해 기본 매핑이 활성화됩니다.
//  그래서 @RequestMapping("")으로 설정된 basic() 메서드가 
//  /sample 하위의 모든 경로에서 기본적으로 실행될 수 있는 상태가 됩니다.
//  /*을 제거하면 "" 매핑인 basic() 메서드는 /sample 경로에만 매핑되고, 하위 경로에서는 더 이상 기본적으로 실행되지 않습니다.
@Log4j
public class SampleController {
	
	// @InitBinder는 특정 데이터 형식을 커스텀하게 변환할 때 유용하고, 메소드에 적용
	// @DateTimeFormat은 개별 필드에 형식을 간단하게 지정할 때 적합, 필드나 매개변수에 적용
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.util.Date.class, 
				new CustomDateEditor(dateFormat, false));
	}
	
	@RequestMapping("")
	public void basic() {
		log.info("basic..........");
	}
	
	@RequestMapping(value= "/basic", method = {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		log.info("basic get..........");
	}
	
	// POST 요청 시에는 /sample로 매핑된 기본 메서드로 요청이 전달 (/sample/* 로 공통매핑 했을 시)
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get..........");
	}
	
	//  /* 는 단일 레벨 하위 경로에만 매핑
	//  이 경로로 POST요청을 보내면 Spring은 이를 처리할 컨트롤러를 찾지 못해 404 오류를 반환
	@GetMapping("/basicOnlyGet/more")
	public void basicGet3() {
		log.info("basic get only get more..........");
	}

	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		log.info("" + dto);
		return "ex01";
	}
	
	@GetMapping("/ex02")
// public String ex02(String name, int age) 이렇게만 써도 되긴하지만 boot 에서 에러날때도 있으니 그냥 param까지 다 쓰자	
	public String ex02(@RequestParam("name") String name, 
					   @RequestParam("age") int age) {
		log.info("name: " + name);
		log.info("age: " + age);
		return "ex02";
	}
	
	// GET 요청에 다수의 파라미터를 배열이나 리스트로 담아 보내는 대신
	// JSON 형식의 POST 요청으로 처리하는 것이 일반적
	@GetMapping("/ex02List")  
	public String ex02List(@RequestParam("ids")ArrayList<String> ids) {
		log.info("ids: " + ids);
		return "ex02List";
	}
	
	// 간단한 필터나 다중 선택 조건: 예를 들어 ids와 같이 특정 아이템 ID를 필터링하거나, 
	// 체크박스 등에서 다중 선택을 처리하는 경우 유용할 수 있습니다. (URL에 포함할 데이터가 간단하고 짧은 경우)
	@GetMapping("/ex02Array")
	public String ex02Array(@RequestParam("ids")String[] ids) {
		log.info("array ids: " + Arrays.toString(ids));
		return "ex02Array";
	}
	
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		log.info("list dtos: " + list);
		return "ex02Bean";
	}
	
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		log.info("todo: " + todo);
		return "ex03";
	}
	
	// https://galid1.tistory.com/769
	// @RequestParam 1:1 매핑이냐, @ModelAttribute 객체 매핑이냐
	// 사용자를 찾기 위한 검색 조건이 늘어나거나 줄어드는 변경이 발생되었을때
	// 1. 다수의 변경점 2. 매개변수의 순서 (@ModelAttribute 의 장점)
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {
		log.info("dto: " + dto);
		log.info("page: " + page);
		return "sample/ex04";
	}
	
	// void는 해당 URL의 경로를 그대로 jsp 파일의 이름으로 사용
	// 파일 [/WEB-INF/views/sample/ex05.jsp]을(를) 찾을 수 없습니다.
	@GetMapping("/ex05")
	public void ex05() {
		log.info("/ex05..........");
	}
	
	// JSON 타입으로 객체를 변환해서 전달
	// JSP 파일을 사용할 필요 없이 객체를 직접 JSON 형식으로 변환하여 클라이언트에 반환
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("/ex06........");
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("홍길동");
		
		return dto;
	}
	
	// HTTP 요청의 본문(body)에서 JSON 형식으로 전달된 데이터를 SampleDTO 객체로 변환하여 dto 매개변수로 전달하는 역할
	// @RequestBody는 GET 요청에서는 사용되지 않는 것이 일반적입니다. 주로 POST나 PUT 요청에서 사용
	// @RequestBody가 작동하려면 클라이언트에서 요청 본문에 데이터를 포함시켜야 하며, 데이터 형식은 JSON 또는 XML로 전송됩니다.
	@PostMapping("/ex06_1")
	public String ex06_1(@RequestBody SampleDTO dto) {
		log.info("/ex06_1........");
		log.info("dto: " + dto);
		return "ex06_1";  //메서드가 "ex06_1"을 반환하므로 ex06_1.jsp 파일이 뷰로 사용
	}
	
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07(){  
		// **본문(body)**에 String 타입 데이터를 포함한 HTTP 응답을 반환합니다. 
		//여기서는 JSON 형식의 문자열인 msg를 응답 본문으로 전달
		log.info("/ex07........");
		
		//{name": "홍길동"}
		String msg = "{\"name\": \"홍길동\"}";
		//반환할 JSON 데이터
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-type", "application/json;charset=UTF-8");
		//이 헤더는 응답 본문이 JSON 형식임을 나타내고, 문자 인코딩 방식을 UTF-8로 지정
		return new ResponseEntity<>(msg,header,HttpStatus.OK);
	}
	// ResponseEntity 객체는 세 가지 파라미터를 받습니다:
	// 본문 (msg): 클라이언트에게 전달할 데이터.
	// 헤더 (header): 응답 헤더 설정.
	// HTTP 상태 코드 (HttpStatus.OK): 응답의 상태 코드입니다.
	
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload........");
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		
		files.forEach(file->{
			log.info("------------------");
			log.info("name: " + file.getOriginalFilename());
			log.info("size: " + file.getSize());
		});
	}
}
