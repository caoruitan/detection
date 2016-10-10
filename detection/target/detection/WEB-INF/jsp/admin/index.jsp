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
		<link href="${basePath}/ui/tjfx/css/index.css" rel="stylesheet" />
	</head>
	<style>
		.content {
			height: auto;
			min-height: 300px;
			width: 100%;
			float: left;
			position: absolute;
			top: 60px;
			left: 0;
		}
		
		.box {
			width: 1000px;
			margin: 100px auto;
		}
		
		.box li {
			position: relative;
			width: 215px;
			height: 140px;
			margin: 40px;
			text-align: center;
			float: left;
			list-style: none;
			background: url(${basePath}/ui/tjfx/images/bg.png) no-repeat;
			cursor: pointer;
		}
		
		.box li img {
			margin: 30px 0 0 0;
		}
		
		.box li span {
			position: absolute;
			width: 100%;
			display: block;
			bottom: -30px;
			font-size: 20px;
			color: #666;
		}
		
		.box li span:hover {
			color: #f60;
		}
	</style>

	<body>
		<div class="lm-head">
			<div class="pull-left lm-logo">
				<img src="${basePath}/ui/tjfx/images/wdlogo.png" />
			</div>
			<div class="pull-left lm-title">
				<span class="lm-titleSplit"></span>
				<span>管理平台</span>
			</div>
			<div class="pull-right">
				<div class="pull-left lm-rightBox">
					<a href="${basePath}/admin/index.do">
						<div class="lm-homePage"></div>
					</a>
				</div>
				<a href="${basePath}/admin/logout">
					<div class="pull-right lm-exit">
						<div class="lm-exitPic"></div>
						<div>退出</div>
					</div>
				</a>
			</div>
		</div>
		<div class="content">
			<div class="box">
				<a href="${basePath}/devicemgr/deviceList.do">
					<li><img src="${basePath}/ui/tjfx/images/system_03.png" /><span>设备清单</span></li>
				</a>
				<a href="#">
					<li><img src="${basePath}/ui/tjfx/images/system_07.png" /><span>论文求助（建设中）</span></li>
				</a>
				<a href="${basePath}/admin/toUpdatePassword.do">
					<li><img src="${basePath}/ui/tjfx/images/system_05.png" /><span>修改密码</span></li>
				</a>
			</div>
		</div>
	</body>
	
</html>
<script src="${basePath}/ui/common/js/jquery-1.10.2.js"></script>