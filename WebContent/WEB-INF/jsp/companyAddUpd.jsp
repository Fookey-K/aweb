<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String base = request.getServletContext().getServletContextName();
   pageContext.setAttribute("basepath", base);
   %>
<%@ taglib prefix = "form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/${basepath }/js/jquery-3.1.1.js"></script>
</head>
<body>
	<%-- <form:form modelAttribute="cmpAddUpdDto" >
		<!-- path：和dto当中的属性名 -->
		<form:input path="cmpid"/>
	</form:form>   --%>
	<form method="GET"  id="form1">
		<div id="condition" class="block_content">
			<label id="msg"> ${message }</label>
			<table>
				<tr>
					<!-- disabled的项目的值无法提交到服务器端 -->
					<td class="lableRight">机构编号：</td>
					<td><input type="text" name="cmpid" id="cmpid" value="${cmpMst.cmpid}"
						<c:if test="${param.mode == '1' }">
							readonly
						</c:if>	
					    maxlength="5" ></td>
				</tr>
				<tr>
					<td  class="lableRight">机构名称：</td>
					<td><input type="text" name="cmpname" id="cmpname" value="${cmpMst.cmpname}" 
						maxlength="20"></td>
				</tr>
				<tr>
					<td  class="lableRight">联系人：</td>
					<td><input type="text" name="contacts" id="contacts" 
							value="${cmpMst.contacts}" maxlength="10"></td>
				</tr>
				<tr>
					<td  class="lableRight">电话：</td>
					<td><input type="text" name="tel" id="tel" value="${cmpMst.tel}" 
						maxlength="12"></td>
				</tr>
				<tr>
					<td  class="lableRight">传真：</td>
					<td><input type="text" name="fax" id="fax"  value="${cmpMst.fax}"
						maxlength="12"></td>
				</tr>
				<tr>
					<td  class="lableRight">地址：</td>
					<td><input type="text" name="address" id="address" value="${cmpMst.address}"
						maxlength="30"></td>
				</tr>
			</table>
			<div>
				<button id="save">保存</button>
				<button id="cancel">取消</button>
			</div>
			
		</div>
		<input type="hidden" id="mode" value="${param.mode }" name="mode">
	</form>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#save").click(function(){
				alert("abc");
				if (!check()) {
					return false;
				};
				alert("def");
				var url = "<c:url value='/cmpAdd/save.do' />" ;
				var form1 = $("#form1");
				form1.attr("action",url);
				form1.submit();	
			});
			
			$("#cancel").click(function(){
				var url = "<c:url value='/cmp/init.do' />" ;
				var form1 = $("#form1");
				form1.attr("action",url);
				form1.submit();	
			});
			
		}); 
		
		//输入数据的check处理
		function check() {
			if ($("#cmpid").val() == "") {
				alert("请输入机构编码");
				return false;
			}
			if ($("#cmpname").val() == "") {
				alert("请输入机构名称")
				return false;
			}
			
			var reg = "/^[a-zA-Z\d]+$/";
			var cmpid = $("#cmpid").val();
			if (cmpid.match(reg)) {
				alert("请输入英数字");	
				return false;
			}

			return true;				
		} 
	</script>
	
</body>
</html>