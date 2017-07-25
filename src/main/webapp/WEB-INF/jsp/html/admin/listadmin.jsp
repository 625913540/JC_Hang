<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp"></jsp:include>
<div>
	<label>管理员姓名</label>
	<input id="qsname">
	<input type="button" id="query" value="查询">
</div>
<table id="dg"></table>
<script type="text/javascript">
	$(function(){
		$("#query").click(function(){
				var sname = $("#qsname").val();
				if(sname){
					$("#dg").datagrid({
						queryParams:{
							staffName:sname
						}
					})
				}
		})
		//初始化表格
		$("#dg").datagrid({
			url:'admin/list.do',
			columns:[[
				      {field:'sid',title:'管理员编号',width:100},
				      {field:'sname',title:'管理员姓名',width:100},
				      {field:'pname',title:'职位',width:100},
				      {field:'susername',title:'管理员登录名',width:100},
				      {field:'rname',title:'角色名称',width:100},    
				      {field:'rdesc',title:'角色描述',width:100}
				  ]],
			fit:true,
			fitColumns:true,
			singleSelect:true,  //只选择一行
			pagination:true,	  
		})
	})
</script>


	