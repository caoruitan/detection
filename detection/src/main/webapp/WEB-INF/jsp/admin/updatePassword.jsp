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
	</head>
	<style>
	html{
		/*background:url(../../../ui/tjfx/images/photo-117358927.jpg)  no-repeat;*/
	}
		.content {
			height: 300px;
			min-height: 300px;
			width: 800px;
			position: absolute;
			margin-top: -150px;
			margin-left: -400px;
			left: 50%;
			top: 50%;
		}
		
		.box {
			width: 800px;
			height: 60px;
		}
		.box h3{
			height: 40px;
			line-height: 40px;
			font-size: 24px;
			color: #f60;
			margin: 0 0 20px 0;
		}
		.box p{
			height: 40px;
			line-height: 40px;
			margin: 20px 0 0 55px;
		}
		input {
			vertical-align: middle;
			margin: 0;
			padding: 0
		}
		
		.file-box {
			position: relative;
			width: 700px;
		}
		
		.txt {
			height: 40px;
			border: 1px solid #cdcdcd;
			width: 490px;
			border-radius: 4px;
			padding-left: 4px;
			font-size: 18px;
			color: #f60;
		}
		
		.btn {
			background-color: #f2f2f2;
			border: 1px solid #CDCDCD;
			height: 40px;
			width: 120px;
			line-height: 40px;
			border-radius: 4px;
			z-index: 999;
			font-size: 16px;
			cursor: pointer;
		}
		.btn:hover{
			background: #0083af;
			color: #ffffff;
			border: none;
		}
		.file {
			position: absolute;
			top: 0;
			right: 85px;
			height: 40px;
			width:120px;
			line-height: 40px;
			filter: alpha(opacity: 0);
			opacity: 0;
			cursor: pointer;
			border: 1px solid red;
		}
		.error {
			color : red;
			padding-left: 10px;
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
			<form id="passwordForm" method="post" action="${basePath}/admin/updatePassword.do">
				<div class="box">
					<h3>修改密码</h3>
					
					<div class="file-box">
						原密码：<input type='password' name='password' id='password' class='txt' />
						<c:if test='${error eq "true"}'>
							<label for="password" generated="true" class="error help-inline">原密码错误</label>
						</c:if>
						<br><br>
						新密码：<input type='password' name='password1' id='password1' class='txt' />
						<br><br>
						新密码：<input type='password' name='password2' id='password2' class='txt' />
					</div>
					<p><input type='submit' class='btn' value='提交' /></p>
				</div>
			</form>
		</div>
	</body>
</html>
<script src="${basePath}/ui/common/js/jquery-1.10.2.js"></script>
<script src="${basePath}/ui/common/validate/jquery.validate.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $.validator.addMethod("isNewPasswordSame", function(value, element) {
            var password1 = $("#password1").val();
            var password2 = $("#password2").val();
            return password1 == password2;
        }, "两次密码输入不一致");
        $.validator.addMethod("isNewAndOldPasswordNotSame", function(value, element) {
            var password = $("#password").val();
            var password1 = $("#password1").val();
            return password != password1;
        }, "新密码不能与原密码相同");
        
        // 修改密码表单验证
        $('#passwordForm').validate({
            rules: {
                password: {
                    required: true
                },
                password1: {
                    required : true,
                    isNewAndOldPasswordNotSame : true
                },
                password2: {
                    required: true,
                    isNewPasswordSame : true
                }
            },
            messages: {  
                password : "请输入旧密码",
                password1 : {  
                    required : "请输入新密码",
                    isNewAndOldPasswordNotSame : "新密码不能与原密码相同"
                },  
                password2 : {  
                    required : "请再次输入新密码",  
                    isNewPasswordSame : "两次密码输入不一致"
                }
            }
        });
    });
</script>