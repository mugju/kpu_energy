package org.kpu.team7.service;

import java.util.List;

import org.kpu.team7.domain.EnvVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.SmartPlugVO;
import org.kpu.team7.persistence.SmartPlugDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SmarPlugtServiceImpl implements SmartPlugService {
	
	@Autowired
	private SmartPlugDAO smartPlugDao;
	
	@Override
	public List<SmartPlugVO> readDataList(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return smartPlugDao.readList(vo);
	}

	@Override
	public List<EnvVO> readEnvList(InquireDateVO vo) throws Exception {
		// TODO Auto-generated method stub
		return smartPlugDao.readEnv(vo);
	}

}
