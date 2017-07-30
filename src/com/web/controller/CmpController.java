package com.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.entity.CompanyMst;
import com.web.entity.dto.CompanyMainDto;
import com.web.service.CompanyService;

@Controller
@RequestMapping("/cmp")
public class CmpController {

	final int pageCount = 10;

	@Autowired
	CompanyService companyService;

	@RequestMapping("/init.do")
	public String init(HttpServletRequest request,Model model) {
		CompanyMainDto companyMainDto  = new CompanyMainDto();
		companyMainDto.setCurPage(1);
		companyMainDto.setTotalPage(0);
		model.addAttribute("companyMainDto", companyMainDto);
		
		selectFirstPage(companyMainDto,model);
		return "companyMain";
	}


	@RequestMapping("/search.do")
	public String search(CompanyMainDto companyMainDto, Model model) {

		selectFirstPage(companyMainDto,model);

		return "companyMain";
	}

	@RequestMapping("/searchPage.do")
	public String searchPage(CompanyMainDto companyMainDto, Model model) {
		// 读取数据
		// 读取count(读取数据库)
		int cnt = companyService.selectAcount(companyMainDto);
		// 计算总页数
		int totalPage = (int) Math.ceil((double) cnt / pageCount);

		companyMainDto.setTotalPage(totalPage);
		model.addAttribute("companyMainDto", companyMainDto);
		// 计算开始行和结束行
		int beginCnt = pageCount * (companyMainDto.getCurPage() - 1) + 1;
		int endCnt = pageCount * companyMainDto.getCurPage();
		// 读取数据方法
		// 调用service
		// 条件： 机构ID,机构名称， 开始行，结束行
		companyMainDto.setBeginIndex(beginCnt);
		companyMainDto.setEndIndex(endCnt);
		List<CompanyMst> listCmp = companyService.selectCurPageCmp(companyMainDto);

		// List<CompanyMst> listCmp = new ArrayList<>();
		model.addAttribute("listCmp", listCmp);

		return "companyMain";
	}

	
	/**
	 * 查找第一页数据
	 * @param companyMainDto
	 * @param model
	 */
	private void selectFirstPage(CompanyMainDto companyMainDto, Model model) {
		// 读取数据
		// 读取count(读取数据库)
		int cnt = companyService.selectAcount(companyMainDto);
		// 计算总页数
		int totalPage = (int) Math.ceil((double) cnt / pageCount);
		
		System.out.println("totalPage:" + totalPage );

		List<CompanyMst> listCmp = null;
		if (totalPage != 0) {
			companyMainDto.setTotalPage(totalPage);
			companyMainDto.setCurPage(1);
			model.addAttribute("companyMainDto", companyMainDto);
			// 取第一页的数据
			companyMainDto.setBeginIndex(1);
			companyMainDto.setEndIndex(pageCount);
			listCmp = companyService.selectCurPageCmp(companyMainDto);
			
		}	else {
			companyMainDto.setTotalPage(0);
			companyMainDto.setCurPage(1);
			listCmp = new ArrayList<>();
		}
		model.addAttribute("listCmp", listCmp);
	}

}
