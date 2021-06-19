package org.kpu.team7.persistence;

import org.kpu.team7.domain.ClientVO;

public interface ClientDAO {
	public ClientVO read(ClientVO vo) throws Exception;
	public int storeId(String name) throws Exception;
}
