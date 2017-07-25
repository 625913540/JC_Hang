package com.doocker.crm.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.doocker.crm.controller.common.EasyuiResult;
import com.doocker.crm.service.StaffService;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private StaffService staffService;
	
	@RequestMapping("list")
	@ResponseBody
	public EasyuiResult list(
			@RequestParam(value="staffName",required=false)String staffName,
			@RequestParam(value="page",defaultValue="1")Integer page,
			@RequestParam(value="rows",defaultValue="3")Integer rows
			){
		PageInfo<HashMap> selectAdminByPage = new PageInfo<HashMap>();
		try {
			selectAdminByPage = staffService.selectAdminByPage(staffName,page,rows);
		} catch (Exception e) {
			e.printStackTrace();
			return new EasyuiResult(0L,null,false,"sever error");
		}	
		return new EasyuiResult(selectAdminByPage.getTotal(),selectAdminByPage.getList(),true,"success");
	}
}
