<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String base = request.getServletContext().getServletContextName();
   pageContext.setAttribute("basepath", base);
   %>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="/${basepath }/easyUI/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/${basepath }/easyUI/themes/icon.css">
	<script type="text/javascript" src="/${basepath }/easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="/${basepath }/easyUI/jquery.easyui.min.js"></script>
	<script type="text/JavaScript" src="/${basepath }/easyUI/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<table id="tb1" class="easyui-datagrid" style="width:1160px;height:450px;"
		data-options="rownumbers:true
					 <!-- ,singleSelect:true -->
					 ,pagination:true,
					 pageSize:10">
		<thead>
			<tr>			
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'cmpid',width:120,align:'center'">机构编号</th>
				<th data-options="field:'cmpname',width:300,align:'center'">机构名称</th>
				<th data-options="field:'contacts',width:120,align:'center'">联系人</th>
				<th data-options="field:'tel',width:150,align:'center'">电话</th>
				<th data-options="field:'fax',width:150,align:'center' ">传真</th>
				<th data-options="field:'address',width:200,align:'center'">地址</th>
			</tr> 
		</thead>
	</table>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var urlx = "<c:url value='/easyUI2/search.do' />"; 
			var vCmpId ="";
			var vCmpName ="";
			$.ajax({
				url:urlx,
				data: {cmpId:vCmpId,cmpName:vCmpName},
				success:searchSuccess,
				error:function(XMLHttpRequest, textStatus, errorThrown) {
					alert("ajax出错");
				}
			});		
		});
		
		function searchSuccess(datax) {
			console.log(datax);
			$('#tb1').datagrid({
				loadMsg:"数据获取中",
				data:datax.listCmp,
				pageNum:1
			});
			$('#tb1').datagrid({loadFilter:pagerFilter}).datagrid('load');
		}
		
		
		
		function pagerFilter(data){
			if (typeof data.length == 'number' && typeof data.splice == 'function'){
				data = {
					total: data.length,
					rows: data
				}
			}
			
			var dg = $(this);
			var opts = dg.datagrid('options');
			var pager = dg.datagrid('getPager');
			pager.pagination({
				onSelectPage:function(pageNum, pageSize){
					opts.pageNumber = pageNum;
					opts.pageSize = pageSize;
					pager.pagination('refresh',{
						pageNumber:pageNum,
						pageSize:pageSize
					});
					dg.datagrid('loadData',data);
				}
			});
			if (!data.originalRows){
				data.originalRows = (data.rows);
			}
			var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
			var end = start + parseInt(opts.pageSize);
			
			console.log("start:" + start + " end:" + end);
			data.rows = (data.originalRows.slice(start, end));
			return data;
		}
		
	
	</script>

</body>
</html>