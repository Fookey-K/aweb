package com.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.entity.CompanyMst;
import com.web.entity.dto.CompanyMainDto;
import com.web.service.CompanyService;

@Controller
@RequestMapping("/cmpAjax")
public class CmpAjaxController {
	
	final int pageCount = 3;
	
	@Autowired
	CompanyService companyService;

	
	@RequestMapping("/init.do")
	public String initPage() {
		return "companyMainAjax";
	}
	
	@RequestMapping("/search.do")
	@ResponseBody
	public Object search(HttpServletRequest request) {
		System.out.println("abc");
		String cmpid = request.getParameter("cmpId");
		String cmpName =request.getParameter("cmpName");
		CompanyMainDto companyMainDto = new CompanyMainDto();
		companyMainDto.setCmpId(cmpid);
		companyMainDto.setCmpName(cmpName);

		HashMap<String,Object>  map =  selectFirstPage(companyMainDto);
		System.out.println("def");
		return map;
	}
	
	
	@RequestMapping("/searchPage.do")
	@ResponseBody
	public Object searchPage(HttpServletRequest request) {
		HashMap<String,Object> map = new HashMap();
		
		String cmpid = request.getParameter("cmpId");
		String cmpName =request.getParameter("cmpName");
		int curPage = Integer.parseInt(request.getParameter("curPage"));
		CompanyMainDto companyMainDto = new CompanyMainDto();
		companyMainDto.setCmpId(cmpid);
		companyMainDto.setCmpName(cmpName);
		companyMainDto.setCurPage(curPage);
		// 读取数据
		// 读取count(读取数据库)
		int cnt = companyService.selectAcount(companyMainDto);
		// 计算总页数
		int totalPage = (int) Math.ceil((double) cnt / pageCount);
		//companyMainDto.setTotalPage(totalPage);
		map.put("totalPage", totalPage);
		System.out.println("searchPage:" + map.get("totalPage"));

		// 计算开始行和结束行
		int beginCnt = pageCount * (companyMainDto.getCurPage() - 1) + 1;
		int endCnt = pageCount * companyMainDto.getCurPage();
		// 读取数据方法
		// 调用service
		// 条件： 机构ID,机构名称， 开始行，结束行
		companyMainDto.setBeginIndex(beginCnt);
		companyMainDto.setEndIndex(endCnt);
		List<CompanyMst> listCmp = companyService.selectCurPageCmp(companyMainDto);
		map.put("listCmp", listCmp);
		
		
		return map;
	}
	
	/**
	 * 查找第一页数据
	 * @param companyMainDto
	 * @param model
	 */
	private HashMap<String,Object> selectFirstPage(CompanyMainDto companyMainDto) {
		
		HashMap<String,Object> map = new HashMap();
		// 读取数据
		// 读取count(读取数据库)
		int cnt = companyService.selectAcount(companyMainDto);
		// 计算总页数
		int totalPage = (int) Math.ceil((double) cnt / pageCount);
		map.put("totalPage", totalPage);
		

		List<CompanyMst> listCmp = null;
		if (totalPage != 0) {
			companyMainDto.setTotalPage(totalPage);
			companyMainDto.setCurPage(1);
			// 取第一页的数据
			companyMainDto.setBeginIndex(1);
			companyMainDto.setEndIndex(pageCount);
			listCmp = companyService.selectCurPageCmp(companyMainDto);
			
		}	else {
			companyMainDto.setTotalPage(0);
			companyMainDto.setCurPage(1);
			listCmp = new ArrayList<>();
		}
		
		map.put("listCmp", listCmp);
		
		return map;

	}

}
