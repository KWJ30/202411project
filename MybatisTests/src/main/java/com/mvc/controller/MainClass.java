package com.mvc.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MainClass {
	
	public static void main(String[] args) {
		String resource = "com/mvc/controller/mybatis-config.xml";
		InputStream inputStream;
		try {
			inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			
			System.out.println("sqlSeessionFactory: " + sqlSessionFactory);
			
			SqlSession session = sqlSessionFactory.openSession(true);  //자동커밋
					
			System.out.println("session: " + session);
			
			BoardDTO dto = new BoardDTO();
			
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			
		/*	dto = mapper.selectOne("test1");   // 단일 select (정확히 1개만)
			
			System.out.println("dto: " + dto); */  
			
		/*	List<BoardDTO> lists = mapper.selectAllList();   // 전체 select(인자값없음)
			
			for(BoardDTO list : lists)
				System.out.println(list);  */
			
		/*	int result = mapper.deleteBoard(118);	// delete (num값으로)
			
			System.out.println("result: " + result); */
			
		//	session.commit();     // 자동커밋이 아니라면 써주어야함
			
		/*	dto.setTitle("마이바티스");					// update (num값을 받아서 제목과내용변경)
			dto.setContent("마이바티스로 입력중..");
			dto.setNum(100);	
			
			int result = mapper.updateBoard(dto);  	// 인자값은 BoardDTO dto
			
			System.out.println("result: " + result); */
			
		//	Blog blog = session.selectOne("org.mybatis.example.BlogMapper.selectBlog", 101);
				
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
