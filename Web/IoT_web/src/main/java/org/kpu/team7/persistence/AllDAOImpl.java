package org.kpu.team7.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.kpu.team7.domain.ClientVO;
import org.kpu.team7.domain.EnvVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.ProductVO;
import org.kpu.team7.domain.SmartPlugVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AllDAOImpl implements AllDAO {

	@Autowired
	private SqlSession sqlSession;

	private static final String clientnamespace = "org.kpu.team7.mappers.clientMapper";
	private static final String envnamespace = "org.kpu.team7.mappers.envMapper";
	private static final String smartplugnamespace = "org.kpu.team7.mappers.smartplugMapper";

	@Override
	public ClientVO readClientData(ClientVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(clientnamespace + ".clientData", vo);
	}

	@Override
	public int getStoreId(String name) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(clientnamespace + ".storeId", name);
	}

	@Override
	public List<EnvVO> readEnvData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(envnamespace + ".envData", vo);
	}

	@Override
	public List<SmartPlugVO> readSmartPlugHourData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".smartPlugHourData", vo);
	}

	@Override
	public List<SmartPlugVO> readTotalHourAmpData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".totalHourAmpData", vo);
	}

	@Override
	public List<SmartPlugVO> readTotalHourAmpReductionData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".totalHourReductionAmpData", vo);
	}

	@Override
	public List<ProductVO> getProductName(int storeId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(clientnamespace + ".selectName", storeId);
	}

	@Override
	public int getProductId(String pName) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(clientnamespace + ".productName", pName);
	}

	@Override
	public List<SmartPlugVO> readTotalDayAmpData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		System.out.print("hello3");
		return sqlSession.selectList(smartplugnamespace + ".totalDayAmpData", vo);
	}

	@Override
	public List<SmartPlugVO> readTotalDayAmpReductionData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".totalDayReductionAmpData", vo);
	}

	@Override
	public List<SmartPlugVO> readSmartPlugDayData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".smartPlugDayData", vo);
	}

	@Override
	public List<SmartPlugVO> readSmartPlugMonthData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".smartPlugMonthData", vo);
	}

	@Override
	public List<SmartPlugVO> readTotalMonthAmpData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".totalMonthAmpData", vo);
	}

	@Override
	public List<SmartPlugVO> readTotalMonthAmpReductionData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(smartplugnamespace + ".totalMonthReductionAmpData", vo);
	}
}
