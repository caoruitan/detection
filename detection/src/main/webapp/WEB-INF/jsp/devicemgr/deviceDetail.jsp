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
		<title>设备管理</title>
		<link href="${basePath}/ui/common/css/common.css" rel="stylesheet" />
		<link href="${basePath}/ui/tjfx/css/index.css" rel="stylesheet" />
		<link href="${basePath}/ui/common/css/fullcalendar.css" rel="stylesheet"/>
	</head>
	<style>
		html {
			background: url(${basePath}/ui/tjfx/images/b2.jpg) no-repeat;
		}
		.hi-body {
				padding: 10px;
				width: 100%;
				max-width: 800px;
				margin: 80px auto 40px auto;
				background: #242D4A;
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
			
			.content .m-img {
				width: 100%;
				height: 360px;
				background-size: 100%;
				background-position: center;
				background-repeat: no-repeat;
				background-color: ##ffffff;
			}
			
			.content .m-bq {
				position: absolute;
				right: 0px;
				top: 10px;
				height: 20px;
				text-align: center;
				display: block;
				width: 60px;
				background: rgba(0, 0, 0, 0.6);
				border-radius: 10px 0 0 10px;
				font-size: 12px;
				line-height: 20px;
			}
			
			.content .m-name {
				width: 100%;
				float: left;
				line-height: 22px;
				padding: 6px 10px 0px 10px;
				font-size: 16px;
			}
			
			.content .m-model {
				width: 100%;
				float: left;
				height: 30px;
				line-height: 30px;
				color: rgba(255, 255, 255, 0.5);
				padding: 0px 0px 0px 10px;
			}
			
			.content .m-corp {
				width: 100%;
				float: left;
				height: 30px;
				line-height: 30px;
				font-size: 14px;
				color: #FFD200;
				padding: 0px 0px 0px 10px;
				position: relative;
			}
			
			.content .m-txt-title {
				width: 100%;
				float: left;
				line-height: 20px;
				padding: 0px 0px 0px 10px;
				font-size: 16px;
			}
			.content .m-txt-title span {
				color: #FFD200;
				font-size: 12px;
				margin: 0 0 0 10px;
			}
			
			.content .m-txt {
				width: 100%;
				float: left;
				line-height: 24px;
				font-size: 14px;
				color: rgba(255, 255, 255, 0.5);
				padding: 0px 0px 0px 10px;
			}
			/*公共*/
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
		
		<div class="hi-body">

			<div class="me-box ">
				<div class="content">
					<div class="m-img" style="background-image: url(${basePath}${device.deviceImageUrl});"></div>
					<div class="m-name">${device.deviceName }</div>
					<div class="m-model">${device.deviceModel }</div>
					<div class="m-corp">${device.deviceType }</div>
				</div>
			</div>
			<div class="split"></div>

			<div class="me-box ">
				<div class="content">
					<div class="m-txt-title">测试价格</div>
					<div class="m-txt">${device.devicePrice }</div>
				</div>
			</div>

			<div class="split"></div>
			<div class="me-box ">
				<div class="content">
					<div class="m-txt-title" style="text-align: center;margin-bottom: 15px;">请选择预约时间<span>黄色数字表示可预约次数</span></div>
					<div class="full-calendar-month-wrap">
						<div class="full-calendar-month" style="position:relative">
							<table style="width:100%">
								<thead>
									<tr>
										<th class="日 first" >日</th>
										<th class="一" >一</th>
										<th class="二" >二</th>
										<th class="三" >三</th>
										<th class="四" >四</th>
										<th class="五" >五</th>
										<th class="六" >六</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${table}" var="row">
										<tr>
										<c:forEach items="${row}" var="cell">
											<c:if test='${cell.value eq "-1"}'>
												<td class="day other-month">
													<div class="day-number">${fn:substring(cell.key, 8, 10)}</div>
													<div class="day-content"></div>
												</td>
											</c:if>
											<c:if test='${cell.value ne "-1"}'>
												<td class="day">
													<a href="${basePath}/devicemgr/dateSchedule.do?deviceId=${device.deviceId}&calendarDate=${cell.key}">
														<div class="day-number">${fn:substring(cell.key, 8, 10)}</div>
														<div class="day-content">${cell.value}</div>
													</a>
												</td>
											</c:if>
										</c:forEach>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!--<div style="position: absolute; top: 0px; left: 0px; z-index: 1; width: 100%; height: 247px;"></div>-->
						</div>
					</div>

				</div>
			</div>
			<div class="split"></div>

			<div class="me-box ">
				<div class="content">
					<div class="m-txt-title">介绍</div>
					<div class="m-txt">${device.deviceDescription}</div>
				</div>
			</div>
			<div class="split"></div>

			<div class="me-box ">
				<div class="content">
					<div class="m-txt-title">技术指标及功能</div>
					<div class="m-txt">${device.deviceFunction}</div>
				</div>
			</div>
		</div>
	</body>

</html>
<script src="${basePath}/ui/common/js/jquery-1.10.2.js"></script>