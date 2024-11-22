package org.zerock.mapper;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criterial;
import org.zerock.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	private Long[] bnoArr = {2L, 7L, 13L, 14L, 18L};
	
	@Autowired
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info("=============== "+mapper);
	}
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10)
			.forEach(i->{
//				ReplyVO vo = new ReplyVO();
//				vo.setBno(bnoArr[i%5]);
//				vo.setReply("댓글 테스트" + i);
//				vo.setReplyer("repler"+i);
				
				ReplyVO vo = ReplyVO.builder()
						.bno(bnoArr[i%5])  //1 % 5 >> bnoArr[1] =>7L
											//2 % 5 >> bnoArr[2] => 13L
						                    //5 % 5 >> bnoArr[0] => 2L
						.reply("댓글 테스트" + i)
						.replyer("repler"+i)
						.build();
				
				mapper.insert(vo);
			});
	}
	
	@Test
	public void testRead() {
		log.info(mapper.read(20L));
	}
	
	@Test
	public void testGetList() {
		mapper.getList(7L)
		.forEach(vo -> log.info(vo));
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.delete(20L));
	}
	
	
	@Test
	public void testUpdate() {
		ReplyVO vo = mapper.read(11L);
		
		vo.setReply("수정된 댓글 내용");
		
		mapper.update(vo);
	}
	
	@Test
	public void testGetListWithPaging() {
		Criterial cri = new Criterial();
		
		mapper.getListWithPaging(cri, 14L)
		.forEach(reply-> log.info(reply));
	}
}
