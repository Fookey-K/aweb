function createPageNavigation(pngId,curPage, totalPage) {
	var pageNv = $("#"+pngId);
	//前一页  1 2  3 4 5 6  后一页
	var prePage= "<a href='##' id='preIndex'>&lt;&lt; &nbsp;&nbsp;</a>";
	pageNv.append(prePage);
	var i = 0;
	var pageLink ;
	for (i=1; i <= totalPage; i++) {
		if (i != curPage) {
			pageLink= "<a href='##' id='pageIndex_" + i + "'>" + i  + "&nbsp;&nbsp; </a>";
		} else {
			pageLink= "<a href='##' id='pageIndex_" + i + "' class='active'>" + i + "&nbsp;&nbsp;</a>";
		}
		pageNv.append(pageLink);
	}
	var nextPage= "<a href='##' id='nextIndex'>&gt;&gt;</a>";
	pageNv.append(nextPage);
}

function addPageEvent(pngId, formId,pgAction) {
	$("#pageNavigation a").each(function(){
		var linkID = $(this).attr("id");
		if (linkID == "preIndex") {
			$(this).click(function() {
				//前一页的pageIndex
				var newPage =0;
				var curPage =  parseInt($("#curPage").val());
				if (curPage == 1) {
					newPage =  1;
				} else {
					newPage = curPage -1;
				}
				//提交事件
				pgsubmit(newPage,formId,pgAction);
			});
			
		} else if (linkID == "nextIndex")  {
			$(this).click(function() {
				//前一页的pageIndex
				var newPage =0;
				var curPage =  parseInt($("#curPage").val());
				var totalPage =  parseInt($("#totalPage").val());
				
				if (curPage == totalPage) {
					newPage =  totalPage;
				} else {
					newPage = curPage + 1;
				}
				//提交事件
				pgsubmit(newPage,formId,pgAction);
			});
		} else {
			$(this).click(function() {
				var newPage  = linkID.substring(10);
				pgsubmit(newPage,formId,pgAction);
			}); 		
			
		}
	});	
	
	//提交处理
	function pgsubmit(newPage,formId,pgAction) {
		console.log("1111:" + formId);
		var form1 = $("#" + formId);
		$("#curPage").val(newPage);
		console.log("abc:" + newPage);
		form1.attr("action",pgAction);
		console.log("pgAction:" + pgAction);
		form1.submit();
	}
}

