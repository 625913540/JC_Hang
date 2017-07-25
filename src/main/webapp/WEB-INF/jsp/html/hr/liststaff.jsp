<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp"></jsp:include>
<div>
	<label>员工姓名</label>
	<input id="qstaffname" type="test">
	<input type="button" id="queryStaff" value="查询">
</div>
<!-- 创建easyui表格 -->
<table id="dg"></table>
<div id="addstaff">
	<label>姓名</label>
	<input id="istaffname"><br>
	<label>性别</label>
		<select id="istaffsex">
			<option value="1">男</option>
			<option value="0">女</option>
		</select><br>
	<label>生日</label>
	<input id="istaffbirthday" type="text" class="easyui-datebox"/><br>
	<label>入职时间</label>
	<input id="istaffentry" type="text" class="easyui-datebox" required="required"/><br>
	<label>部门</label>
		<select id="idept">
		
		</select> <br>	
	<label>职位</label>
		<select id="iposition">
			<option>--请选择--</option>
		</select><br>
	<input type="button" id="isave" value="保存">
</div>
<script type="text/javascript">
$(function(){
	$("#queryStaff").click(function(){
		var staffname = $("#qstaffname").val();
		$("#dg").datagrid({
			queryParams:{
				staffname:staffname
			}
		})
	})
	//获取所有的部门
	$.ajax({
		url:'dept/list.do',
		data:{rows:100},
		success:function(data){
			if(data.rows){
				//清空append中的option
				$("#idept").empty();
				//data.rows数组 $(data.rows)标称jquery对象 jquery的方式迭代
				$(data.rows).each(function(){
					//this 指的是 row里面每一条数据
					 $("#idept").append('<option value='+this.id+'>'+this.deptName+'</option>')
				})
				//默认选择第一个的时候初始化第一个部门的职位选择框
				$.ajax({
					url:'position/getPositionByDept.do',
					data:{deptId:data.rows[0].id},
					success:function(data){
						$("#iposition").empty();
						//data.rows数组 $(data.rows)标称jquery对象 jquery的方式迭代
						$(data.rows).each(function(){
							//this 指的是 row里面每一条数据
							 $("#iposition").append('<option value='+this.id+'>'+this.positionName+'</option>')
						})
					}
				})
			}
		}
	})
	//当你改变部门的时候 职位也应该改变 改变部门出发了select标签change事件
	$("#idept").change(function(){
		//获取最新的select值 选中部门的id
		var deptid = $("#idept").val();
		$.ajax({
			url:'position/getpositionByDept.do',
			data:{deptId:deptid},
			success:function(data){
				$("#iposition").empty();
				//data.rows数组 $(data.rows)标称jquery对象 jquery的方式迭代
				$(data.rows).each(function(){
					//this 指的是 rows里面每一条数据
					$("#iposition").append('<option value='+this.id+'>'+this.positionName+'</option>')
				})
			}
		})
	})
	//初始化 表格
	$("#dg").datagrid({
			url:'staff/list.do',  
			//{"id":1,"deptName":"人力资源部","birthday":"2017-06-01","sex":1,"positionId":1,
				//"staffName":"张1","entry":"2017-06-01","positionName":"人力资源主管"}
		    columns:[[    
		        {field:'id',title:'编号',width:100},    
		        {field:'staffName',title:'员工名称',width:100},    
		        {field:'sex',title:'性别',width:100,formatter: function(value){
																	if (value == '1'){
																		return '男';
																	} else if(value == '0') {
																		return '女';
																	}
																}	
					},    
		        {field:'birthday',title:'生日',width:100},    
		        {field:'entry',title:'入职日期',width:100},    
		        {field:'deptName',title:'部门名称',width:100},    
		        {field:'positionName',title:'职位',width:100},    
		    ]],
		    fit:true,
		    fitColumns:true,
		    singleSelect:true,
		    pagination:true,
		    toolbar:[{
		    			text:"增加",
						iconCls:'icon-add',
						handler:function(){
							$("#addstaff").dialog("open");
							//解除事件绑定
							$("#isave").unbind();
							//修改对话框标题
							$("#addstaff").dialog("setTitle","增加员工");
							//点击保存按钮 保存数据
							$("#isave").click(function(){
								var istaffname = $("#istaffname").val();
								var istaffsex = $("#istaffsex").val();
								var istaffbirthday = $("#istaffbirthday").datebox('getValue');
								var istaffentry = $("#istaffentry").datebox('getValue');
								var ipositionid = $("#iposition").val();
								$.ajax({
									url:'staff/add.do',
									data:{name:istaffname,sex:istaffsex,birthday:istaffbirthday,entry:istaffentry,positionId:ipositionid},
									success:function(data){
										if(data.flag){
											//重新加载（刷新）表格
											$("#dg").datagrid("reload");
											$("#addstaff").dialog("close");
										}
									}
								})
								
							});
						}
					},{
						text:"修改",
						iconCls:'icon-edit',
						handler:function(){
							//打开对话框
							$("#addstaff").dialog("open");
							//解除事件绑定
							$("#isave").unbind();
							//修改对话框标题
							$("#addstaff").dialog("setTitle","修改员工");
							//获取选中的的哪一行数据
							//{"id":1,"deptName":"人力资源部","birthday":"2017-06-01","sex":1,"positionId":1,
							//"staffName":"张1","entry":"2017-06-01","positionName":"人力资源主管"}
							var row = $("#dg").datagrid("getSelected");
							if(row){
								var istaffname = $("#istaffname").val(row.staffName);
								var istaffsex = $("#istaffsex").val(row.sex);
								var istaffbirthday = $("#istaffbirthday").datebox('setValue',row.birthday);
								var istaffentry = $("#istaffentry").datebox('setValue',row.entry);
								var idept = $("#idept").val(row.deptId);
								//ajax异步请求相当于java的一个这个线程要花费较长的时间 所有这个先处理的数据要等线程完成成后处理
								//处理的函数应该放在success这个函数里面
								$.ajax({
									url:'position/getPositionByDept.do',
									data:{deptId:row.deptId},
									success:function(data){
										$("#iposition").empty();
										//data.rows数组 $(data.rows)标称jquery对象 jquery的方式迭代
										$(data.rows).each(function(){
											//this z指的是 rows里面每一条数据
											$("#iposition").append('<option value='+this.id+'>'+this.positionName+'</option>')
										})
										//要等待只为选项初始化后再修改他的值
										var ipositionid = $("#iposition").val(row.positionId);
									}
								})
								
								$("#isave").click(function(){
									
									var istaffname = $("#istaffname").val();
									var istaffsex = $("#istaffsex").val();
									var istaffbirthday = $("#istaffbirthday").datebox('getValue');
									var istaffentry = $("#istaffentry").datebox('getValue');
									var ipositionid = $("#iposition").val();
									
									$.ajax({
										url:'staff/update.do',
										data:{id:row.id,name:istaffname,sex:istaffsex,birthday:istaffbirthday,entry:istaffentry,positionId:ipositionid},
										success:function(data){
											if(data.flag){
												//重新加载（刷新）表格
												$("#dg").datagrid("reload");
												$("#addstaff").dialog("close");
											}
										}
									})
								});
								
								
							
							}
						}
					},{
						text:"删除",
						iconCls:'icon-remove',
						handler:function(){
							//获取选中的那一行数据 返回值
							//{"id":1,"deptName":"人力资源部","birthday":"2017-06-01","sex":1,"positionId":1,
							//"staffName":"张1","entry":"2017-06-01","positionName":"人力资源主管"}
							var row = $("#dg").datagrid("getSelected");
							//如果有选中的行就执行ajax
							if(row){
								$.ajax({
									//删除部门的接口
									url:'staff/del.do',
									//饭送到借口的数据
									data:{id:row.id},
									//回调函数（请求响应回来后执行这个函数） data服务器相应的数据
									success:function(data){
										if(data.flag){
											//重新加载（刷新）表格
											$("#dg").datagrid("reload");
										}
									}
									
								})
							}
						}
					}]
	});
	
	$("#addstaff").dialog({
	    title: '增加员工',    
	    closed: true,    
	    cache: false,    
	    modal: true   
	})	
})
</script>


	