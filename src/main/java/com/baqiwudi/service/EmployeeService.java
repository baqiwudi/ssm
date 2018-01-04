package com.baqiwudi.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baqiwudi.bean.Employee;
import com.baqiwudi.bean.EmployeeExample;
import com.baqiwudi.bean.EmployeeExample.Criteria;
import com.baqiwudi.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	
	
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}


	public void saveEmp(Employee emplyee) {
		employeeMapper.insertSelective(emplyee);
	}


	public Employee getEmp(Integer id) {
		Employee emp=	employeeMapper.selectByPrimaryKey(id);
		return emp;
	}


	public void updateEmp(@Valid Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}


	public void deleteEmp(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}
	
	
	/**
	 * 批量删除
	 * @param empIds
	 */
	public void deleteBatch(List<Integer> empIds) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(empIds);
		employeeMapper.deleteByExample(example);
	}

}
