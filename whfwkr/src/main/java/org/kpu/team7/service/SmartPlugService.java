package org.kpu.team7.service;

import java.util.List;

import org.kpu.team7.domain.SmartPlugVO;

public interface SmartPlugService {
	List<SmartPlugVO> readDataList(int id) throws Exception;
}
