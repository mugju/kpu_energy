package org.kpu.team7.persistence;

import java.util.List;

import org.kpu.team7.domain.EnvVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.SmartPlugVO;

public interface SmartPlugDAO {
	public List<SmartPlugVO> readList(InquireDateVO vo) throws Exception; 
	public List<EnvVO> readEnv(InquireDateVO vo) throws Exception;
}
