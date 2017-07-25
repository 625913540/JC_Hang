package com.doocker.crm.controller.common;
/*
 * easyui 分页返回数据bean
 * */
public class EasyuiResult {
       //总条数
		private Long total;
	  
		//当前查询 出的记录数据
		private Object rows;
		
		//true表示业务成功(无错)false业务失败(服务器内部有误)
		private Boolean flag;
	
		//提示信息
		private String msg;
		
		public EasyuiResult(Long total,Object rows,Boolean flag,String msg){
			this.total = total;
			this.rows = rows;
			this.flag = flag;
			this.msg = msg;
		}

		public Long getTotal() {
			return total;
		}

		public void setTotal(Long total) {
			this.total = total;
		}

		public Object getRows() {
			return rows;
		}

		public void setRows(Object rows) {
			this.rows = rows;
		}

		public Boolean getFlag() {
			return flag;
		}

		public void setFlag(Boolean flag) {
			this.flag = flag;
		}

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}

		@Override
		public String toString() {
			return "EasyuiResult [total=" + total + ", rows=" + rows + ", flag=" + flag + ", msg=" + msg + "]";
		}
		
		
}
