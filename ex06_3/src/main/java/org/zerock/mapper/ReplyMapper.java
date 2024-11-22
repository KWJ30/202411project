package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criterial;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO replyVO);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO vo);
	
	public List<ReplyVO> getList(Long bno); 
	
	public List<ReplyVO> getListWithPaging(
				@Param("cri") Criterial	cri, 
				@Param("bno") Long bno 
			);
	
	public int getCountByBno(Long bno);
	
	
}
