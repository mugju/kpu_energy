package org.kpu.team7.persistence;

import java.util.List;

import org.kpu.team7.domain.ClientVO;
import org.kpu.team7.domain.EnvVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.ProductVO;
import org.kpu.team7.domain.SmartPlugVO;

public interface AllDAO {
	public ClientVO readClientData(ClientVO vo) throws Exception;
	public int getStoreId(String name) throws Exception;
	public List<EnvVO> readEnvData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readSmartPlugHourData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readSmartPlugDayData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readSmartPlugMonthData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readTotalHourAmpData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readTotalHourAmpReductionData(InquireDateVO vo) throws Exception;
	public List<ProductVO> getProductName(int storeId) throws Exception;
	public int getProductId(String pName) throws Exception;
	public List<SmartPlugVO> readTotalDayAmpData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readTotalDayAmpReductionData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readTotalMonthAmpData(InquireDateVO vo) throws Exception;
	public List<SmartPlugVO> readTotalMonthAmpReductionData(InquireDateVO vo) throws Exception;
}
