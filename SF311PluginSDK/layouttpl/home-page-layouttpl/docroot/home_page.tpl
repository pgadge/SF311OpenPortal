
<style>
	.lfr-column.grey {
		background-color:#f8f8f8 ;
		padding:7;
		border-bottom:1px solid #c9c9c7;
	}
	#content-wrapper{
		padding:0;
		margin:0;
	}

	.lfr-column.grey {
		background-color:#f8f8f8 ;
		padding:7;
		border-bottom:1px solid #c9c9c7;
	}

.lfr-column.separators{
   border-left:none;
}
</style>


<div class="columns-2" id="main-content" role="main">
   
   
    <table class="portlet-layout">
        <tr>               
            <td style="width:20%;padding-left: 10px;" class="portlet-column portlet-column-first" id="column-2" rowspan='2'>
                $processor.processColumn("column-2", "portlet-column-content portlet-column-content-first")
            </td>
            <td style="width:80%;padding-right: 10px;" class="portlet-column portlet-column-last" id="column-3" colspan="2">
                $processor.processColumn("column-3", "portlet-column-content portlet-column-content-last")
            </td>
           
        </tr>
        <tr>               
            <td style="width:40%;padding-left: 10px;" class="portlet-column portlet-column-first" id="column-4">
                $processor.processColumn("column-4", "portlet-column-content portlet-column-content-first")
            </td>
            <td style="width:40%;padding-right: 10px;" class="portlet-column portlet-column-last" id="column-5">
                $processor.processColumn("column-5", "portlet-column-content portlet-column-content-last")
            </td>
        </tr>
    </table>
   
</div>
