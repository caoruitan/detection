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
		<title>设备预约</title>
		<style type="text/css">
			html body {
				height: 100%;
				background: #242D4A;
				animation: myanimation 60s ease-in-out infinite;
				-webkit-animation: myanimation 60s ease-in-out infinite;
			}
			
			.hi-body .me-box {
				color: #fff;
				padding: 0px 0px 0 0px;
				position: relative;
				margin: 0 0 10px 0;
			}
			
			.hi-body .me-box .content {
				position: relative;
				width: 100%;
				height: 400px;
				border-radius: 4px;
				padding: 0px 0px 0px 0px;
				color: #ced8ff;
				font-size: 14px;
				text-align: center;
				line-height: 100px;
				background: url(${basePath}/res/images/edevice/select.png) center center no-repeat;
			}
			
			.hi-body .me-box .content span{
				position: absolute;
				top: 200px;
				left: 50%;
				margin-left: -40px;
				font-size: 20px;
			}
			.content a {
				color: #ffffff;
			}
			
			.btn {
				height: 30px;
				display: block;
				width: 100%;
				margin: 0 auto;
				text-align: center;
				line-height: 30px;
				background: #ffd200;
				border-radius: 2px;
				font-size: 16px;
			}
		</style>
	</head>

	<body>
		<div class="hi-body">
			<div class="me-box ">
				<div class="content">
					<span>预约成功</span>
				</div>
			</div>
			<div class="lineBox">
				<a href="${basePath}/device/mySchedule.htm" class="btn">查看我的预约</a>
			</div>
		</div>
	</body>
	
</html>