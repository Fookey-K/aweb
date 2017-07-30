<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "form" uri="http://www.springframework.org/tags/form" %>
<% String base = request.getServletContext().getServletContextName();
   pageContext.setAttribute("basepath", base);
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/${basepath }/css/listPage.css">
<script type="text/javascript" src="/${basepath }/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="/${basepath }/js/pageNav.js"></script>
</head>
<body>
	<form id="cmpMain">
		<div id="condition" class="block_content">
			<table class="tableNoLine">
				<tr class="trNoLine">
					<td class="lableRight tdNoLine">机构编号：	</td>
					<td class="tdNoLine"><input type="text" name="cmpId" id="cmpId" value="${companyMainDto.cmpId}">	</td>
					<td class="lableRight tdNoLine">机构名称:	</td>
					<td class="tdNoLine"><input type="text" name="cmpName" id="cmpName" value="${companyMainDto.cmpName}">	</td>
					<td class="tdNoLine"> <button id="searchBtn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
					 	<input type="reset" value="清空"> 
					</td>
				</tr>
			</table>
		</div>
		<div id="dataList" class="block_content">
			<table>
				<tr class="trHead">
					<th>选择</th>
					<th>机构编号</th>
					<th>机构名称</th>
					<th>联系人</th>
					<th>电话</th>
					<th>传真</th>
					<th>地址</th>
					<th>删除</th>
				</tr> 
				<c:forEach items="${requestScope.listCmp }" var="cmp">
					<tr >
						<td><input type="checkbox" name="chkCmp" value="${cmp.cmpid }"></td>
						<td><a href="##" onclick="maintaince('${cmp.cmpid }', '1')">${cmp.cmpid }</a></td>
						<td>${cmp.cmpname }</td>
						<td>${cmp.contacts }</td>
						<td>${cmp.tel }</td>
						<td>${cmp.fax }</td>
						<td>${cmp.address }</td>
						<td><img alt="删除按钮" src="/${basepath }/img/del.jpg" 
						width="20" height="20" onclick="deleteCmp('${cmp.cmpid }')"></td>	
					</tr>
				</c:forEach>
			</table>
		</div>
		<div id="operator" class="block_content">
			<div id="operatorDiv" class="operatorDiv">
				<button id="testBtn" >ajax页面</button>
				<button id="easyBtn" >easyUI页面</button>
				<button id="easyBtn2" >easyUI页面2</button>
				<button id="add" onclick="maintaince('','0')">新增</button>
				<button id="update" >修改</button>
				<button id="delete">删除</button>
			</div>
			<div id="pageNavigation" class ="pageDiv"></div>
		</div>
		<input type="hidden" id="selCmpid" value="0" name="selCmpid">
		<input type="hidden" id="mode" value="0" name="mode">
		<input type="hidden" id="curPage" value="${companyMainDto.curPage}" name="curPage">
		<input type="hidden" id="totalPage" value="${companyMainDto.totalPage}" name="totalPage">
	</form>
	<script type="text/javascript">
		$(document).ready(function(){
			//创建分页条
			//导航栏 id: pngId
			var curPage = $("#curPage").val();
			var totalPage = $("#totalPage").val();
			createPageNavigation("pageNavigation",curPage, totalPage);
			
			//如果点击是前一页和后一页，我们需要哪些参数
			//
			var formId = "cmpMain";
			var action = "<c:url value='/cmp/searchPage.do' />"
			addPageEvent("pageNavigation",formId,action);
			
		});
		
		$("#testBtn").click(function(){
			
			var url = "<c:url value='/cmpAjax/init.do' />";    
			var form1 = $("#cmpMain"); 
			form1.attr("action",url);
			form1.submit();
		});
		
		$("#easyBtn").click(function(){
			var url = "<c:url value='/easyUI/init.do' />";    
			var form1 = $("#cmpMain"); 
			form1.attr("action",url);
			form1.submit();
		});
		
		//easyUI2按钮事件
		$("#easyBtn2").click(function(){
			
			var url = "<c:url value='/easyUI2/init.do' />"
			var form1 = $("#cmpMain"); 
			form1.attr("action",url);
			form1.submit();
		});
		
		//查询
		$("#searchBtn").click(function(){
			var url = "<c:url value='/cmp/search.do' />";    
			var form1 = $("#cmpMain"); 
			form1.attr("action",url);
			form1.submit();
		});
		
		//修改按钮的操作
		$("#update").click(function(){
			//获取选中的数据				
			//选择的数据行数， 没选，或多选
			var  cmpidSel= $("[name='chkCmp']:checked");
			if (cmpidSel.length==0){
				alert("请选择数据");
				return false;
			}
			if (cmpidSel.length > 1){
				alert("请选择单条数据，现在是多选");
				return false;
			}
			//var  cmpid= $("[name='chkCmp']:checked").val();
			var cmpid = $("[name='chkCmp']:checked").val();
			maintaince(cmpid,'1');

		}); 
		
		//删除按钮操作
		$("#delete").click(function(){
			//check
			var  cmpidSel= $("[name='chkCmp']:checked");
			if ( cmpidSel.length ==0) {
				alert("请选择删除数据后在点击删除！");
				return false;
			}
			var cfm = confirm("确定删除选中的数据吗？");
			if (!cfm ) {
				return false;
			} else {
				var url = "<c:url value='/cmp/delete.do' />";    
				var form1 = $("#cmpMain"); 
				form1.attr("action",url);
				form1.submit();
			}
			
		});
		 
		function maintaince(cmpid,mode) {
			$("#selCmpid").val(cmpid);
			$("#mode").val(mode);
		 	var url = "<c:url value='/cmpAdd/init.do' />";    
			var form1 = $("#cmpMain"); 
			form1.attr("action",url);
			form1.submit(); 
		}
		
		
		function deleteCmp(cmpid) {
			$("#selCmpid").val(cmpid);
			var url = "<c:url value='/cmp/deleteOne.do' />";    
			var form1 = $("#cmpMain"); 
			form1.attr("action",url);
			form1.submit();
			
		}
		
		 
	</script>
</body>
</html>