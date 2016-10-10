/*******************************************************************************
 * 功能说明：导出Excel文件
 * 
 * @author xiajb
 * 
 * 例子： //导出Excel示例 $("#btnExport").click(function(){ $.exportFile({
 * url:$.ctx+'/demo/demo!export.action', expKey: 'demo01.exp.excel', cols:
 * 'cdmc,cdlx,zmj,jss,jcrq', queryParam: $("#formSearch").formToJson() }); });
 *    ************************************************************************** 
   * Date: 2013-03-25
   * modifier: jinglw
   * reason: 
   * 导出时页面用时太长 
   * 点击导出时 通过ajax  生成一个临时文件，返回文件Id，然后根据文件id异步回调下载，再将临时文件删除 
 ******************************************************************************/
 $.exportFile = function(options) {
	options = $.extend({
		url		   : false,// Excel文件导出服务地址
		expKey		: false,// Excel模板文件key,在resources/conf/excel-template.properties里进行配置，实际Excel模板文件在WebRoot/exportTemplate目录下
		expFileName	: false,// Excel导出文件显示名称设置
		cols		: false,// 需要导出的属性列
		queryParam	: {},// 查询参数
		grid : null,//如果设置了该参数，当表格没有数据时给予没有数据导出的提示
		limitMaxExport : false,//是否限制导出最大记录数
		coalitionRowSpan:'',//要合并的列 huxh20130318
		tableHeadRow:'1',//模板表头所占行数默认为1 huxh20130318
		maxExport : 5000,//导出最大记录数
		typeOfExport : ''//导出类别（''标识默认导出，1标识生成临时文件然后导出）add by jlw At 20150521
	}, options);
	
	if (!options.url || !options.expKey) {
		return;
	}
	var url = options.url;
	var parameters = options.queryParam;
	if (parameters instanceof Array) {
		var str = '{';
		$.each(parameters, function(i) {
			if (i != 0) {
				str += ','
			}
			str += '"' + this.name + '":"' + this.value + '"';
		});
		str += "}";
		parameters = eval("(" + str + ")");
	}
	var $mainGrid = options.grid;
	if($mainGrid){
		var records = $mainGrid.getGridParam('records');
		if(records<1){
			$.alert("没有数据需要导出。");
			return;
		}
		
		var $queryParams = $mainGrid.data("$queryParams");
		if($queryParams){
			$.extend(parameters,$queryParams);
		}
		
		if(options.limitMaxExport&&Number(records)>options.maxExport){
			$.alert(['导出记录条数最大允许为',options.maxExport,'，请缩小检索范围重新导出。'].join(""));
			return;
		}
		
		var sortname = $mainGrid[0].p.sortname;
		var sortorder = $mainGrid[0].p.sortorder;
		if(sortname!=""&&sortorder!=""){
			parameters['page.sortCol'] = sortname;
			parameters['page.sortOrder'] = sortorder;
		}
	}
	
	parameters['exp_key'] = options.expKey;
	parameters['cols'] = options.cols;
	parameters['coalitionRowSpan'] = options.coalitionRowSpan;
	parameters['tableHeadRow'] = options.tableHeadRow;
	
	if(options.expFileName){//如果设置了导出文件名称设置则传该参数
		parameters['exp_file_name'] = options.expFileName;
	}
	
	// 构造iframe
	var $exportFrame = $("#jeawExportExcelFrame");
	
	if ($exportFrame.length == 0) {
		$exportFrame = $("<iframe style='display: none;width:0px;height:0px;' name='jeawExportExcelFrame' id='jeawExportExcelFrame' ></iframe>");
		$exportFrame.appendTo($("body"));
	}
	
	// 构造导出的form
	var $exportForm = $("#jeawExportExcelForm");
	
	if ($exportForm.length == 0) {
		$exportForm = $("<form id='jeawExportExcelForm' name='jeawExportExcelForm' target='jeawExportExcelFrame' method='POST'> </form>");
		
		$exportForm.appendTo($("body"));
	} else {
		$exportForm.empty();
	}
	// 使用jqgrid中的参数来为form造hidden输入域
	for (var prop in parameters) {
		$("<input type='hidden' />").attr("name", prop).attr("value",
		        parameters[prop]
		).appendTo($exportForm);
	}
	//使用 1种方式导出：生成临时文件然后导出
	if(options.typeOfExport){
		 $.commAjax({//动态生成表头
				type : 'POST',
				url : url,
				isShowMask:true,
				timeout: 1800000,
				maskMassage :MSG_LONG_TIME,
				checkSubmitted:false,//该设置防止重复提交
				postData : $("#jeawExportExcelForm").serializeArray(),
				onSuccess : function(data) {	//返回临时文件id
					$("<input type='hidden' />").attr("name", "fileID").attr("id", "fileID").appendTo($exportForm);			
					if(data){
						 $('#fileID').val(data);
						 $exportForm.attr("action", $.ctx + "/file!excelDownload.action");
						 $exportForm.submit();
					} else {
						$.alert('导出失败，请联系管理员。');
					}
				 }
		 });
	}else{
		$exportForm.attr("action", url);
		$exportForm.submit();
	}
};