package com.baqiwudi.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.baqiwudi.bean.Deptment;
import com.baqiwudi.bean.Employee;
import com.baqiwudi.dao.DeptmentMapper;
import com.baqiwudi.dao.EmployeeMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DeptmentMapper  deptmentMapper;
	@Autowired
	EmployeeMapper  employeeMapper;
	@Autowired
	SqlSession  sqlSession;
	
	
	
	@Test
	public void testCRUD() {
		
		//1.插入部门信息
		//deptmentMapper.insertSelective(new Deptment(null, "开发部"));
		//deptmentMapper.insertSelective(new Deptment(null, "测试部"));
		
		//2.插入员工数据
		//employeeMapper.insertSelective(new Employee(null, "jerry", "M", "123@qq.com", 1));
		
		//3.批量插入员工
		/*
		for (int i = 0; i < array.length; i++) {
			employeeMapper.insertSelective(new Employee(null, "jerry", "M", "123@qq.com", 1));
		}*/
		EmployeeMapper  mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
		String uuid=	UUID.randomUUID().toString().substring(0, 5)+"_"+i;
			mapper.insertSelective(new Employee(null, uuid, "M", uuid+"@qq.com", 1));
		}
		
		
	}
	
	
	
	
	
}
