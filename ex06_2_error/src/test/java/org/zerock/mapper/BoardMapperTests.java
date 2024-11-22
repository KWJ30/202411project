package org.zerock.mapper;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.asyncDispatch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class BoardMapperTests {
	
	@Autowired
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testPaging() {
		
	    Criteria cri = new Criteria();
	    cri.setPageNum(1);
	    cri.setAmount(10);
	    
	    List<BoardVO> list = mapper.getListWithPaging(cri);
	    
        list.forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		
		BoardVO board = BoardVO.builder()
				.title("새로 작성하는 글")
				.content("새로 작성하는 내용")
				.writer("newbie")
				.build();
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		
		BoardVO board = BoardVO.builder()
				.title("새로 작성하는 글 select key")
				.content("새로 작성하는 내용 select key")
				.writer("newbie")
				.build();
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		Long bno = 10L;
		
		BoardVO board = mapper.read(bno);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		int result = mapper.delete(3L);
		
		log.info("result: " + result);
	}
	
	@Test
	public void testUpdate() {
		Long bno = 5L;
		
		BoardVO board = mapper.read(bno);
		
		board.setTitle("수정 제목");
		board.setContent("수정 내용");
		board.setWriter("수정자");
		
		int result = mapper.update(board);
		log.info(result);
	}
	
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("새로");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
	
	@Test
	public void testSearch1() {
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("T", "수정 제목");
		map.put("C", "수정된 내용");
		map.put("W", "모달뉴비");
		
		Map<String,Map<String,String>> outer = new HashMap<String, Map<String,String>>();
		
		outer.put("map", map);
		
		List<BoardVO> list = mapper.searchTest(outer);
		
		list.forEach(l -> log.info(l));
	}
	
	@Test
	public void testGetTotalCount() {
		Criteria cri = new Criteria();
		
		cri.setKeyword("수정된 내용");
		cri.setType("C");
		int totalCount = mapper.getTotalCount(cri);
		log.info("totalCount: " + totalCount);
	}

}
