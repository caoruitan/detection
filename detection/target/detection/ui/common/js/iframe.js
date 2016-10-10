var browserVersion = window.navigator.userAgent.toUpperCase();
var isOpera = false;
var isFireFox = false;
var isChrome = false;
var isSafari = false;
var isIE = false;
var iframeTime;

function reinitIframe(iframeId) {
	try {
		var iframe = document.getElementById(iframeId);
		var bHeight = 0;
		if (isChrome == false && isSafari == false)
			bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = 0;
		if (isFireFox == true)
			dHeight = iframe.contentWindow.document.documentElement.offsetHeight + 2;
		else if (isIE == false && isOpera == false)
			dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		else
			bHeight += 3;
		var height = Math.max(bHeight, dHeight);
		iframe.style.height = height + "px";
	} catch (ex) {}
}

function startInit(iframeId) {
	isOpera = browserVersion.indexOf("OPERA") > -1 ? true : false;
	isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
	isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
	isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
	if (!!window.ActiveXObject || "ActiveXObject" in window)
		isIE = true;
	reinitIframe(iframeId);
	if (iframeTime != null)
		clearInterval(iframeTime)
	iframeTime = window.setInterval("reinitIframe('" + iframeId + "')", 100);
}