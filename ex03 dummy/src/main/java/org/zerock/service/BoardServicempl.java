package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
// @AllArgsConstructor  // 모든 필드를 초기화
@RequiredArgsConstructor // 필수 필드만 초기화
//final 필드나 @NonNull이 붙은 필드만 포함하는 생성자를 생성
public class BoardServicempl implements BoardService{
	
	@Autowired
	private final BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		
		log.info("register......" + board);
		
		mapper.insertSelectKey(board);
		
	}

	@Override
	public BoardVO get(Long bno) {
		
		log.info("get.......");
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {

		log.info("modify.......");
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		
		log.info("remove.......");
		
		return mapper.delete(bno) == 1;
	}

//	@Override
//	public List<BoardVO> getList() {
//		
//		log.info("List.......");
//		
//		return mapper.getList();
//	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		log.info("get List with criteria: " + cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

}
