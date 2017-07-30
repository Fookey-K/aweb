package com.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.entity.CompanyMst;
import com.web.service.LoginService;


@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;

	@RequestMapping("/login.do")
	public String doLogin(HttpServletRequest request) {
		//此处要调用service
		List<CompanyMst> listCmp = loginService.selectCmpForList();
		request.setAttribute("listCmp", listCmp);
	
		return "login";
	}
	
	
	@RequestMapping("/userLogin.do")
	public String userLogin(HttpServletRequest request) {
		//此处要调用service
		//获取页面传递的参数
		String cmpId = request.getParameter("cmp");
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		//调用service，确定输入的用户名，密码是否正确
		int checkResult= loginService.checkUser(cmpId, userId, password);
		String view = "";
		if (checkResult == 0) {
			request.setAttribute("message", "用户名或密码不正确，请重新输入");
			view = "forward:/index.jsp";
		} else {
			//view = "forward:/cmp/init.do";
			view = "EasyUILayout";
		}
		return view;
	}
	

}
