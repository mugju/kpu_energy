package org.kpu.team7.persistence;

import java.util.List;

import org.kpu.team7.domain.SmartPlugVO;

public interface SmartPlugDAO {
	public List<SmartPlugVO> readList(int id) throws Exception; 
}
