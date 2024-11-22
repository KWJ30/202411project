package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criterial;

public interface BoardMapper {

//	@Select("select * from tbl_board where bno>0")
	public List<BoardVO> getList();

	public List<BoardVO> getListWithPaging(Criterial cri);
	
	public void insert(BoardVO boardVO);
	
	public void insertSelectKey(BoardVO vo);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO boardVO);
	
	public int getTotalCount(Criterial cri); //전체 데이타 개수
	
	//댓글 개수 변경   amount: 한번 수정하는 개수 : 증가+1, 감소: -1
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	//test용
	public List<BoardVO> searchTest(Map<String,  Map<String,String> > map);
	
	
}
