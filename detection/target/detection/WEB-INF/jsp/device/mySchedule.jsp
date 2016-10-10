<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
		<title>我的预约</title>
		<style type="text/css">
			html,
			body {
				height: 100%;
				background: #232D4A;
			}
			
			.me-box {
				float: left;
				width: 100%;
				padding: 10px;
			}
			
			.me-box li {
				width: 100%;
				float: left;
				position: relative;
			}
			
			.m-img {
				padding: 0 10px 10px 110px;
				color: #ffffff;
				font-size: 16px;
				min-height: 60px;
				line-height: 20px;
				overflow: hidden;
			}
			
			.m-img img {
				width: 100px;
				height: 50px;
				position: absolute;
				top: 0;
				left: 0;
			}
			
			li.m-yy {
				height: 30px;
				line-height: 30px;
				color: #ffffff;
				font-size: 14px;
				float: left;
				background: url(${basePath}/res/images/edevice/yy.png) 4px no-repeat;
				background-size: 14px;
				padding: 0 0 0 24px;
			}
			
			li.m-time {
				height: 24px;
				line-height: 24px;
				color: rgba(255, 255, 255, 0.5);
				font-size: 14px;
				float: left;
				overflow: hidden;
			}
		</style>
	</head>

	<body>
		<!-- B 内容信息 -->

		<div class="m-tabs"> <a href="#" class="active">未检测</a> <a href="#">已检测</a> </div>
		<div class="m-tabs-page m-tabs-page-actived">
			<c:forEach items="${schedules}" var="schedule">
				<c:if test='${schedule.orderDate >= today}'>
					<div class="me-box">
						<a href="${basePath}/device/deviceDetail.htm?deviceId=${schedule.deviceId}">
							<li class="m-img">
								<img src="${basePath}${schedule.deviceImageUrl}" /> ${schedule.deviceName}（${schedule.deviceModel}）
							</li>
						</a>
						<li class="m-yy">预约档期(<fmt:formatDate value="${schedule.orderDate}" pattern="yyyy-MM-dd"/>)</li>
						<c:forEach items="${schedule.calendarTimes}" var="time">
							<li class="m-time">${time}</li>
						</c:forEach>
					</div>
					<div class="split"></div>
				</c:if>
			</c:forEach>
		</div>
		<div class="m-tabs-page">
			<c:forEach items="${schedules}" var="schedule">
				<c:if test='${schedule.orderDate < today}'>
					<div class="me-box">
						<a href="${basePath}/device/deviceDetail.htm?deviceId=${schedule.deviceId}">
							<li class="m-img">
								<img src="${basePath}/res/images/edevice/u17.jpg" /> ${schedule.deviceName}（${schedule.deviceModel}）
							</li>
						</a>
						<li class="m-yy">预约档期(<fmt:formatDate value="${schedule.orderDate}" pattern="yyyy-MM-dd"/>)</li>
						<c:forEach items="${schedule.calendarTimes}" var="time">
							<li class="m-time">${time}</li>
						</c:forEach>
					</div>
					<div class="split"></div>
				</c:if>
			</c:forEach>
		</div>

		<script type="text/javascript">
			window.onload = function() {
				$(".m-tabs a").on('touchstart mousedown', function(e) {
					e.preventDefault();
					$(".m-tabs .active").removeClass('active');
					$(this).addClass('active');
					$(".m-tabs-page").removeClass('m-tabs-page-actived'); //$(this).index()
					$(".m-tabs-page:eq(" + $(this).index() + ")").addClass('m-tabs-page-actived');
				});
			}
		</script>
	</body>
	
</html>