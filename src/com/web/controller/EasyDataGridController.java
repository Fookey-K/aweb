package com.web.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/easyDataGrid")
public class EasyDataGridController {
	
	@RequestMapping("/init.do")
	public String initPage(Model model) {
		return "EasyDataGrid";
	}
}
