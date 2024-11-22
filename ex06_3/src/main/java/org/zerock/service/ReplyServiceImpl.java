package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criterial;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService{

	private final ReplyMapper mapper;
	
	private final BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register......." + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get......." + rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify......." + vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove......." + rno);
		
		ReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}
	

	@Override
	public List<ReplyVO> getList(Criterial cri, Long bno) {

		log.info("getList......." + cri + ", " + bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criterial cri, Long bno) {
		
		return new ReplyPageDTO(
					mapper.getCountByBno(bno),
					mapper.getListWithPaging(cri, bno)
				);
	}

}
