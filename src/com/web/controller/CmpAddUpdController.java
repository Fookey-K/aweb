package com.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.entity.CompanyMst;
import com.web.entity.dto.CmpAddUpdDto;
import com.web.service.CompanyService;

@Controller
@RequestMapping("/cmpAdd")
public class CmpAddUpdController {
	
	@Autowired
	CompanyService companyService;
	
	@RequestMapping("/init.do")
	public String init(HttpServletRequest request, Model model) {
		//从表里读取数据 （1：service--》dao -》db)
		String mode = request.getParameter("mode");
		String cmpid = request.getParameter("selCmpid");
		
		//用spring标签库时，初始化是需要设置
		//model.addAttribute("cmpAddUpdDto", new CmpAddUpdDto() );
		//修改
		if ("1".equals(mode)) {
			CompanyMst cmp = companyService.selectCmpById(cmpid);
			if (cmp !=null){
				request.setAttribute("cmpMst", cmp);
				
			} else{
				request.setAttribute("message", "没有取到合适的数据，请确认！");
			}
		} 
		//companyMain页面的初始
		return "companyAddUpd";
	}
	
	@RequestMapping("/save.do")
	public String save(CmpAddUpdDto  cmpAddUpdDto, Model model) {
		String rtnView="";
		//check处理
		
		int result = companyService.save(cmpAddUpdDto);
		System.out.println("abc");
		if (result == -1) {

			model.addAttribute("message", "已经存在此机构代码！");
			
			model.addAttribute("cmpMst",cmpAddUpdDto);
			
			//model.addAttribute("cmpAddUpdDto",cmpAddUpdDto); 

			rtnView = "companyAddUpd";
		} else {

			rtnView = "forward:/cmp/init.do";
		}
		

		//companyMain页面的初始
		return rtnView;
	}
	
	
	/*@RequestMapping("/cancel.do")
	public String cancel(CmpAddUpdDto  cmpAddUpdDto, Model model) {
		//companyMain页面的初始
		return "forward:/cmp/init.do";
	}
	*/
}
