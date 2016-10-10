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
				color: rgba(255,255,255,0.8);
				border-bottom: 1px dashed rgba(255, 255, 255, 0.3);
				font-size: 14px;
				padding: 0 0 0 10px;
			}
			
			.content li.select {
				width: 100%;
				height: 50px;
				line-height: 50px;
				color: #ffd200;
				font-size: 16px;
				background: url(${basePath}/res/images/edevice/select.png) right 10px center no-repeat;
				background-size: 24px;
			}
			
			.lineBox {
				width: 100%;
				padding: 10px 0 10px 0;
				float: left;
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
		<form id="makeAppointForm" method="post" action="${basePath}/device/makeAnAppointment.htm">
			<input type="hidden" name="deviceId" value="${deviceId}"/>
			<input type="hidden" name="calendarDate" value="${calendarDate}"/>
			<input type="hidden" id="calendarTime" name="calendarTime"/>
			<div class="hi-body">
				<div class="me-box ">
					<div class="content">
						<div class="m-name">${calendarDate}</div>
						<c:forEach items="${scheduleMap}" var="schedule">
							<c:if test='${schedule.value eq true}'>
								<li allow="${schedule.value}" time="${schedule.key}">
									${schedule.key}
								</li>
							</c:if>
							<c:if test='${schedule.value eq false}'>
								<li allow="${schedule.value}" time="${schedule.key}" style="color:#666">
									${schedule.key}（已预约）
								</li>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="lineBox">
					<a href="javascript:submit();" class="btn">预约</a>
				</div>
			</div>
		</form>

		<script type="text/javascript"> 
			window.onload = function() {
				$(".content li").on('touchstart mousedown', function(e) {
					e.preventDefault();
					if($(this).attr("allow") == "true") {
						$(this).toggleClass('select');
					}
				});
			}
			
			function submit() {
				var selectArray = $(".content").find("li.select");
				var length = selectArray.length;
				if(length > 0) {
					var selectTimes = "";
					selectArray.each(function(index,element) {
						selectTimes += $(element).attr("time") + ",";
					});
					selectTimes = selectTimes.substring(0, selectTimes.length - 1);
					$("#calendarTime").val(selectTimes);
				}
				$("#makeAppointForm").submit();
			}
		</script>
	</body>

</html>