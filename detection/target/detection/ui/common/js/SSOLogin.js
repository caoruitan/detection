var ssologinrequestType = "get"; // 请求方式，真实环境下改为post
var SSOLoginUrl = "http://127.0.0.1:8020/WD-UI-FrameWork/webapp/"; // 请求登录地址ip（使用前需调整）
var CheckLoginRequestAddress = SSOLoginUrl + "app/json/demo/ssologin.json"; // 本工程判断是否登录的请求路径（使用前需调整）
var SSOLoginCssUrl = SSOLoginUrl + "ui/common/css/login/ssologin.css"; // 请求登录页面使用样式文件（通常情况下不用调整）
SSOLoginUrl += "user/login/auth"; // 请求登录地址（通常情况下不用调整）

/*****************国际化start****************/
var span1; // 用户登录
var span2; // 关闭
var span3; // 记住密码
var span4; // 忘记密码
var span5; // 登&nbsp;&nbsp;&nbsp;&nbsp;录
var span6; // 免费注册
var span7; // 用户名不能为空！
var span8; // 密码不能为空！
var language;
var cookiename = "language";
var arr, reg = new RegExp("(^| )" + cookiename + "=([^;]*)(;|$)");

if (document.cookie.match(reg) == null) {
	language = "zh";
} else {
	arr = document.cookie.match(reg);
	language = unescape(arr[2]);
}
switch (language) {
	case "zh": // 中文
		span1 = "用户登录";
		span2 = "关闭";
		span3 = "记住密码";
		span4 = "忘记密码";
		span5 = "登&nbsp;&nbsp;&nbsp;&nbsp;录";
		span6 = "免费注册";
		span7 = "用户名不能为空！";
		span8 = "密码不能为空！";
		break;
	case "en": // 英文
		span1 = "Sign in";
		span2 = "Close";
		span3 = "Remember password";
		span4 = "Forget password";
		span5 = "Sign&nbsp;&nbsp;&nbsp;&nbsp;in";
		span6 = "Free registration";
		span7 = "Username can not be empty!";
		span8 = "Password can not be empty!";
		break;
}
/*****************国际化end******************/
$(function() {
	var t = document.createElement('link');
	t.href = SSOLoginCssUrl; // "ssologin.css"
	t.rel = 'stylesheet';
	t.id = "wd-ssologin";
	document.getElementsByTagName('head')[0].appendChild(t);

	t.onload = function() {

	};
	// ie处理
	t.onreadystatechange = function() {
		if (this.readyState == "loaded" || this.readyState == "complete") {

		}
	}
});
// 封装页面方法
function SSOLogin(fn) {
	$.ajax({
		type: ssologinrequestType,
		dataType: 'json',
		cache: false,
		url: CheckLoginRequestAddress + "",
		success: function(data) {
			if (data.isSuccess) {
				fn.call();
			} else {
				var shield = document.createElement("DIV"); // 创建遮蔽层
				shield.id = "loginshield";
				shield.className = "loginshield";
				shield.style.zIndex = 90;
				document.body.appendChild(shield);

				var condialog = document.createElement("DIV"); // 创建弹出框透明边框
				condialog.className = "logincondialog";
				condialog.id = "logincondialog";

				var loginBoxDiv = document.createElement("DIV"); // 创建登录框Box
				loginBoxDiv.className = "loginBoxDiv";
				condialog.appendChild(loginBoxDiv);

				var loginBoxTitlt = document.createElement("DIV"); // 创建登录标题
				loginBoxTitlt.className = "loginBoxTitlt";
				loginBoxTitlt.innerHTML = span1;
				loginBoxDiv.appendChild(loginBoxTitlt);
				var loginBoxTitleSpan = document.createElement('span'); // 创建关闭按钮
				loginBoxTitleSpan.className = "loginBoxTitleSpan";
				loginBoxTitleSpan.innerHTML = span2;
				loginBoxTitlt.appendChild(loginBoxTitleSpan);
				$(loginBoxTitleSpan).bind('click', function() {
					document.body.removeChild(document.getElementById("loginshield"));
					document.body.removeChild(document.getElementById("logincondialog"));
				});

				var loginBoxItemBox = document.createElement("DIV"); // 创建登录操作区
				loginBoxItemBox.className = "loginBoxItemBox";
				loginBoxDiv.appendChild(loginBoxItemBox);

				var errorTitle = document.createElement("DIV"); // 创建错误提示框
				errorTitle.id = "login-errorTitle";
				errorTitle.className = "errorTitle";
				errorTitle.innerHTML = "";
				loginBoxItemBox.appendChild(errorTitle);

				var inputBoxLoginNameBox = document.createElement("input"); // 创建文本框（用户名）
				inputBoxLoginNameBox.type = "text";
				inputBoxLoginNameBox.className = "inputBoxUserName";
				inputBoxLoginNameBox.id = "loginname";
				loginBoxItemBox.appendChild(inputBoxLoginNameBox);

				var inputBoxLoginPassWord = document.createElement("input"); // 创建文本框（密码）
				inputBoxLoginPassWord.type = "password";
				inputBoxLoginPassWord.className = "inputBoxPassWord";
				inputBoxLoginPassWord.id = "loginpwd";
				loginBoxItemBox.appendChild(inputBoxLoginPassWord);

				var titleBox = document.createElement("DIV"); // 创建登录辅助信息区
				titleBox.className = "titleBox";
				loginBoxItemBox.appendChild(titleBox);
				var rememberPassWord = document.createElement('input'); // 创建checkbox
				rememberPassWord.type = "checkbox";
				rememberPassWord.id = "rememberPassWord";
				titleBox.appendChild(rememberPassWord);
				var rememberPassWordLable = document.createElement('label'); // 创建记住密码
				rememberPassWordLable.innerHTML = span3;
				$(rememberPassWordLable).attr("for", "rememberPassWord");
				titleBox.appendChild(rememberPassWordLable);
				var forgetPassWordLable = document.createElement('span'); // 创建忘记密码
				forgetPassWordLable.innerHTML = span4;
				$(forgetPassWordLable).bind('click', function() {
					alert()
				});
				titleBox.appendChild(forgetPassWordLable);

				var loginButton = document.createElement('button'); // 创建登录按钮
				loginButton.innerHTML = span5;
				loginButton.className = "loginButton";
				loginBoxItemBox.appendChild(loginButton);

				var loginRegister = document.createElement('span'); // 创建注册按钮
				loginRegister.innerHTML = span6;
				loginRegister.className = "loginRegister";
				loginBoxItemBox.appendChild(loginRegister);
				$(loginRegister).bind('click', function() {
					alert()
				});

				document.body.appendChild(condialog);

				$(loginButton).bind('click', function() {
					// 登录名
					var loginname = $("#loginname")[0].value;
					if (!loginname) loginname = $("#loginname")[0].textContent;
					// 登录密码
					var loginpwd = $("#loginpwd")[0].value;
					if (!loginpwd) loginpwd = $("#loginpwd")[0].textContent;

					if (loginname == "" || loginname == undefined) {
						$("#login-errorTitle").show();
						$("#login-errorTitle")[0].innerHTML = span7;
						return false;
					} else if (loginpwd == "" || loginpwd == undefined) {
						$("#login-errorTitle").show();
						$("#login-errorTitle")[0].innerHTML = span8;
						return false;
					}

					if ('XDomainRequest' in window && window.XDomainRequest !== null) { // ie8 、9处理
						var xdr = new XDomainRequest();
						xdr.open('post', SSOLoginUrl + "?time=" + new Date().getTime());
						xdr.onload = function() {
							var dom = new ActiveXObject('Microsoft.XMLDOM'),
								JSON = $.parseJSON(xdr.responseText);
							if (JSON.isSuccess) {
								fn.call();
								document.body.removeChild(document.getElementById("loginshield"));
								document.body.removeChild(document.getElementById("logincondialog"));
							} else {
								$("#login-errorTitle").show();
								var msg = "";
								if (JSON.msg == undefined) msg = "";
								else msg = JSON.msg;

								$("#login-errorTitle")[0].innerHTML = msg;
								return false;
							}
						};

						xdr.onerror = function() {
							_result = false;
						};
						xdr.withCredentials = "true";
						xdr.send("loginname=" + loginname + "&loginpwd=" + loginpwd);
					} else {
						$.ajax({
							type: "POST",
							url: SSOLoginUrl + "?time=" + new Date().getTime(), //"login.json",
							dataType: "json",
							xhrFields: {
								withCredentials: true
							},
							data: {
								"loginname": loginname,
								"loginpwd": loginpwd
							},
							success: function(data) {
								if (data.isSuccess) {
									fn.call();
									document.body.removeChild(document.getElementById("loginshield"));
									document.body.removeChild(document.getElementById("logincondialog"));
								} else {
									$("#login-errorTitle").show();

									var msg = "";
									if (data.msg == undefined) msg = "";
									else msg = data.msg;

									$("#login-errorTitle")[0].innerHTML = msg;
									return false;
								}
							},
							error: function(XMLHttpRequest, txtStatus, errorThrown) {
								if (ssologinrequestType == 'get') {
									fn.call();
									document.body.removeChild(document.getElementById("loginshield"));
									document.body.removeChild(document.getElementById("logincondialog"));
								}
								return;
							}
						});
					}
				});
			}
		},
		error: function(XMLHttpRequest, txtStatus, errorThrown) {
			return;
		}
	});
}