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
			
			.hi-body .me-box {
				color: #fff;
				padding: 0px 0px 0 0px;
				position: relative;
				margin: 0 0 10px 0;
			}
			
			.hi-body .me-box .content {
				position: relative;
				width: 100%;
				min-height: 100px;
				border-radius: 4px;
				padding: 0px 0px 0px 0px;
				color: #ced8ff;
				font-size: 14px;
			}
			
			.content a {
				color: #ffffff;
			}
			
			.content .m-name {
				width: 100%;
				text-align: center;
				height: 50px;
				line-height: 50px;
				border-bottom: 1px solid rgba(255, 255, 255, 0.3);
				font-size: 20px;
			}
			
			.content li {
				width: 100%;
				height: 50px;
				line-height: 50px;
				color: rgba(255,255,255,0.3);
				border-bottom: 1px dashed rgba(255, 255, 255, 0.3);
				font-size: 14px;
				padding: 0 0 0 10px;
				background-size: 16px;
				position: relative;
			}
			.content li span{
				display: block;
				position: absolute;
				right: 10px;
				top: -1px;
				color: #ffffff;
			}
			
			
			.lineBox {
				width: 100%;
				padding: 10px 0 10px 0;
				float: left;
			}
			.tx{
				width: 40px;
				height: 40px;
			}
		</style>
	</head>

	<body>
		<div class="hi-body">
			<div class="me-box ">
				<div class="content">
					<li>头像<span><img class="tx" src="${userInfo.headImgUrl}"/></span></li>
					<li>微信名<span>${userInfo.nickName}</span></li>
					<li>用户名<span>${user.userName}</span></li>
					<li>邮箱<span>${user.userEmail}</span></li>
					<li>电话<span>${user.userPhone}</span></li>
				</div>
			</div>
			<div class="lineBox">
				<a href="${basePath}/user/toUpdateUser.htm?userId=${user.userId}" class="btn">修改个人资料</a>
			</div>
		</div>

		<script type="text/javascript"> 
		</script>
	</body>
	
</html>