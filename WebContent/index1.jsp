<!DOCTYPE html>
<html>

<head>
    <title>BI/DWH Batch Dashboard</title>
<link rel="stylesheet" type="text/css" media="screen" href="themes/redmond/jquery-ui-custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="themes/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="themes/ui.multiselect.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/cupertino/jquery-ui.css" type="text/css"/>
    <link rel="stylesheet" href="https://images.webofknowledge.com/WOKRS517B2.3/javascript/jquery-ui/jquery.ui.widget.js" type="text/css"/>
        <link rel="stylesheet" href="https://images.webofknowledge.com/WOKRS517B2.3/javascript/jquery-ui/jquery.ui.core.js" type="text/css"/>
        <link rel="stylesheet" href="https://images.webofknowledge.com/WOKRS517B2.3/javascript/jquery-ui/jquery-ui.js" type="text/css"/>
        
    
    

</head>

<body>

    <div class="topnav">
        <a href="index.jsp">Home</a>
        <a href="#news">ASIA</a>
        <a href="#contact">EMEA</a>
        <a href="#about">About</a>
    </div>



<div>
    <div style="float: left">

        <table id="list"></table>
        <div id="pager"></div>
    </div>
    <div style="float: right">
		<table id="tableLoadList"></table>
        <div id="pager1"></div>
</div>
	</div>



    <script type="text/javascript">
    var gradientNumberFormat = function(cellvalue) {
        var data = cellvalue.split("|"); /* parseInt(cellvalue, 10);*/
        
        //if (parseInt(data[0]) == 0) {return '<div class="progress"> Pending </div>'};
        //if (parseInt(data[0]) == 100) {return '<div class="progress"><div class="progress-bar progress-bar-success" role="progressbar" style="width:100%" > Completed </div></div>'};
        if (parseInt(data[0]) == 100) {return '<div class="cellDiv"><div class="gradient2" style="width:'+succ+'%;"></div><div class="cellTextRight" >100 % </div></div>';}
        var TotalJobs = parseInt(data[0]) + parseInt(data[1]) + parseInt(data[2]) + parseInt(data[3]);
        var succ = Math.round((parseInt(data[0]) / TotalJobs) * 100);
        var Fail = Math.round((parseInt(data[1]) / TotalJobs) * 100);
        var runn = Math.round((parseInt(data[2]) / TotalJobs) * 100);
        var pend = Math.round((parseInt(data[3]) / TotalJobs) * 100);
        return '<div class="cellDiv"><div class="gradient2" style="width:'+succ+'%;"></div><div class="cellTextRight" >'+succ +'% </div></div>';
      	//return '<div class="progress"><div class="progress-bar progress-bar-success" role="progressbar" style="width:' + succ + '%">' + succ +'%'+ '</div><div class="progress-bar progress-bar-danger" role="progressbar" style="width:' + Fail + '%">' + Fail +'%'+ '</div><div class="progress-bar progress-bar-warning" role="progressbar" style="width:' + runn + '%">' + runn +'%'+ '</div></div>';
        //return '<div class="progress"><div class="progress-bar progress-bar-success" role="progressbar" style="width:'+succ +'">'succ+'</div></div>';
        
    };
        

        $(document).ready(function() {

        		
        		 var dummy={"page":null,"total":0,"records":"0"};

            $("#list").jqGrid({
            	url:"http://localhost:8080/MyProject/getdbdata",
                datatype: "json",
                mtype: 'POST',
                postData: { 'table': 'batchmon1' } ,
                colNames: ['Region', 'Batch_date', 'Country', 'Cycle_no', 'Batch type', 'BizDate','Progress'],
                colModel: [{name : 'REGION',index : 'Region',width : 100,align: 'center'}, 
                           {name : 'BATCH_DATE',index : 'BATCH_DATE',width : 100,editable : false,align: 'center',sortable: true,sorttype: 'text'}, 
                           {name : 'COUNTRY',index : 'COUNTRY',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'}, 
                           {name : 'CYCLE_NO',index : 'CYCLE_NO',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'}, 
                           {name : 'BATCH_TYPE',index : 'Batch_type',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'}, 
                           {name : 'BIZDATE',index : 'BizDate',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'},
                           {name : 'PROGRESS',index : 'PROGRESS',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'
                        	   ,formatter: function (cellvalue) {return gradientNumberFormat(cellvalue);}}],
                pager: jQuery('#pager'),
                loadonce: true,
                rowNum: 10,
                height: '250',
                rowList: [10,20,30],
                sortname: 'Batch_date',
                sortorder: 'desc',
                viewrecords: true,
                gridview: true,
                sortable: true,
                multiselect: false,
                multiboxonly: false,
                caption: 'DWH/BI Batch Status',
                jsonReader: {repeatitems: false},                
                onSelectRow: function(ids) {
            		if(ids == null) {
            			ids=0;
            			if(jQuery("#tableLoadList").jqGrid('getGridParam','records') >0 )
            			{
            			
            				jQuery("#tableLoadList").jqGrid('setGridParam',{datastr:dummy,page:1});
            				jQuery("#tableLoadList").jqGrid('setCaption',"Invoice Detail: "+ids)
            				.trigger('reloadGrid');
            			}
            		} else {
            			var selRowArr = $("#list").jqGrid ('getGridParam', 'selrow');
            			jQuery("#tableLoadList").jqGrid('setGridParam',{url:"getdbdata?table=batchmon1&where=where bizdate='"+$('#list').jqGrid('getCell', selRowArr[0], 'BIZDATE')+"'"+"And country='"+$('#list').jqGrid('getCell', selRowArr[0], 'COUNTRY')+"'",page:1});
            			jQuery("#tableLoadList").jqGrid('setCaption',"Table Loading Details of Record: "+ids)
            			jQuery("#tableLoadList").trigger('reloadGrid');	

            			
            		}
            	}
            }).navGrid("#pager", {refresh: true,edit: false,add: false,del: false,search: true});
        });

   

            $("#tableLoadList").jqGrid({
                datatype: "json",
                colNames: ['COUNTRY','PROTFOLIO', 'SUBJECT_AREA', 'APPLICATION', 'BIZDATE', 'TABLE_NAME', 'LOAD_COUNT','UPDATE_TS'],
                colModel: [{name : 'COUNTRY',index : 'COUNTRY',width : 100,align: 'center'}, 
                           {name : 'PROTFOLIO',index : 'PROTFOLIO',width : 100,editable : false,align: 'center',sortable: true,sorttype: 'text'}, 
                           {name : 'SUBJECT_AREA',index : 'SUBJECT_AREA',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'}, 
                           {name : 'APPLICATION',index : 'APPLICATION',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'}, 
                           {name : 'BIZDATE',index : 'BIZDATE',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'}, 
                           {name : 'TABLE_NAME',index : 'TABLE_NAME',width : 200,editable : false,sortable: true,align: 'center',sorttype: 'text'},
                           {name : 'LOAD_COUNT',index : 'LOAD_COUNT',width : 100,editable : false,sortable: true,align: 'center',sorttype: 'text'},
                           {name : 'UPDATE_TS',index : 'UPDATE_TS',width : 200,editable : false,sortable: true,align: 'center',sorttype: 'text'}],
                pager: jQuery('#pager1'),
                loadonce: true,
                rowNum: 10,
                height: '250',
                rowList: [10,20,30],
                sortname: 'Batch_date',
                sortorder: 'desc',
                viewrecords: true,
                gridview: true,
                sortable: true,
                multiselect: false,
                multiboxonly: false,
                jsonReader: {repeatitems: false}
            }).navGrid("#pager1", {refresh: true,edit: false,add: false,del: false,search: true});
        
    
        
        
    </script>

</body>

    <footer class="footer">
        <p>&copy; Company 2015</p>
    </footer>

</html>