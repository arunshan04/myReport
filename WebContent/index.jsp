
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DWH Batch Maintance</title>
  
<link rel="stylesheet" type="text/css" media="screen" href="themes/redmond/jquery-ui-custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="themes/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="themes/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/test.css" />
<style>
html, body {
	margin: 0;			/* Remove body margin/padding */
	padding: 0;
	overflow: hidden;	/* Remove scroll bars on browser window */	
    font-size: 75%;
}
/*Splitter style */


#LeftPane {
	/* optional, initial splitbar position */
	overflow: auto;
}
/*
 * Right-side element of the splitter.
*/

#RightPane {
	padding: 2px;
	overflow: auto;
}
.ui-tabs-nav li {position: relative;}
.ui-tabs-selected a span {padding-right: 10px;}
.ui-tabs-close {display: none;position: absolute;top: 3px;right: 0px;z-index: 800;width: 16px;height: 14px;font-size: 10px; font-style: normal;cursor: pointer;}
.ui-tabs-selected .ui-tabs-close {display: block;}
.ui-layout-west .ui-jqgrid tr.jqgrow td { border-bottom: 0px none;}
.ui-datepicker {z-index:1200;}
.rotate
    {
        /* for Safari */
        -webkit-transform: rotate(-90deg);

        /* for Firefox */
        -moz-transform: rotate(-90deg);

        /* for Internet Explorer */
        filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
    }

</style>

<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery-ui-custom.min.js" type="text/javascript"></script>
<script src="js/jquery.layout.js" type="text/javascript"></script>
<script src="js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script type="text/javascript">
	$.jgrid.no_legacy_api = true;
	$.jgrid.useJSON = true;
</script>
<script src="js/ui.multiselect.js" type="text/javascript"></script>
<script src="js/jquery.jqGrid.js" type="text/javascript"></script>
<script src="js/jquery.tablednd.js" type="text/javascript"></script>
<script src="js/jquery.contextmenu.js" type="text/javascript"></script>
<script type="text/javascript">

jQuery(document).ready(function(){
    //$('#switcher').themeswitcher();

	$('body').layout({
		resizerClass: 'ui-state-default',
        west__onresize: function (pane, $Pane) {
            jQuery("#west-grid").jqGrid('setGridWidth',$Pane.innerWidth()-2);
		}
	});
	$.jgrid.defaults = $.extend($.jgrid.defaults,{loadui:"enable"});
	var maintab =jQuery('#tabs','#RightPane').tabs({
        add: function(e, ui) {
            // append close thingy
            $(ui.tab).parents('li:first')
                .append('<span class="ui-tabs-close ui-icon ui-icon-close" title="Close Tab"></span>')
                .find('span.ui-tabs-close')
				.show()
                .click(function() {
                    maintab.tabs('remove', $('li', maintab).index($(this).parents('li:first')[0]));
                });
            // select just added tab
            maintab.tabs('select', '#' + ui.panel.id);
        }
    });
    jQuery("#west-grid").jqGrid({
        url: "tree.xml",
        datatype: "xml",
        height: "auto",
        pager: false,
        loadui: "disable",
        colNames: ["id","Items","url"],
        colModel: [
            {name: "id",width:1,hidden:true, key:true},
            {name: "menu", width:150, resizable: false, sortable:false},
            {name: "url",width:1,hidden:true}
        ],
        treeGrid: true,
		caption: "DWH Batch Maintance",
        ExpandColumn: "menu",
        autowidth: true,
        //width: 180,
        rowNum: 200,
        ExpandColClick: true,
        treeIcons: {leaf:'ui-icon-document-b'},
        onSelectRow: function(rowid) {
            var treedata = $("#west-grid").jqGrid('getRowData',rowid);
            if(treedata.isLeaf=="true") {
                //treedata.url
                var st = "#t"+treedata.id;
				if($(st).html() != null ) {
					maintab.tabs('select',st);
				} else {
					maintab.tabs('add',st, treedata.menu);
					//$(st,"#tabs").load(treedata.url);
					$.ajax({
						url: treedata.url,
						type: "GET",
						dataType: "html",
						complete : function (req, err) {
							$(st,"#tabs").append(req.responseText);
						}
					});
				}
            }
        }
    });
	
// end splitter

});
</script>
</head>
<body>
  	<div id="LeftPane" class="ui-layout-west ui-widget ui-widget-content">
		<table id="west-grid"></table>
	</div> <!-- #LeftPane -->
	<div id="RightPane" class="ui-layout-center ui-helper-reset ui-widget-content" ><!-- Tabs pane -->
    <div id="switcher"></div>
		<div id="tabs" class="jqgtabs">
			<ul>
				<li><a href="#tabs-1">Welcome</a></li>
			</ul>
			<div id="tabs-1" style="font-size:12px;"> Welcome Content <br/>
			
			<br/>
			Enjoy
			<br/>
			<br/>
			
			
<body>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
			
			<script>
window.onload = function () {

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	theme: "light2",
	title:{
		text: "Site Traffic"
	},
	axisX:{
		valueFormatString: "DD MMM",
		crosshair: {
			enabled: true,
			snapToDataPoint: true
		}
	},
	axisY: {
		title: "Number of Visits",
		crosshair: {
			enabled: true
		}
	},
	toolTip:{
		shared:true
	},  
	legend:{
		cursor:"pointer",
		verticalAlign: "bottom",
		horizontalAlign: "left",
		dockInsidePlotArea: true,
		itemclick: toogleDataSeries
	},
	data: [{
		type: "line",
		showInLegend: true,
		name: "Total Visit",
		markerType: "square",
		xValueFormatString: "DD MMM, YYYY",
		color: "#F08080",
		dataPoints: [
			{ x: new Date(2017, 0, 3), y: 650 },
			{ x: new Date(2017, 0, 4), y: 700 },
			{ x: new Date(2017, 0, 5), y: 710 },
			{ x: new Date(2017, 0, 6), y: 658 },
			{ x: new Date(2017, 0, 7), y: 734 },
			{ x: new Date(2017, 0, 8), y: 963 },
			{ x: new Date(2017, 0, 9), y: 847 },
			{ x: new Date(2017, 0, 10), y: 853 },
			{ x: new Date(2017, 0, 11), y: 869 },
			{ x: new Date(2017, 0, 12), y: 943 },
			{ x: new Date(2017, 0, 13), y: 970 },
			{ x: new Date(2017, 0, 14), y: 869 },
			{ x: new Date(2017, 0, 15), y: 890 },
			{ x: new Date(2017, 0, 16), y: 930 }
		]
	},
	{
		type: "line",
		showInLegend: true,
		name: "Unique Visit",
		lineDashType: "dash",
		dataPoints: [
			{ x: new Date(2017, 0, 3), y: 510 },
			{ x: new Date(2017, 0, 4), y: 560 },
			{ x: new Date(2017, 0, 5), y: 540 },
			{ x: new Date(2017, 0, 6), y: 558 },
			{ x: new Date(2017, 0, 7), y: 544 },
			{ x: new Date(2017, 0, 8), y: 693 },
			{ x: new Date(2017, 0, 9), y: 657 },
			{ x: new Date(2017, 0, 10), y: 663 },
			{ x: new Date(2017, 0, 11), y: 639 },
			{ x: new Date(2017, 0, 12), y: 673 },
			{ x: new Date(2017, 0, 13), y: 660 },
			{ x: new Date(2017, 0, 14), y: 562 },
			{ x: new Date(2017, 0, 15), y: 643 },
			{ x: new Date(2017, 0, 16), y: 570 }
		]
	}]
});
chart.render();

function toogleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	} else{
		e.dataSeries.visible = true;
	}
	chart.render();
}

}
</script>

			
			
			
			
			
			</div>
		</div>
	</div> <!-- #RightPane -->
</body>
</html>
