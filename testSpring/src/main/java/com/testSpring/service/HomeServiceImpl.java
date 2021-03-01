package com.testSpring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.testSpring.dao.HomeDao;// ctrl + shift + O -> 자동으로 클래스를 import 해주는 단축키 [매우 중요]
import com.testSpring.model.HomeVo;

@Service			// 서비스라고 알려주는 어노테이션    서비스에 : 컨트롤러 서비스 다오가 있고 그중 서비스는 컨트롤러와 다오를 연결해주는 것 이 어노테이션은 이 공간이 서비스라고 인식 시켜주기 위해 표시하는 것
public class HomeServiceImpl implements HomeService{

	
	@Autowired
	HomeDao homeDao;
	@Override
	public List<HomeVo> test() {
		return homeDao.test();
	}
	/*
	 * public HomeVo test() { // 반환형이 HomeVo 인 것 (public int amm(){ ... }) return   -> 값 한개 불러올때 사용하던 것
	 * homeDao.test(); }
	 */

	@Override
	public List<HomeVo> getElec() { // List -> 길이 제한이 없음, 어떤 object든 다 넣기 가능 대신 어떤걸 담을 List인지 알려 줘야 됨 -> <HomeVo> : HomeVo를 담을 리스트
		return homeDao.getElec();	// arrayList -> arrayList가 List를 상속 받고 있음, 별 차이는 없다.
	}
}
