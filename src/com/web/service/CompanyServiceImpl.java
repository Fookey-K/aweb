package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.web.dao.CompanyMstMapper;
import com.web.entity.CompanyMst;
import com.web.entity.dto.CmpAddUpdDto;
import com.web.entity.dto.CompanyMainDto;

@Service("companyService")
public class CompanyServiceImpl implements CompanyService {

	@Resource
	CompanyMstMapper  companyMstMapper;
	
	@Override
	public List<CompanyMst> initCmp() {
		List<CompanyMst> listCmp = companyMstMapper.selectCmpAll();
		return listCmp;
	}

	@Override
	public CompanyMst selectCmpById(String cmpid) {
		
		CompanyMst cmp = companyMstMapper.selectCmpById(cmpid);
		return cmp;
		
	}

	@Override
	public int save(CmpAddUpdDto dto) {
		int result = 0;
		//可以是新增也可以是修改
		if ("0".equals(dto.getMode())) {
			//此id在数据库中是否存在
			// 不存在 直接插入
			// 存在，报错
			CompanyMst mst = companyMstMapper.findCmpById(dto.getCmpid());
			if (mst == null) {
				result = companyMstMapper.insertCmp(dto);
			} else {
				result = -1;
			}
			
		} else {
			result = companyMstMapper.updateCmp(dto);
		}
		// TODO Auto-generated method stub
		return result;
	}

	@Override
	public int deleteCmpList(String[] cmpList) {
		int cnt = companyMstMapper.deleteCmpList(cmpList);
		return cnt;
	}

	@Override
	public int deleteCmp(String cmpid) {
		int cnt = companyMstMapper.deleteCmp(cmpid);
		return cnt;
	}

	@Override
	public int selectAcount(CompanyMainDto companyMainDto) {
		// TODO Auto-generated method stub
		return companyMstMapper.selectAcount(companyMainDto);
	}

	@Override
	public List<CompanyMst> selectCurPageCmp(CompanyMainDto companyMainDto) {
		// TODO Auto-generated method stub
		List<CompanyMst> list = companyMstMapper.selectCurPageCmp(companyMainDto);
		return list;
	}

}
