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

import com.alibaba.fastjson.JSON;
import com.web.entity.CompanyMst;
import com.web.entity.dto.CompanyMainDto;
import com.web.service.CompanyService;

@Controller
@RequestMapping("/easyUI2")
public class EasyUIController {
	
	@Autowired
	CompanyService companyService;

	/**
	 * 初期化处理
	 * @param model
	 * @return
	 */
	@RequestMapping("/init.do")
	public String initPage(Model model) {
		
		HashMap<String,Object> map = new HashMap();
		CompanyMainDto companyMainDto = new CompanyMainDto();
		companyMainDto.setCurPage(1);
		
		map = selectPageInfo(companyMainDto,10,1);
		
		model.addAttribute("totalCount", map.get("totalCount"));
		String listCmpJson =  JSON.toJSONString(map.get("listCmp"));
		model.addAttribute("listCmp", listCmpJson);
		
		model.addAttribute("listCmp", listCmpJson);
		return "EasyUI";
	}
	
	/**
	 * 查询按钮的操作
	 * @param request
	 * @return
	 */
	@RequestMapping("/search.do")
	@ResponseBody
	public Object search(HttpServletRequest request) {
		System.out.println("abc");
		String cmpid = request.getParameter("cmpId");
		String cmpName =request.getParameter("cmpName");
		CompanyMainDto companyMainDto = new CompanyMainDto();
		companyMainDto.setCmpId(cmpid);
		companyMainDto.setCmpName(cmpName);
		System.out.println("~search~~~:" + cmpName);

		HashMap<String,Object>  map =  selectPageInfo(companyMainDto,10,1);
		System.out.println("def");
		return map;
	}
	
	/**
	 * 页标签处理
	 * @param request
	 * @return
	 */
	@RequestMapping("/searchPage.do")
	@ResponseBody
	public Object searchPage(HttpServletRequest request) {
		HashMap<String,Object> map = new HashMap();
		
		String cmpid = request.getParameter("cmpId");
		String cmpName =request.getParameter("cmpName");
		int curPage = Integer.parseInt(request.getParameter("curPage"));
		int pageSize = Integer.parseInt(request.getParameter("pgSize"));
		
		CompanyMainDto companyMainDto = new CompanyMainDto();
		companyMainDto.setCmpId(cmpid);
		companyMainDto.setCmpName(cmpName);
		
		map = selectPageInfo(companyMainDto,pageSize,curPage);
		
		return map;
	}
	
	/**
	 * 查找第一页数据
	 * @param companyMainDto
	 * @param model
	 */
	private HashMap<String,Object> selectPageInfo(CompanyMainDto companyMainDto,
			int pageSize, int curPage) {
		
		HashMap<String,Object> map = new HashMap();
		// 读取数据
		// 读取count(读取数据库)
		int cnt = companyService.selectAcount(companyMainDto);
		
		System.out.println("==>total" + cnt);
		
		map.put("pageSize", pageSize);
		map.put("totalCount", cnt);
		
		List<CompanyMst> listCmp = null;
		if (cnt != 0) {
			//companyMainDto.setTotalPage(totalPage);
			companyMainDto.setCurPage(curPage);
			// 取当前的数据
			int beginCnt = pageSize * (curPage - 1) + 1;
			int endCnt = pageSize * curPage;
			
			companyMainDto.setBeginIndex(beginCnt);
			companyMainDto.setEndIndex(endCnt);
			
			System.out.println("==>:"+ companyMainDto.getCmpName());
			listCmp = companyService.selectCurPageCmp(companyMainDto);
			
		}	else {
			//companyMainDto.setTotalPage(0);
			companyMainDto.setCurPage(1);
			listCmp = new ArrayList<>();
		}
		System.out.println(listCmp.size());
		
		map.put("listCmp", listCmp);
		
		return map;
	}
	
	
}
