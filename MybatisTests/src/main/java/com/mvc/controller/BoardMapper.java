package com.mvc.controller;

import java.util.List;

public interface BoardMapper {
	
	public int insertWrite(BoardDTO dto);
	
	public BoardDTO selectOne(String id);
	
	public List<BoardDTO> selectAllList();
	
	public int deleteBoard(int num);
	
	public int updateBoard(BoardDTO dto);

}
