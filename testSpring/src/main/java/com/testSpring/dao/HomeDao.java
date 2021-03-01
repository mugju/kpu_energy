package com.testSpring.dao;

import java.util.List;

import com.testSpring.model.HomeVo;

//dao는 데이터 베이스와 연결해주는 함수들을 담는다.
public interface HomeDao {
	public List<HomeVo> test();
	//public HomeVo test(); // 반환형이 HomeVo
	
	public List<HomeVo> getElec();
}
