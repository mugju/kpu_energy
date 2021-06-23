package org.kpu.team7.persistence;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.kpu.team7.domain.EnvVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.SmartPlugVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SmartPlugDAOImpl implements SmartPlugDAO {

	@Autowired
	private SqlSession sqlSession;

	private static final String namespace = "org.kpu.team7.mappers.clientMapper";

	@Override
	public List<SmartPlugVO> readList(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		List<SmartPlugVO> dataList = new ArrayList<SmartPlugVO>();
		dataList = sqlSession.selectList(namespace + ".All", vo);
		return dataList;
	}

	@Override
	public List<EnvVO> readEnv(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		List<EnvVO> list = new ArrayList<EnvVO>();
		list = sqlSession.selectList(namespace + ".env",vo);
		return list;
	}

}
