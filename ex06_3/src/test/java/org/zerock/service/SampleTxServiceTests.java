package org.zerock.service;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleTxServiceTests {

	@Autowired
	private SampleTxService txService;
	
	@Test
	public void testLong() {
		
		log.info("txService : " + txService);
		
		String str = "통계청은 18일통계통계청은 18일청은";
		
		log.info("길이 : " + str.getBytes().length);
		
		txService.addData(str);
	}

}
