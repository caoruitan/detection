/**
 * 
 * @param {Object} opts.targetId
 * @param {Object} opts.showDimension
 * @param {Object} opts.showInterval
 * @param {Object} opts.showFilterBtn
 * @param {Object} opts.showexport
 * 
 */
function createDisChart(opts) {
	var singleDiv = document.createElement("div");
	singleDiv.className = "lm-singletb-box";
	if(opts.margintop){
		singleDiv.className +=" lm-mt30"; 
	}
	var searchbox = document.createElement("div");
	searchbox.className = "lm-search-box";

	if (opts.showDimension) {
		var dimday = document.createElement("div");
		dimday.className = "lm-time-dimension lm-time-active";
		dimday.innerHTML = "日";
		var dimweek = document.createElement("div");
		dimweek.className = "lm-time-dimension lm-ml10";
		dimweek.innerHTML = "周";
		var dimmonth = document.createElement("div");
		dimmonth.className = "lm-time-dimension lm-ml10";
		dimmonth.innerHTML = "月";
		var dimterm = document.createElement("div");
		dimterm.className = "lm-time-dimension lm-ml10";
		dimterm.innerHTML = "学期";

		searchbox.appendChild(dimday);
		searchbox.appendChild(dimweek);
		searchbox.appendChild(dimmonth);
		searchbox.appendChild(dimterm);
	}
	if (opts.showInterval) {
		var nowDate = new Date();
		var nowYear = nowDate.getFullYear();
		var nowMonth = "";
		var nowDay = "";
		if (nowDate.getMonth() < 9) {
			nowMonth = "0" + (nowDate.getMonth() + 1);
		} else {
			nowMonth = nowDate.getMonth() + 1;
		}
		if (nowDate.getDate() < 10) {
			nowDay = "0" + nowDate.getDate();
		} else {
			nowDay = nowDate.getDate();
		}
		var strstartDate = nowYear + "-" + nowMonth + "-01";
		var strendDate = nowYear + "-" + nowMonth + "-" + nowDay;
		var inter = document.createElement("div");
		inter.className = "lm-time-interval";
		var startDate = document.createElement("input");
		startDate.type = "text";
		startDate.className = "lm-input lm-w100 Wdate";
		startDate.value = strstartDate;
		var datesplit = document.createElement("span");
		datesplit.className = "lm-time-split";
		datesplit.innerHTML = "--";
		var endDate = document.createElement("input");
		endDate.type = "text";
		endDate.className = "lm-input lm-w100 Wdate";
		endDate.value = strendDate;

		inter.appendChild(startDate);
		inter.appendChild(datesplit);
		inter.appendChild(endDate);
		searchbox.appendChild(inter);
	}
	if (opts.showFilterBtn) {
		var filterBox = document.createElement("div");
		filterBox.className = "pull-left lm-ml10";
		var filterBtn = document.createElement("input");
		filterBtn.type = "button";
		filterBtn.className = "lm-btn lm-btn-FF9900";
		filterBtn.value = "筛选";

		filterBox.appendChild(filterBtn);
		searchbox.appendChild(filterBox);
	}
	if (opts.showexport) {
		var exportBox = document.createElement("div");
		exportBox.className = "pull-right lm-table-export";
		var exportPic = document.createElement("div");
		exportPic.className = "lm-export-pic";
		var exportSpan = document.createElement("span");
		exportSpan.innerHTML = "导出表格";

		exportBox.appendChild(exportPic);
		exportBox.appendChild(exportSpan);
		searchbox.appendChild(exportBox);
	}

	var disbox = document.createElement("div");
	disbox.className = "lm-dischart-box lm-mt10";
	
	var echarbox = document.createElement("div");
	echarbox.className = "ad-exhiErea";
	var showEchar = document.createElement("div");
	showEchar.className = "ad-erea";
	showEchar.id = opts.showId;
	var tbData = document.createElement("input");
	tbData.type = "hidden";
	tbData.id = opts.showId + "_chart";
	
	echarbox.appendChild(showEchar);
	echarbox.appendChild(tbData);
	
	var tbChange=document.createElement("div");
	tbChange.className="lm-tb-change";
	
	var barRadio = document.createElement("div");
	barRadio.className="lm-radio-div pull-right lm-ml10";
	var barInput = document.createElement("input");
	barInput.type="radio";
	barInput.name="tbtype";
	barInput.id="tbbar";
	barInput.value="2";
	var barLabel = document.createElement("label");
	//barLabel.for="tbbar";
	barLabel.innerHTML="柱状图";
	barRadio.appendChild(barInput);
	barRadio.appendChild(barLabel);
	
	var lineRadio = document.createElement("div");
	lineRadio.className="lm-radio-div pull-right";
	var lineInput = document.createElement("input");
	lineInput.type="radio";
	lineInput.name="tbtype";
	lineInput.id="tbline";
	lineInput.value="1";
	var lineLabel = document.createElement("label");
	//lineLabel.for="tbline";
	lineLabel.innerHTML="折线图";
	lineRadio.appendChild(lineInput);
	lineRadio.appendChild(lineLabel);
	
	tbChange.appendChild(barRadio);
	tbChange.appendChild(lineRadio);
	
	disbox.appendChild(echarbox);
	disbox.appendChild(tbChange);
	
	
	singleDiv.appendChild(searchbox);
	singleDiv.appendChild(disbox);
	return singleDiv;
};

function getStringDate(pdate){
	var nowYear = pdate.getFullYear();
	var nowMonth = "";
	var nowDay = "";
	if (pdate.getMonth() < 9) {
		nowMonth = "0" + (pdate.getMonth() + 1);
	} else {
		nowMonth = pdate.getMonth() + 1;
	}
	if (pdate.getDate() < 10) {
		nowDay = "0" + pdate.getDate();
	} else {
		nowDay = pdate.getDate();
	}
	var strstartDate = nowYear + "-" + nowMonth + "-01";
	var strendDate = nowYear + "-" + nowMonth + "-" + nowDay;
	var dateList = new Array();
	dateList.push(strstartDate);
	dateList.push(strendDate);
	return dateList;
};
function addDateDay(dd, num) {
	var a = new Date(dd)
	a = a.valueOf()
	a = a + num * 24 * 60 * 60 * 1000
	a = new Date(a)
	return a;
};
function addDateMonth(dd, num) {
	var cur = new Date(dd)
	cur = new Date(cur.getFullYear(), (cur.getMonth()) + num, cur.getDate())
	return cur;
};