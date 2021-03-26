package com.testSpring.service;

import java.util.List;

import com.testSpring.model.HomeVo;

public interface HomeService {
	// service 패키지는 그다지 중요하지 않음
	// 그다지 중요하지는 않은 구역
	//controller 와 dao를 이어주는 다리 역할
	
	//Model
	public List<HomeVo> test();
	//public HomeVo test();
	
	public List<HomeVo> getElec();
}
