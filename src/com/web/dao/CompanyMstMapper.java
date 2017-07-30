package com.web.dao;

import java.util.List;

import com.web.entity.CompanyMst;
import com.web.entity.dto.CmpAddUpdDto;
import com.web.entity.dto.CompanyMainDto;

public interface CompanyMstMapper {
	
	/**
	 * 取出公司信息，准备放入下拉列表
	 * @return
	 */
	List<CompanyMst> selectCmpForList();
	
	/**
	 * 取所有机构信息
	 * @return
	 */
	List<CompanyMst> selectCmpAll();
	
	/**
	 * 根据ID获取公司信息（未删除的）
	 * @param cmpid
	 * @return
	 */
	CompanyMst selectCmpById(String cmpid);
	
	
	/**
	 * 获取某个id的公司信息（包括删除的）
	 * @param cmpid
	 * @return
	 */
	CompanyMst findCmpById(String cmpid);
	
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	int insertCmp(CmpAddUpdDto dto);
	
	/**
	 * 修改数据
	 * @param dto
	 * @return
	 */
	int updateCmp(CmpAddUpdDto dto);
	
	/**
	 * 删除多条数据
	 * @param cmpList
	 * @return
	 */
	int deleteCmpList(String[] cmpList);
	
	/**
	 * 删除单条数据
	 * @param cmpid
	 * @return
	 */
	
	int deleteCmp(String cmpid);
	
	
	int selectAcount(CompanyMainDto companyMainDto);
	
	List<CompanyMst> selectCurPageCmp(CompanyMainDto companyMainDto);
}
