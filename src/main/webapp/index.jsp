<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
request.setAttribute("APP_PATH", request.getContextPath());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${APP_PATH }/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
 <script src="${APP_PATH }/static/js/jquery-3.2.1.min.js"></script>
 <script src="${APP_PATH }/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <div class="row">
 	<div class="col-md-12 col-md-offset-5">
		<h1>霸气无敌</h1>
	</div>
  </div>
  <div class="row">
 	<div class="col-md-4">
		<button class="btn btn-primary" id="emp_add_btn" onclick="showEmp()">新增</button>
		<button class="btn btn-danger">批量删除</button>
	</div>
  </div>
  <div class="row">
 	<div class="col-md-12">
		<table class="table"  id="emps_table">
			<thead>
				<tr>
					<th>number</th>
					<th>empName</th>
					<th>gender</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			
			</tbody>
		</table>
	</div>
  </div>
 <div class="row">
 	<div class="col-md-6" id="emps_nav_text">
	</div>
	<div class="col-md-6" id="emps_nav">

	</div>
  </div>
</div>



<!-- 员工新增 -->
<div class="modal fade" id="emp_add" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" id="addEmpForm">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName"	class="form-control" placeholder="empName">
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">Email</label>
		    <div class="col-sm-10">
		      <input type="email" name="email"	class="form-control"  placeholder="Email">
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      	<label class="radio-inline">
				  <input type="radio" name="gender"  value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender"  value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		    	<select class="form-control" name="dId">
		    	</select>
		    </div>
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick="saveEmp()">保存</button>
      </div>
    </div>
  </div>
</div>

<!-- 员工编辑-->
<div class="modal fade" id="emp_edit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" id="editEmpForm">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <p class="form-control-static" id="empName_edit"></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">Email</label>
		    <div class="col-sm-10">
		      <input type="email" id="email_edit" name="email"	class="form-control"  placeholder="Email">
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      	<label class="radio-inline">
				  <input type="radio" name="gender"  value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender"  value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		    	<select class="form-control" name="dId">
		    	</select>
		    </div>
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick="updateEmp.call(this)" id="update_button">更新</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
var  totalEmps;
var  currentPage;
$(function (){
	to_pageNum(1);
});

//加载第几页
function to_pageNum(pn){
	$.ajax({
		url:"${APP_PATH}/emps",
		type:"GET",
		data:"pn="+pn,
		success:function(tableData){
			console.info(tableData);
			bulid_emps_table(tableData);
			bulid_emps_nav(tableData);
			bulid_emps_nav_text(tableData);
		}
	 });
	
}

//构建表格
function bulid_emps_table(tableData){
	$("#emps_table tbody").empty();
	var emps=tableData.extend.pageInfo.list;
	$.each(emps,function(index,item){
		var htmlTemp = "<tr>";
			htmlTemp+="<td>"+(index+1)+"</td>";	
			htmlTemp+="<td>"+item.empName+"</td>";
			htmlTemp+="<td>"+(item.gender=='M'?"男":"女")+"</td>";
			htmlTemp+="<td>"+item.email+"</td>";
			htmlTemp+="<td>"+item.department.deptName+"</td>";
			htmlTemp+="<td><button class='btn btn-primary btn-sm'  onclick='showEditEmp("+item.empId+")'><span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>修改</button>  <button class='btn btn-danger btn-sm'  onclick='showDelEmp("+item.empId+")'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span>删除</button></td>";
			htmlTemp+="</tr>";
		$("#emps_table tbody").append(htmlTemp);				
	});
}
//构建导航
function bulid_emps_nav(tableData){
	$("#emps_nav").empty();
	var pageInfo=tableData.extend.pageInfo;
	var htmlTemp="<nav aria-label='Page navigation'>";
		htmlTemp+="<ul class='pagination'>";
	
		htmlTemp += "<li><a onclick='to_pageNum(1)'>首页</a></li>";
		
		$.each(pageInfo.navigatepageNums,function(index,item){
			if(item == pageInfo.pageNum){
				htmlTemp += "<li class='active'><a>"+item+"</a></li>";
			}else{
				htmlTemp += "<li><a onclick='to_pageNum("+item+")'>"+item+"</a></li>";
			}
		});
		
		htmlTemp += "<li><a onclick='to_pageNum("+pageInfo.pages+")'>未页</a></li>";
		
		htmlTemp+="</ul>";
		htmlTemp+="</nav>";
		$("#emps_nav").append(htmlTemp);	
	
}
//构建导航文字
function bulid_emps_nav_text(tableData){
	$("#emps_nav_text").empty();
	var pageInfo=tableData.extend.pageInfo;
	totalEmps = pageInfo.total;
	currentPage = pageInfo.pageNum;
	var htmlTemp = "当前"+pageInfo.pageNum+"页,总"+pageInfo.pages+"页,总共"+pageInfo.total+"条记录";
	$("#emps_nav_text").append(htmlTemp);		
}

//弹出新增人员框
function showEmp(){
	 //查询所有部门信息并显示在下拉列表中
	 $("#editEmpForm  select").empty();
		 $.ajax({
			url:"${APP_PATH}/depts",
			type:"GET",
			success:function(data){
				var deptList=data.extend.deptList;
				$.each(deptList,function(index,item){
					$("#addEmpForm  select").append("<option value="+item.deptId+">"+item.deptName+"</option>");
				});
			}
		 });
	 $("#emp_add").modal({
		 backdrop:"static"
	 });
}
//新增人员
function saveEmp(){
	$.ajax({
		url:"${APP_PATH}/emp",
		type:"POST",
		data:$("#addEmpForm").serialize(),
		success:function(result){
			$("#emp_add").modal('hide');
			to_pageNum(totalEmps);
		}
	 });
}
//更新人员
function updateEmp(){
	var id = $(this).attr("edit-id");
	$.ajax({
		url:"${APP_PATH}/emp/"+id,
		type:"PUT",
		data:$("#editEmpForm").serialize(),
		success:function(result){
			$("#emp_edit").modal('hide');
			to_pageNum(currentPage);
		}
	 });
}




//弹出编辑人员框
function showEditEmp(id){
	 //部门
	 $("#editEmpForm  select").empty();
	 $.ajax({
		url:"${APP_PATH}/depts",
		type:"GET",
		success:function(data){
			var deptList=data.extend.deptList;
			$.each(deptList,function(index,item){
				$("#editEmpForm  select").append("<option value="+item.deptId+">"+item.deptName+"</option>");
			});
		}
	 });
	//人员信息
	 $.ajax({
			url:"${APP_PATH}/emp/"+id,
			type:"GET",
			success:function(data){
				var emp = data.extend.emp;
				$("#empName_edit").text(emp.empName);
				$("#email_edit").val(emp.email);
				$("#editEmpForm  input[name=gender]").val([emp.gender]);
				$("#editEmpForm  select").val([emp.dId]);
			}
		 });
	$("#update_button").attr("edit-id",id);
	 $("#emp_edit").modal({
		 backdrop:"static"
	 });
}


//删除确认
function showDelEmp(empId){
	if(confirm("确定删除吗？")){
		$.ajax({
			url:"${APP_PATH}/emp/"+empId,
			type:"DELETE",
			success:function(data){
				to_pageNum(currentPage);
			}
		 });
	}
}



</script>
</body>
</html>