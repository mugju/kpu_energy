package com.testSpring.dao;

import java.util.List;

//import org.apache.ibatis.session.SqlSessionFactory;  이거 안쓴다고 경고 줘서 일단 주석, 추후 쓰일 수 있음
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.testSpring.model.HomeVo;
//Repository -> 저장소라는 뜻

@Repository						// 리포지터리는 이 공간이 다오라는 것을 인식시켜주기 위해 표기하는 어노테이션
public class HomeDaoImpl implements HomeDao{
//impl > implements(구현하다)의 약어
// 원래 인터페이스에서는 이러 이러한 것을 구현할 것이다 라고 정해 놓는 것
//실제 구현은 임플레먼트 클래스 안에서 구현

	 @Autowired SqlSessionTemplate sqlSession; 		// 맵퍼에 접근해주기 위한 클래스를 생성해줌 SqlSessionTemplate sqlSession;
	 // SqlSessionFactory를 Autowired 해주면 알아서 자동으로 연결해주도록 설정하는 것
	
	 @Override
	 public List<HomeVo> test() {
		 return sqlSession.selectList("com.testSpring.homeTest");
		 //sqlSession.selectOne -> sqlSession(mapper에 접근하는 객체)으로 mapper에 접근할 수  있음 selectOne -> 결과가 하나 일 때 그 하나를 가져온다. 결과가 여러개일 때는 selectList
		 // com.testSpring -> 이거는 home_mapper.xml의 namespace가 동일해야 한다. , home_mapper안의 homeTest를 지목
		 
	 }

		/*
		 * public HomeVo test() { return
		 * sqlSession.selectOne("com.testSpring.homeTest");
		 *  //sqlSession.selectOne -> sqlSession(mapper에 접근하는 객체)으로 mapper에 접근할 수 있음 selectOne -> 결과가 하나 일 때 그 하나를 가져온다. 
		 *  결과가 여러개일 때는 selectList // com.testSpring -> 이거는 home_mapper.xml의 namespace가 동일해야 한다. , home_mapper안의 homeTest를 지목
		 * 
		 * }
		 */
	 @Override
	 public List<HomeVo> getElec() { // List -> 길이 제한이 없음, 어떤 object든 다 넣기 가능 대신 어떤걸 담을 List인지 알려 줘야 됨 -> <HomeVo> : HomeVo를 담을 리스트
		return sqlSession.selectList("com.testSpring.getElecStat");
		}

	
}
