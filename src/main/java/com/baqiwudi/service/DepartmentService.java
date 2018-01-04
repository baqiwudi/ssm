package com.baqiwudi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baqiwudi.bean.Deptment;
import com.baqiwudi.dao.DeptmentMapper;

@Service
public class DepartmentService {
	@Autowired
	DeptmentMapper departmentMapper;
	
	
	public List<Deptment> getDepts() {
		return departmentMapper.selectByExample(null);
	}
}
