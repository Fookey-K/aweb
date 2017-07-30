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
	<link rel="stylesheet" type="text/css" href="/${basepath }/easyUI/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/${basepath }/easyUI/themes/icon.css">
	<script type="text/javascript" src="/${basepath }/easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="/${basepath }/easyUI/jquery.easyui.min.js"></script>
	<script type="text/JavaScript" src="/${basepath }/easyUI/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<%-- <form id="cmpMain"> --%>
		<div id="condition" class="block_content">
			<table class="tableNoLine">
				<tr class="trNoLine">
					<td class="lableRight tdNoLine">机构编号：	</td>
					<td class="tdNoLine"><input type="text" name="cmpId" id="cmpId" >	</td>
					<td class="lableRight tdNoLine">机构名称:	</td>
					<td class="tdNoLine"><input type="text" name="cmpName" id="cmpName">	</td>
					<td class="tdNoLine"> <button id="searchBtn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
					 	<input type="reset" value="清空"> 
					</td>
				</tr>
			</table>
		</div>
		<div id="dataList" class="block_content">
			<table id="tblList">
				<tr class="trHead">
					<td>选择</td>
					<td>机构编号</td>
					<td>机构名称</td>
					<td>联系人</td>
					<td>电话</td>
					<td>传真</td>
					<td>地址</td>
					<td>删除</td>
				</tr> 
				
			</table>
		</div>
		<!-- <<div  class="block_content"> -->
			<div id="pp" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;"
			        data-options="total:0,pageSize:10">
			</div>
		<!--  </div> -->
		<input type="hidden" id="selCmpid" value="0" name="selCmpid">
		<input type="hidden" id="mode" value="0" name="mode">
		<input type="hidden" id="curPage" value="0" name="curPage">
		<input type="hidden" id="totalCount" value="0" name="totalCount">
		 <input type="hidden" id="listCmp" value='${listCmp }' name="listCmp"> 
	<%-- </form> --%>
	<script type="text/javascript">
		$(document).ready(function(){
			alert("##############");
			var totalCountx = <%=request.getAttribute("totalCount") %>;	
			
			var listCmpX =  eval("(" + $("#listCmp").val() + ")") ;		

			console.log(listCmpX);
				
			var data = {
					totalCount:totalCountx,
					pageSize:10,
					listCmp:listCmpX
			};
			dealSearch(data);
		});

		$("#searchBtn").click(function(){
			
			var urlx = "<c:url value='/easyUI2/search.do' />";
			var cmpIdx = $("#cmpId").val();
			var cmpNamex = $("#cmpName").val();
			var datax = {cmpId:cmpIdx,cmpName:cmpNamex};
			alert("aaa:" + cmpNamex);
			//发送请求
			$.ajax({
				url: urlx,
				data:datax,
				success:dealSearch,
				error:function(){
					alert("ajax失败");
				}	
			});
			
		});
		
		function dealSearch(data) {
			//
			//console.log(data);
			//显示列表当中的数据
			var cmpList = data.listCmp;
			showList(cmpList);
			
			var totalCount = data.totalCount;
			var pageSizeX =  data.pageSize;
			if (pageSizeX == "undefined") {
				pageSizeX = 10;
			}
			$("#totalCount").val(totalCount);
			
			$('#pp').pagination({
			    total:totalCount,
			    pageSize:pageSizeX
			});
			
		}
		
		$('#pp').pagination({
			
			//页标签的梳理
			onSelectPage:function(pageNumber, pageSize){
				$(this).pagination('loading');
				$(this).pagination('loaded');
				
				var urlx = "<c:url value='/easyUI2/searchPage.do' />";
				var cmpIdx = $("#cmpId").val();
				var cmpNamex = $("#cmpName").val();
				
				var datax = {cmpId:cmpIdx,cmpName:cmpNamex,curPage:pageNumber,pgSize:pageSize};
				
				//发送请求
				$.ajax({
					url: urlx,
					data:datax,
					success:dealSearch,
					error:function(){
						alert("ajax失败");
					}	
				});
			},
			
			//每页显示数量下拉列表框的处理
			onChangePageSize:function(pageSize) {
				//页面显示最大数量变化时，显示第一页
				$(this).pagination('loading');
				$(this).pagination('loaded');
				
				var urlx = "<c:url value='/easyUI2/searchPage.do' />";
				var cmpIdx = $("#cmpId").val();
				var cmpNamex = $("#cmpName").val();
				
				var datax = {cmpId:cmpIdx,cmpName:cmpNamex,curPage:1,pgSize:pageSize};
				//发送请求
				$.ajax({
					url: urlx,
					data:datax,
					success:dealSearch,
					error:function(){
						alert("ajax失败");
					}	
				});
				
			}
		});
		
		function showList(cmpList) {
			var x;
			var trStr;
			$(".trData").remove();
			for (x in cmpList) {
				trStr = "<tr class='trData'>";
				trStr += "<td><input type='checkbox' name='chkCmp' value='"+cmpList[x].cmpid+"'></td>"
					    + "<td><a href='##' onclick='maintaince('" + cmpList[x].cmpid + "', '1')>"
							+ cmpList[x].cmpid + "</a></td>"
							+ "<td>" + cmpList[x].cmpname + "</td>"
							+ "<td>" + cmpList[x].contacts + "</td>"
							+ "<td>" + cmpList[x].tel + "</td>"
							+ "<td>" + cmpList[x].fax + "</td>"
							+ "<td>" + cmpList[x].address + "</td>"
							+ "<td><img alt='删除按钮' src=<c:url value='/img/del.jpg'/>  width='20' height='20'"
							+ " onclick='deleteCmp('"+ cmpList[x].cmpid +"')></td>"
							+ "</tr>";		
			   $("#tblList").append(trStr);
			}
		}
		 
		
		 
	</script>
</body>
</html>