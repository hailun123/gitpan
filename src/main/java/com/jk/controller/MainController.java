package com.jk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("main")
public class MainController {
	
	@RequestMapping("main")
	public String main(){
		return "main/main";
	}
	
	@RequestMapping("north")
	public String north(){
		return "main/north";
	}
	
	@RequestMapping("south")
	public String south(){
		return "main/south";
	}
	
	@RequestMapping("home")
	public String home(){
		return "main/home";
	}
	
	@RequestMapping("adminInfo")
	public String adminInfo(){
		return "main/adminInfo";
	}
	
}
