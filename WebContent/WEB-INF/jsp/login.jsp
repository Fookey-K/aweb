<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="/<%=request.getServletContext().getServletContextName() %>/js/jquery-3.1.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<label id="msg"> ${requestScope.message }</label>
	<form action="userLogin.do" onsubmit ="return check()">
		<table >
			<tbody>
				<tr>
					<td>所在单位：</td>
					<td><select name="cmp" id="cmp">
							<option value=""></option>
							<c:forEach items="${requestScope.listCmp }" var="cmpMst">
								<option value="${cmpMst.cmpid}"> ${cmpMst.cmpname }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>用户编号：</td>
					<td><input type="text" name="userId" id="userId"></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input type="password" name="password" id="password"></td>
				</tr>
				<tr>
					<td colspan="2"> 
						<input type="submit" value="登陆"> &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value="取消 ">
					</td>
				</tr>
			</tbody>
		</table>
		
	</form>
	
	<script type="text/javascript">
		
		function check(){
			if ($("#cmp").val() == "") {
				alert("请选择所在单位");
				return false;
			}
			if ($("#userId").val() == "") {
				alert("请输入用户编号");
				return false;
			}
			if ($("#password").val() == "") {
				alert("请输入密码");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>