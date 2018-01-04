package com.baqiwudi.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baqiwudi.bean.Employee;
import com.baqiwudi.bean.Msg;
import com.baqiwudi.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 删除员工
	 * 
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.DELETE)
	@ResponseBody
	public  Msg deleteEmp(@PathVariable("empId")Integer empId) {
		employeeService.deleteEmp(empId);
		return Msg.success();
		
	}
	
	
	/**
	 * 员工更新
	 * PUT请求需要在web.xml中添加过滤器
	 * 使用JSR303 校验
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public  Msg updateEmp(@Valid Employee employee,BindingResult result) {
		employeeService.updateEmp(employee);
		return Msg.success();
		
	}
	
	
	/**
	 * 保存员工
	 * 
	 * 使用JSR303 校验
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public  Msg saveEmps(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			List<FieldError> errors = 	result.getFieldErrors();
			for (FieldError fieldError : errors) {
				String field = fieldError.getField();
				String message =  fieldError.getDefaultMessage();
				System.out.println("错误字段："+field);
				System.out.println("错误提示："+message);
			}
			return Msg.fail();
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	
	/**
	 * 查询所有员工
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public  Msg getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//引入分页插件emps
		PageHelper.startPage(pn, 5);//页码、每页数量
		//startPage 后面紧跟的后面查询就是分页查询
		List<Employee> emps= employeeService.getAll();
		//pageInfo里面有详细信息.传入连续显示的页数
		PageInfo pageInfo = new PageInfo(emps,5);
		model.addAttribute("pageInfo", pageInfo);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 查询单个员工
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public  Msg getEmp(@PathVariable("id")Integer id) {
		//startPage 后面紧跟的后面查询就是分页查询
		Employee emp= employeeService.getEmp(id);
		return Msg.success().add("emp", emp);
	}
	
	
	
	
	/**
	 * 查询所有员工
	 * @return
	 */
	@RequestMapping("/emps2")
	public  String getEmps2(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//引入分页插件emps
		PageHelper.startPage(pn, 5);//页码、每页数量
		//startPage 后面紧跟的后面查询就是分页查询
		List<Employee> emps= employeeService.getAll();
		//pageInfo里面有详细信息.传入连续显示的页数
		PageInfo pageInfo = new PageInfo(emps,5);
		model.addAttribute("pageInfo", pageInfo);
		return "list";
	}
	
}
