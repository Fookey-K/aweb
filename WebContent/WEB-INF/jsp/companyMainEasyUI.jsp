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
		<div id="pp" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;"
		        data-options="total:2000,pageSize:10">
		</div>

		<input type="hidden" id="selCmpid" value="0" name="selCmpid">
		<input type="hidden" id="mode" value="0" name="mode">
		<input type="hidden" id="totalCount" value="${totalCount }" name="totalCount">
		<input type="hidden" id="cmpList" value="${listCmp }" name="totalCount">
		<input type="hidden" id="curPage" value="0" name="curPage">
		
	<%-- </form> --%>
	<script type="text/javascript">
		$(document).ready(function(){
			
			var cmpListX = $("#cmpList").val();
			var totalCountX = eval("("+ $("#totalCount").val() + ")");
			var data = {
					totalCount: totalCountX,
					listCmp:cmpListX
			};			
			searchSuccess(data);
		});
			
		//查询
		 $("#searchBtn").click(function(){
			 alert("abc");	
			var urlx = "<c:url value='/easyUI/search.do' />"; 
			var vCmpId = $("#cmpId").val();
			var vCmpName = $("#cmpName").val();
				
			$.ajax({
				url:urlx,
			    data: {cmpId:vCmpId,cmpName:vCmpName},
				success:searchSuccess,
				error:function(XMLHttpRequest, textStatus, errorThrown) {
					console.log("aa" + XMLHttpRequest);
					console.log("bb" + textStatus);
					console.log("cc" + errorThrown);
					alert("ajax出错");
				}
			});
			
		});
		
		function searchSuccess(data) {
			console.log("aaa");
			console.log(data);
			var totalCount = data.totalCount;
			$("#totalCount").val(totalCount);
			
			var vPageSize = data.pageSize;
			if (vPageSize == "undefinded") {
				vPageSize = 10;
			}
			var curPage  = $("#curPage").val();
			if (curPage == 0) {
				curPage =1;
			}
			var cmpList = data.listCmp;
			//显示数据
			showList(cmpList);	
			
			$('#pp').pagination({
			    total:totalCount,
			    pageSize:vPageSize
			});
		}
		
		$('#pp').pagination({
			onSelectPage:function(pageNumber, pageSize){
				$(this).pagination('loading');
				$(this).pagination('loaded');
				$("#curPage").val(pageNumber);
				
				var urlx = "<c:url value='/easyUI/searchPage.do' />";
				
				var vcmpId = $("#cmpId").val();
				var vcmpName = $("#cmpName").val();	
				var vdata = {cmpId:vcmpId,
							cmpName:vcmpName,
							curPage:pageNumber,
							pgSize:pageSize};

				$.ajax({
					url: urlx,
					data:vdata,
					success:searchSuccess,
					error:function(XMLHttpRequest, textStatus, errorThrown) {
						console.log("aa" + XMLHttpRequest);
						console.log("bb" + textStatus);
						console.log("cc" + errorThrown);
						alert("ajax出错");
					}
				});
			},
		
			onChangePageSize:function(pageSize) {
				$(this).pagination('loading');
				$(this).pagination('loaded');
				
				$("#curPage").val(1);
				
				var urlx = "<c:url value='/easyUI/searchPage.do' />";
				var vcmpId = $("#cmpId").val();
				var vcmpName = $("#cmpName").val();	
				var vdata = {cmpId:vcmpId,
							cmpName:vcmpName,
							curPage:1,
							pgSize:pageSize};
				
				$.ajax({
					url: urlx,
					data:vdata,
					success:searchSuccess,
					error:function(XMLHttpRequest, textStatus, errorThrown) {
						console.log("aa" + XMLHttpRequest);
						console.log("bb" + textStatus);
						console.log("cc" + errorThrown);
						alert("ajax出错");
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