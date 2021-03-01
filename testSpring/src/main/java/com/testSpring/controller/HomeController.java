package com.testSpring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;  // HomeService를 @Autowired 하기 위해 선언 Autowired 작성하면 자동 임폴트
import org.springframework.stereotype.Controller;		// @Controller 선언하기 위해 임폴트  @Controller 작성하면 자동 임폴트
import org.springframework.ui.Model;				// Model 선언하면 자동 임폴트
import org.springframework.web.bind.annotation.RequestMapping;  // @RequestMapping 컨 쉽 O 하면 두개다 자동 생성 됨?
import org.springframework.web.bind.annotation.RequestMethod;

import com.testSpring.model.HomeVo;
import com.testSpring.service.HomeService;
// ctrl + shift + O -> 자동으로 클래스를 import 해주는 단축키 [매우 중요]

@Controller     // @Controller -> 어노테이션이라고 한다. 바로 아래줄과 띄어져 있으면 작동 안되니까 주의하도록 하자. 이 공간이 컨트롤러임을 인식시켜주는 어노테이션
public class HomeController { //@Controller: 원하는 곳에 주소 맵핑을 해주는 것                      이게 매우 중요/이게 있어야 @RequestMapping 을 지정해줄 수 있다.
	@Autowired// 알아서 홈 컨트롤러에서 홈 서비스를 쓸 수 있게 연결해주는 설정
	HomeService homeService;  // 실제 homeService의 구현은 HomeServiceImpl에서 해주지만 객체 생성은 그냥 homeService로 해줘도 되는듯 하다. HomeServiceImpl는 그냥 homeService의 기능을 대신 구현하는 느낌
	
	@RequestMapping(value="/test", method = RequestMethod.GET) //RequestMapping 주소와 통신 방식을 지정한다. ->  일치할 때 이 함수로 오게끔 설정 // @는 아래 줄백이 있으면 안됨
	public String test(Model model) { // 모델은 여기서 선언한 건데 -> 화면(test1.jsp)에서 변수 사용이 필요하다. -> Model 사용, 사용 안한다 ->  Model 필요 없음 , Model은 변수를 넣어주기 위해 존재

        System.out.println("eeeeddddd"); // 혹시 오류가 났을 경우 이 페이지에 들어왔는지 유무를 확인하기 위해서 콘솔에 ddddd 를 띄움 


        int num = 3 + 20;
        
        List<HomeVo> homeVo = homeService.test();
        //HomeVo homeVo = homeService.test(); //homeService.test(): 서비스 -> 다오 -> 홈 맵퍼 순으로 가서 db에서 데이터 받아옴
        
        
        List<HomeVo> homeList = homeService.getElec();

        model.addAttribute("num", num); //addAttribute: 화면에서 쓸 변수를 넣어준다. "num" -> 화면에서 쓸 변수,  num -> int num = 3 + 20; 에서 num
        model.addAttribute("homeVo", homeVo); //왼쪽의 "homeVo"는 views 에서 쓸 변수명이고, 오른쪽의 homeVo는 HomeVo homeVo = homeService.test();에서 homeVo이다.
        model.addAttribute("homeList", homeList);
        
		return "test1"; // test1.jsp 로 이동하는 느낌
		//이동 할때 모델들이 같이 간다.
		
		
	}
	
}
