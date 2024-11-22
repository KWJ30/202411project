package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Autowired
	private BoardService service;
	
	@Test
	public void testExist() {
		
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		
		BoardVO board = BoardVO.builder()
				.title("새로 작성하는 글 select key")
				.content("새로 작성하는 내용 select key")
				.writer("newbie")
				.build();
		
		log.info("생성된 게시물의 번호: " + board.getBno());
		
	}
	
	@Test
	public void testGetList() {
		 
		//service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(2,10)).forEach(board -> log.info(board));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(10L));
	}
	
	@Test
	public void testDelete() {
		log.info(service.remove(19L));
	}
	
	@Test
	public void testModify() {
		BoardVO board = service.get(15L);
		
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user11");
		
		log.info(service.modify(board));
	}
	
	

}
