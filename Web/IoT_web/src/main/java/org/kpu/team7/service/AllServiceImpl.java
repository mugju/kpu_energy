package org.kpu.team7.service;

import java.util.List;

import org.kpu.team7.domain.ClientVO;
import org.kpu.team7.domain.EnvVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.ProductVO;
import org.kpu.team7.domain.SmartPlugVO;
import org.kpu.team7.persistence.AllDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AllServiceImpl implements AllService {
	
	@Autowired
	private AllDAO dao;
	
	
	@Override
	public ClientVO confirmAccount(ClientVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readClientData(vo);
	}
	@Override
	public int getStoreId(String name) throws Exception {
		// TODO Auto-generated method stub
		return dao.getStoreId(name);
	}
	@Override
	public List<SmartPlugVO> readSmartPlugHourData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readSmartPlugHourData(vo);
	}
	@Override
	public List<EnvVO> readEnvList(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readEnvData(vo);
	}
	@Override
	public List<SmartPlugVO> readTotalHourAmpData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readTotalHourAmpData(vo);
	}
	@Override
	public List<SmartPlugVO> readTotalHourReductionAmpData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readTotalHourAmpReductionData(vo);
	}
	@Override
	public List<ProductVO> getProductName(int storeId) throws Exception {
		// TODO Auto-generated method stub
		return dao.getProductName(storeId);
	}
	@Override
	public int getProductId(String pName) throws Exception {
		// TODO Auto-generated method stub
		return dao.getProductId(pName);
	}
	@Override
	public List<SmartPlugVO> readTotalDayAmpData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readTotalDayAmpData(vo);
	}
	@Override
	public List<SmartPlugVO> readTotalDayAmpReductionData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readTotalDayAmpReductionData(vo);
	}
	@Override
	public List<SmartPlugVO> readSmartPlugDayData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readSmartPlugDayData(vo);
	}
	@Override
	public List<SmartPlugVO> readSmartPlugMonthData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readSmartPlugMonthData(vo);
	}
	@Override
	public List<SmartPlugVO> readTotalMonthAmpData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readTotalMonthAmpData(vo);
	}
	@Override
	public List<SmartPlugVO> readTotalMonthAmpReductionData(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.readTotalMonthAmpReductionData(vo);
	}
}
