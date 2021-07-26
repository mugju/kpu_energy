package org.kpu.team7.service;

import org.kpu.team7.domain.ClientVO;
import org.kpu.team7.persistence.ClientDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClientServiceImpl implements ClientService {
	
	@Autowired
	private ClientDAO clientDao;
	 
	@Override
	public ClientVO readClient(ClientVO vo) throws Exception {
		// TODO Auto-generated method stub
		return clientDao.read(vo);
	}

	@Override
	public int getStoreId(String name) throws Exception {
		// TODO Auto-generated method stub
		return clientDao.storeId(name);
	}
	
}
