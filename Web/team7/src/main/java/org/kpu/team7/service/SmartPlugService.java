package org.kpu.team7.service;

import java.util.List;

import org.kpu.team7.domain.EnvVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.SmartPlugVO;

public interface SmartPlugService {
	List<SmartPlugVO> readDataList(InquireDateVO vo) throws Exception;
	List<EnvVO> readEnvList(InquireDateVO vo) throws Exception;
}
