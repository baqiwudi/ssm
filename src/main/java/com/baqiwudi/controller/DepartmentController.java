package com.baqiwudi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baqiwudi.bean.Deptment;
import com.baqiwudi.bean.Msg;
import com.baqiwudi.service.DepartmentService;
import com.baqiwudi.service.EmployeeService;

@Controller
public class DepartmentController {

		@Autowired
		DepartmentService departmentService;
		
		/**
		 * 查询所有员工
		 * @return
		 */
		@RequestMapping("/depts")
		@ResponseBody
		public Msg getDepts() {
			List<Deptment> deptList = 	departmentService.getDepts();
			return Msg.success().add("deptList", deptList);
		}
	
}
