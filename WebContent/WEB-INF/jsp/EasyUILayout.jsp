<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String base = request.getServletContext().getServletContextName();
   pageContext.setAttribute("basepath", base);
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="/${basepath }/easyUI/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/${basepath }/easyUI/themes/icon.css">
	<script type="text/javascript" src="/${basepath }/easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="/${basepath }/easyUI/jquery.easyui.min.js"></script>
	<script type="text/JavaScript" src="/${basepath }/easyUI/easyui-lang-zh_CN.js"></script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" 
		style="height:60px;background:#B3DFDA;padding:10px">
		综合练习
	</div>
	<div data-options="region:'west',split:true,title:'West'" 
		style="width:180px;padding:2px;">
		<div  id ="divMenu" class="easyui-accordion" data-options="fit:true,border:false">
				<div title="机构管理" data-options="selected:true" style="padding:2px;">
					 <ul>
						<li><a href="##" onclick="addTab('机构一览','/${basepath}/cmp/init.do')">机构一览</a></li>
						<li><a href="##" onclick="addTab('机构一览easyUI','/${basepath}/easyDataGrid/init.do')">机构一览easyUI</a>	</li>
					</ul>			
				</div>
				<div title="用户管理"  style="padding:5px;">
					用户管理
				</div>

		</div>
	</div>
	<!-- <div data-options="region:'east',split:true,collapsed:false,title:'East'" 
		style="width:100px;padding:10px;">east region</div>  -->
	<div data-options="region:'south',border:false" 
		style="height:50px;background:#A9FACD;padding:10px;">
		没有任何版权，随便使用
	</div>
	<div  id="centerDiv" data-options="region:'center',title:'Center'">
		<div id ="tabDiv" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
			<div title="About" data-options="closable:true" style="padding:10px"></div>
			<div title="Main" data-options="closable:true" style="padding:10px">
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			var i = 0;
			var newMenu = '<ul>'
			for (;i <5; i++) {
				newMenu = newMenu + '<li><a href="##" onclick="addTab(\'test' + i + '\',\'/${basepath}/cmp/init.do\')" >test' + i +  '</a></li>';
				//newMenu = newMenu + '<li><a href="##" onclick="addTab(\'' + 菜单名称 + '\',\'' + 请求路径 + '\')">'+ 菜单名称  +'</a></li>'
			}
			newMenu = newMenu + "</ul>";
			//alert(newMenu);
			$("#divMenu").accordion("add",{
				title:"testTile",
				content:newMenu
			});
			newMenu = "";
			
		});
		
		function addTab(title,url) {
			if ($('#tabDiv').tabs('exists', title)){
				$('#tabDiv').tabs('select', title);
			} else {
				var content = '<iframe scrolling="auto" frameborder="0"  src="'+ url
					+ '" style="width:100%;height:100%;"></iframe>';
				$('#tabDiv').tabs('add',{
					title:title,
					content:content,
					closable:true
				});
			}
			
		}
	</script>
</body>
</html>