package org.kpu.team7.persistence;

import org.apache.ibatis.session.SqlSession;
import org.kpu.team7.domain.ClientVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ClientDAOImpl implements ClientDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace="org.kpu.team7.mappers.clientMapper";
	
	@Override
	public ClientVO read(ClientVO vo) throws Exception{
		ClientVO mvo = sqlSession.selectOne(namespace+".clientData",vo);
		return mvo;
	}

	@Override
	public int storeId(String name) throws Exception {
		// TODO Auto-generated method stub
		int store_id=sqlSession.selectOne(namespace+".storeId",name);
		return store_id;
	}
	
}
