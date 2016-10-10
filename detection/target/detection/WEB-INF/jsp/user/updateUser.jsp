<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	request.setAttribute("basePath", basePath);
%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,height=device-height,maximum-scale=1,initial-scale=1, user-scalable=false">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-touch-fullscreen" content="yes">
		<meta name="format-detection" content="telephone=no" />
		<link href="${basePath}/css/base.css" rel="stylesheet" type="text/css" />
		<link href="${basePath}/css/animate.css" rel="stylesheet" type="text/css" />
		<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
		<title>我的</title>
		<style type="text/css">
			html body {
				height: 100%;
				background: #242D4A;
				animation: myanimation 60s ease-in-out infinite;
				-webkit-animation: myanimation 60s ease-in-out infinite;
			}
		</style>
	</head>

	<body>
		<div class="hi-body">
			<div class="me-box ">
				<form id="userForm" method="post" action="${basePath}/user/updateUser.htm">
					<input type="hidden" name="userId" value="${user.userId}"/>
					<div class="content">
						<li>用户名</li>
						<li class="txt"><input type="text" class="txtInput" name="userName" value="${user.userName}"  placeholder="请输入姓名"/></li>
						<li>邮箱</li>
						<li class="txt"><input type="text" class="txtInput" name="userEmail" value="${user.userEmail}" placeholder="请输入邮箱"/></li>
						<li>手机号</li>
						<li class="txt"><input type="text" class="txtInput" name="userPhone" value="${user.userPhone}" placeholder="请输入手机号"/></li>
					</div>
				</form>
				<a onclick="javaScript:submit()" class="btn">
					保存
				</a>
			</div>
		</div>
		
		<script type="text/javascript">
			function submit() {
				$("#userForm").submit();
			}
		</script>
	</body>
</html>