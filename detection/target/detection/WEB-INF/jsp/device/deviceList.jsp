<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<script src="${basePath}/js/wow.js" type="text/javascript" charset="utf-8"></script>
		<title>设备清单</title>
		<style type="text/css">
			html, body {
				height: 100%;
				background: #242D4A;
				animation: myanimation 60s ease-in-out infinite;
				-webkit-animation: myanimation 60s ease-in-out infinite;
			}
			
			.hi-body {
				min-height: 880px;
				padding: 0 0 20px 0;
				width: 100%;
				background: #242D4A;
				animation: myanimation 30s ease-in-out infinite;
				-webkit-animation: myanimation 30s ease-in-out infinite;
			}
			
			.hi-body .hi-notice {
				width: 100%;
				background: rgba(255, 210, 0, 0.8);
				min-height: 30px;
				padding: 10px 10px 1px 60px;
				color: #421E0A;
				font-size: 14px;
			}
			
			.hi-body .hi-notice li {
				margin: 0 0 10px 0;
			}
			
			.hi-body .hi-notice li span {
				position: absolute;
				display: block;
				left: 10px;
				height: 20px;
				width: 34px;
				background: #421E0A;
				color: #FFFFFF;
				text-align: center;
				padding: 0 0 0 4px;
				line-height: 20px;
				font-size: 12px;
				border-radius: 2px 0 0 2px;
			}
			
			.hi-body .hi-notice li span:after {
				content: "";
				width: 0;
				height: 0;
				left: 34px;
				position: absolute;
				border-top: 10px solid transparent;
				border-left: 8px solid #421E0A;
				border-bottom: 10px solid transparent;
			}
			
			.hi-body .hi-list {
				width: 100%;
				background: #FFD200;
				min-height: 30px;
				padding: 10px 10px 10px 60px;
				color: #421E0A;
				font-size: 14px;
			}
			/*list*/
			
			.hi-body .me-box {
				color: #fff;
				padding: 0px 0px 0 0px;
				position: relative;
				margin: 0 0 10px 0;
				float: left;
				/*border: 1px solid red;*/
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
			.content .m-img{
				width: 100%;
				height: 160px;
				background-size: 100% ;
				background-position: center;
				background-repeat: no-repeat;
				background-color: ##ffffff;
			}
			.content .m-bq{
				position: absolute;
				right: 0px;
				top: 10px;
				height: 20px;
				text-align: center;
				display: block;
				width: 60px;
				background: rgba(0,0,0,0.6);
				border-radius: 10px 0 0 10px;
				font-size: 12px;
				line-height: 20px;
			}
			.content .m-name{
				width: 100%;
				float: left;
				line-height: 20px;
				padding: 6px 0px 0px 10px;
				font-size: 16px;
			}
			.content .m-model{
				width: 100%;
				float: left;
				height: 30px;
				line-height: 30px;
				color: rgba(255,255,255,0.5);
				padding: 0px 0px 0px 10px;
			}
			.content .m-time{
				width: 100%;
				float: left;
				height: 30px;
				line-height: 30px;
				font-size: 12px;
				color: #FFD200;
				padding: 0px 0px 0px 10px;
				position: relative;
			}
			
			.content .m-yybtn{
				position: absolute;
				right: 4px;
				top: -2px;
				height: 30px;
				text-align: center;
				display: block;
				width: 60px;
				background:#FFD200;
				color: #993300;
				border-radius: 2px;
				font-size: 16px;
				line-height: 30px;
			}
		</style>
	</head>

	<body>

		<!-- B 内容信息 -->

		<div class="hi-body">
			<div class="hi-notice">
				<li><span>通知</span>设备在线预约已经开通</li>
			</div>
			<c:forEach items="${deviceList}" var="device">
				<a href="${basePath}/device/deviceDetail.htm?deviceId=${device.deviceId}">
					<div class="me-box ">
						<div class="content wow fadeIn">
							<span class="m-bq">可预约</span>
							<div class="m-img" style="background-image: url(${basePath}${device.deviceImageUrl});"></div>
							<div class="m-name">${device.deviceName}</div>
							<div class="m-model">${device.deviceModel }</div>
							<div class="m-time">最近档期：2016.6.23 13:00-15:00
							<span class="m-yybtn">预约</span></div>
						</div>
					</div>
				</a>
			</c:forEach>
		</div>

		<script type="text/javascript">
			if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))) {
				new WOW().init();
			};
		</script>

	</body>

</html>