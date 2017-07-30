package com.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("test")
public class TestController {
	
	@RequestMapping("/search.do")
	public String search(@ModelAttribute("ABC") Model model) {
		return "";
	}
}
