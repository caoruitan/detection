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
							<th>设备名称</th>
							<th>设备分类</th>
							<th>型号</th>
							<th>操作</th>
						</tr>
					</thead>
					<c:forEach items="${deviceList}" var="device" varStatus="sta">
						<c:if test="${sta.index % 2 eq 0 }">
							<tr>
								<td class="color-text03">${device.deviceName}</td>
								<td>${device.deviceType}</td>
								<td>${device.deviceModel}</td>
								<td class="color-text"><a href="${basePath}/devicemgr/deviceDetail.do?deviceId=${device.deviceId}">查看预约情况</a></td>
							</tr>
						</c:if>
						<c:if test="${sta.index % 2 eq 1 }">
							<tr class="bg-color">
								<td class="color-text03">${device.deviceName}</td>
								<td>${device.deviceType}</td>
								<td>${device.deviceModel}</td>
								<td class="color-text"><a href="${basePath}/devicemgr/deviceDetail.do?deviceId=${device.deviceId}">查看预约情况</a></td>
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