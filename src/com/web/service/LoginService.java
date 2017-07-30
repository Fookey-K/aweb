package com.web.service;

import java.util.List;

import com.web.entity.CompanyMst;

public interface LoginService {
	
	List<CompanyMst> selectCmpForList();
	
	int checkUser(String cmpId,String userId,String password);
}
