<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp"></jsp:include>
<div>
	<label>部门名称</label>
	<input id="deptName">
	<input id="queryDept" type="button" value="查询">
</div>
<!-- 创建easyui表格 -->
<table id="dg"></table>
<div id="dlg">
	<form id="form1" action="#">
		<label>部门名称</label>
		<input id="ideptName">
		<input id="insertDept" type="button" value="保存">
	</form>
</div>
<script type="text/javascript">
$(function(){
	//点击查询按钮根据部门名称查询
	$("#queryDept").click(function(){
		var deptName = $("#deptName").val();
		if(deptName){
			$('#dg').datagrid({
				queryParams:{
					deptname:deptName
				}
			});
		}
	})
	//初始化表格
	$("#dg").datagrid({
		url:'dept/list.do',
		columns:[[
		      {field:'id',title:'ID',width:100},
		      {field:'deptName',title:'部门名称',width:100}  
		  ]],
		  fit:true,
		  fitColumns:true,
		  singleSelect:true,  //只选择一行
		  pagination:true,
		  toolbar:[{
			  		 text:"增加",
			  	     iconCls:'icon-add',
			  	     handler:function(){
			  	    	 $("#ideptName").val('');
			  	    	 //修改对话框的title标题
			  	    	  $("#dlg").dialog("setTitle","增加部门");
			  	    	 $("#dlg").dialog("open");
			  	    	 //保存按钮解除所有事件绑定
			  	    	 $("#insertDept").unbind();
			  	    	 //点击保存增加一个部门
			  	    	 $("#insertDept").click(function(){
			  	    		var ideptName = $("#ideptName").val(); 
			  	    		if(ideptName){
			  	    			$.ajax({
					  	 			//删除部门接口
					  	 			url:'dept/add.do',
					  	 			//反送到接口的数据
					  	 			data:{deptName:ideptName},
					  	 			//回调函数(请求响应回来之后执行这个函数)data服务器相应的数据
					  	 			success:function(data){
					  	 				if(data.flag){
					  	 					//重新加载表格(刷新)
					  	 					$("#dg").datagrid("reload");
					  	 					$("#dlg").dialog("close");
					  	 				}
					  	 			}
					  	 		 })
			  	    		}
			  	    	 })
			  	     }
		 	     },{
		 	    	 text:"修改",
		 		 	 iconCls:'icon-edit',
			  	  	 handler:function(){ 
			  	  		  //修改对话框的title标题
			  	    	  $("#dlg").dialog("setTitle","修改部门");
			  	    	  $("#dlg").dialog("open");
			  	    	  //保存按钮解除所有事件绑定
			  	    	  $("#insertDept").unbind();
			  	    	var row = $("#dg").datagrid("getSelected");
			  	    	if(row){
			  	    		//点击保存修改一部门
			  	    		 $("#ideptName").val(row.depaName);
			  	    		 $("#insertDept").click(function(){
			  	    			var ideptName = $("#ideptName").val(); 
			  	    			if(ideptName){
			  	    				$.ajax({
						  	 			//修改部门接口
						  	 			url:'dept/update.do',
						  	 			//发送到接口的数据
						  	 			data:{id:row.id,deptName:ideptName},
						  	 			//回调函数(请求响应回来之后执行这个函数)data服务器相应的数据
						  	 			success:function(data){
						  	 				if(data.flag){
						  	 					//重新加载表格(刷新)
						  	 					$("#dg").datagrid("reload");
						  	 					$("#dlg").dialog("close");			
						  	 				}
						  	 			}
						  	 		 })
			  	    			}
			  	    		 })
			  	    	}
			  	  		  
			  	  	 }
		    	 },{
		    		 text:"删除",
		    	 	 iconCls:'icon-remove',
			  	 	 handler:function(){
			  	 	 //获取选中的哪一行数据返回值{"id","deptName":"人力资源部"}
			  	 	 var row = $("#dg").datagrid("getSelected");
			  	 	 //如果选中的行就执行Ajax
			  	 	 if(row){
			  	 		 $.ajax({
			  	 			//删除部门接口
			  	 			url:'dept/del.do',
			  	 			//发送到接口的数据
			  	 			data:{id:row.id},
			  	 			//回调函数(请求响应回来之后执行这个函数)data服务器相应的数据
			  	 			success:function(data){
			  	 				if(data.flag){
			  	 					//重新加载表格(刷新)
			  	 					$("#dg").datagrid("reload");
			  	 					$("#dlg").dialog("close");
			  	 				}
			  	 			}
			  	 		 })
			  	 	 }
			  	}
		  }]
	})
});

	//初始化表单窗口
    $("#dlg").dialog({
    	title:"增加部门",
    	closed:true,
    	cache:false,
    	modal:true
    })
</script>

	