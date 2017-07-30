package com.web.service;

import java.util.List;

import com.web.entity.CompanyMst;
import com.web.entity.dto.CmpAddUpdDto;
import com.web.entity.dto.CompanyMainDto;

public interface CompanyService {
	
	List<CompanyMst> initCmp();
	
	CompanyMst selectCmpById(String cmpid);
	
	int save(CmpAddUpdDto dto );
	
	int deleteCmpList(String[] cmpList);
	
	int deleteCmp(String cmpid);
	
	int selectAcount(CompanyMainDto  companyMainDto);
	
	
	List<CompanyMst> selectCurPageCmp(CompanyMainDto  companyMainDto);
	
}
