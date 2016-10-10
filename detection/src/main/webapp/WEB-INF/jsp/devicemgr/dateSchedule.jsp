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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<title>设备管理</title>
		<link href="${basePath}/ui/common/css/common.css" rel="stylesheet" />
		<link href="${basePath}/ui/tjfx/css/index.css" rel="stylesheet" />
	</head>
	<style>
		html {
			background: url(${basePath}/ui/tjfx/images/b2.jpg) no-repeat;
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
			<div class="product-info">
				<table>
					<thead>
						<tr>
							<th>时段</th>
							<th>预约状态</th>
							<th>预约人</th>
							<th>预约人邮箱</th>
							<th>预约人电话</th>
							<th>操作</th>
						</tr>
					</thead>
					<c:forEach items="${schedules}" var="schedule" varStatus="sta">
						<c:if test="${sta.index % 2 eq 0 }">
							<tr>
								<td class="color-text03">${schedule.scheduleTime}</td>
								<c:if test='${empty schedule.calendarId}'>
									<td>未预约</td>
								</c:if>
								<c:if test='${not empty schedule.calendarId}'>
									<td>已预约</td>
								</c:if>
								<c:if test='${not empty schedule.calendarId}'>
									<c:if test='${empty schedule.orderId}'>
										<td>管理员</td>
										<td></td>
										<td></td>
									</c:if>
									<c:if test='${not empty schedule.orderId}'>
										<td>${schedule.userName}</td>
										<td>${schedule.userEmail}</td>
										<td>${schedule.userPhone}</td>
									</c:if>
								</c:if>
								<c:if test='${empty schedule.calendarId}'>
									<td></td>
									<td></td>
									<td></td>
								</c:if>
								<c:if test='${empty schedule.calendarId}'>
									<td class="color-text"><a href="${basePath}/devicemgr/makeAppoint.do?deviceId=${deviceId}&calendarDate=${calendarDate}&scheduleId=${schedule.scheduleId}">设置为预约状态</a></td>
								</c:if>
								<c:if test='${not empty schedule.calendarId}'>
									<td></td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${sta.index % 2 eq 1 }">
							<tr class="bg-color">
								<td class="color-text03">${schedule.scheduleTime}</td>
								<c:if test='${empty schedule.calendarId}'>
									<td>未预约</td>
								</c:if>
								<c:if test='${not empty schedule.calendarId}'>
									<td>已预约</td>
								</c:if>
								<c:if test='${not empty schedule.calendarId}'>
									<c:if test='${empty schedule.orderId}'>
										<td>管理员</td>
										<td></td>
										<td></td>
									</c:if>
									<c:if test='${not empty schedule.orderId}'>
										<td>${schedule.userName}</td>
										<td>${schedule.userEmail}</td>
										<td>${schedule.userPhone}</td>
									</c:if>
								</c:if>
								<c:if test='${empty schedule.calendarId}'>
									<td></td>
									<td></td>
									<td></td>
								</c:if>
								<c:if test='${empty schedule.calendarId}'>
									<td class="color-text"><a href="${basePath}/devicemgr/makeAppoint.do?deviceId=${deviceId}&calendarDate=${calendarDate}&scheduleId=${schedule.scheduleId}">设置为预约状态</a></td>
								</c:if>
								<c:if test='${not empty schedule.calendarId}'>
									<td></td>
								</c:if>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</div>
		<%-- 
		<div class="m-prev_next">
			<button><span>末页</span></button>
			<button><span>下一页</span></button>
			<button><span>上一页</span></button>
			<button><span>首页</span></button>
		</div>
		</div>
		--%>
	</body>

</html>