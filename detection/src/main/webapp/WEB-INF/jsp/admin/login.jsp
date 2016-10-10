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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<title>管理平台</title>
		<link href="${basePath}/ui/common/css/common.css" rel="stylesheet" />
		<link href="${basePath}/ui/tjfx/css/login.css" rel="stylesheet" />
	</head>

	<body>
		<div class="lm-common-bigbox">
			<div class="lm-common-head">
				<div class="lm-w _clear">
					<div class="pull-left lm-common-logo">
						<img src="${basePath}/ui/tjfx/images/wdlogo.png"/>
					</div>
					<div class="pull-left lm-common-title">
						<span class="lm-common-titleSplit"></span>
						<span>管理平台</span>
					</div>
				</div>
			</div>
			<div class="lm-dl-conbox _clear">
				<div class="lm-w lm-dl-mainbox">
					<div class="pull-left lm-dl-pic">
						<img src="${basePath}/ui/tjfx/images/bgleft.png" />
					</div>
					<div class="pull-right lm-dl-login">
						<div class="lm-dl-logintitle">
							<span class="lm-dl-hydl">欢迎登录
								<c:if test='${error eq true}'>
									<a class="errinfo">用户名密码错误</a>
								</c:if>
							</span>
						</div>
						<div class="lm-dl-table">
							<form action="${basePath}/admin/login" method="post">
								<div class="lm-dl-enterbox">
									<div class="lm-dl-enterPic">
										<img src="${basePath}/ui/tjfx/images/iconfont-ren.png" />
									</div>
									<div class="lm-dl-enter">
										<input type="text" class="lm-loginInput" name="loginname" id="username" placeholder="请输入账号" />
									</div>
								</div>
								<div class="lm-dl-enterbox lm-mt30">
									<div class="lm-dl-enterPic">
										<img src="${basePath}/ui/tjfx/images/iconfont-mima.png" />
									</div>
									<div class="lm-dl-enter">
										<input type="password" class="lm-loginInput" name="password" id="password" placeholder="请输入密码" />
									</div>
								</div>
								<div class="lm-dl-btnbox">
									<a href="#"><input type="submit" value="登    录" class="lm-dl-submit" /></a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="ad-page-footer">
				<div></div>
				<div></div>
			</div>
		</div>
	</body>
	
</html>