package org.kpu.team7.service;

import org.kpu.team7.domain.ClientVO;

public interface ClientService {
	public ClientVO readClient(ClientVO vo) throws Exception;
	public int getStoreId(String name) throws Exception;
}
