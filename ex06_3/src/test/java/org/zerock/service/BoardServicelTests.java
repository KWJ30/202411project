package org.zerock.service;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapperTests;

import lombok.Builder;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServicelTests {

	@Autowired
	private BoardService service;

	
	@Test
	public void testRegister() {
		
//		BoardVO vo = BoardVO.builder()
//				.title("새로 작성하는 글")
//				.content("새로 작성하는 내용")
//				.writer("newbie1")
//				.build();
//		
//		service.register(vo);
//		
//		log.info("생성된 게시물의 번호 : "+ vo.getBno());
	}
	
	@Test
	public void testGetList() {
		
//		List<BoardVO> list = service.getList();
//		list.forEach(vo -> log.info(vo));

//		service.getList().forEach(vo -> log.info(vo));
	}
	
	@Test
	public void getGet() {
		log.info(service.get(11L));
	}
	
	@Test
	public void testDelete() {
		log.info("---------------" + service.remove(11L));
	}

	@Test
	public void testModify() {
		BoardVO vo = service.get(11L);
		
		vo.setTitle("수정된 제목");
		vo.setContent("수정된 내용");
		vo.setWriter("user11");
		
		log.info(service.modify(vo));
	}
	
}










