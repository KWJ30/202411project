package org.zerock.service2;

import org.springframework.stereotype.Service;

@Service
public class SampleServicceImpl2 implements SampleService2 {

	@Override
	public Integer doAdd2(String str1, String str2) throws Exception {
		
		return Integer.parseInt(str1) + Integer.parseInt(str2);
		
	}

}
