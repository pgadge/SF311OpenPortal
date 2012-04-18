<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<jsp:useBean class="java.lang.String" id="mapKey"
	scope="request" />
<jsp:useBean class="java.lang.String" id="wsUrl"
	scope="request" />
<jsp:useBean class="java.lang.String" id="socrataUrl"
	scope="request" />
<jsp:useBean class="java.lang.String" id="socrataUserId"
	scope="request" />
<jsp:useBean class="java.lang.String" id="socrataPwd"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedTab"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedPrbType"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedViewId"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedViewName"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedViewDesc"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedViewColId"
	scope="request" />
<jsp:useBean class="java.lang.String" id="webContentId"
	scope="request" />

<portlet:defineObjects />

<portlet:actionURL var="defineGoogleMapURL">
	<portlet:param name="action" value="configureGoogleMap" />
</portlet:actionURL>

<portlet:actionURL var="defineSocrataView">
	<portlet:param name="action" value="configureSocrataView" />
</portlet:actionURL>


<portlet:resourceURL var="getPrbDetailsURL">
	<portlet:param name="action" value="getProblemDetails" />
</portlet:resourceURL>

<script type="text/javascript">

function <portlet:namespace />_validateGoogleMap()
{
	var mapKey = document.getElementById("<portlet:namespace />mapKey").value;
	var wsUrl = document.getElementById("<portlet:namespace />wsUrl").value;
	var socrataUrl = document.getElementById("<portlet:namespace />socrataUrl").value;
	var socrataUserId = document.getElementById("<portlet:namespace />socrataUserId").value;
	var socrataPwd = document.getElementById("<portlet:namespace />socrataPwd").value;
	var webContentId = document.getElementById("<portlet:namespace />webContentId").value;
	
	if(mapKey == null || mapKey ==''  || ($.trim(mapKey)).length == 0)
	{
		alert("Enter Map Key. ");
		return false;
	}

	if(wsUrl == null || wsUrl ==''  || ($.trim(wsUrl)).length == 0)
	{
		alert("Enter Web Service URL. ");
		return false;
	}

	if(socrataUrl == null || socrataUrl ==''  || ($.trim(socrataUrl)).length == 0)
	{
		alert("Enter Socrata JSON Service URL. ");
		return false;
	}

	if(socrataUserId == null || socrataUserId ==''  || ($.trim(socrataUserId)).length == 0)
	{
		alert("Enter Socrata User Id. ");
		return false;
	}
	if(socrataPwd == null || socrataPwd ==''  || ($.trim(socrataPwd)).length == 0)
	{
		alert("Enter Socrata Password. ");
		return false;
	}
	if(webContentId == null || webContentId ==''  || ($.trim(webContentId)).length == 0 || isNaN(webContentId))
	{
		alert("Enter valid Web Content Id. ");
		return false;
	}

	return true;

}

function <portlet:namespace />_validateSocrataView()
{
	var viewId = document.getElementById("<portlet:namespace />viewId").value;
	var viewName = document.getElementById("<portlet:namespace />viewName").value;
	var viewDesc = document.getElementById("<portlet:namespace />viewDesc").value;
	var viewColId = document.getElementById("<portlet:namespace />viewColId").value;
	var selProbType = document.getElementById("<portlet:namespace />selProbType").value;
	
	if(selProbType == '')
	{
		alert("Selecte a problem type.");
		return false;
	}
	
	if(viewId == null || viewId ==''  || ($.trim(viewId)).length == 0)
	{
		alert("Enter View Id. ");
		return false;
	}

	if(viewName == null || viewName ==''  || ($.trim(viewName)).length == 0)
	{
		alert("Enter View Name. ");
		return false;
	}

	if(viewDesc == null || viewDesc ==''  || ($.trim(viewDesc)).length == 0)
	{
		alert("Enter View Description ");
		return false;
	}

	if(viewColId == null || viewColId ==''  || ($.trim(viewColId)).length == 0)
	{
		alert("Enter Column Field Name. ");
		return false;
	}
	
	return true;

}

function <portlet:namespace />_toggleCofigView(mode)
{
	$('#<portlet:namespace />tblGoogleMapConfig').toggle();
	$('#<portlet:namespace />tblSocrataConfig').toggle();
	
}

function <portlet:namespace />_loadPrbTypeDetails(obj)
{
	if(obj.value=='')
	{
    	$('#<portlet:namespace />viewId').val('');
    	$('#<portlet:namespace />viewName').val('');
    	$('#<portlet:namespace />viewDesc').val('');
    	$('#<portlet:namespace />viewColId').val('');
    	$('#<portlet:namespace />selProbType').val('');
		return;
	}
		
		
 	var url = '<%=getPrbDetailsURL%>';
    url+="&prbType="+obj.value;
    var msg = '<img src=\"<%=request.getContextPath()%>/images/transparent_loading.gif\"/>&nbsp;Loading Details...';
    
    
    //Block the UI before making ajax call
    $.blockUI({ message:msg, css:{width: '160px', top:  ($(window).height() - 50) /2 + 'px', left: ($(window).width() - 150) /2 + 'px'}});
    
    //Make ajax call to update the count
    
    $.ajax({
    type : "POST",
    url : url,
    cache:false,
    dataType: "json",
    success : function(data) 
    {
    	//alert("Result success ---"+data.viewId);
    	//Unblock the UI and show result of ajax call
    	$.unblockUI();
    	$('#<portlet:namespace />viewId').val(data.viewId);
    	$('#<portlet:namespace />viewName').val(data.viewName);
    	$('#<portlet:namespace />viewDesc').val(data.viewDesc);
    	$('#<portlet:namespace />viewColId').val(data.viewColId);
    },
    error : function(XMLHttpRequest, textStatus, errorThrown) 
    {
    	//alert("Result error ---"+errorThrown);


    	//Unblock the UI and show result of ajax call
    	$.unblockUI();
    	$('#<portlet:namespace />viewId').val('');
    	$('#<portlet:namespace />viewName').val('');
    	$('#<portlet:namespace />viewDesc').val('');
    	$('#<portlet:namespace />viewColId').val('');
    	$('#<portlet:namespace />selProbType').val('');


        //Show processing message with slow fade-in effect

        document.getElementById("<portlet:namespace />respStatusMsg").innerHTML="Error occured while processing your request. Please try again or contact administrator.";
        
        $('#<portlet:namespace />respStatusMsg').fadeOut(5000, function() {
            //Reset status-msg innerHTML to &nbsp;
            document.getElementById("<portlet:namespace />respStatusMsg").innerHTML="&nbsp;";
            
            $('#<portlet:namespace />respStatusMsg').fadeIn('fast', function() {});
          });


    }
	});			
	
}
</script>

<label style="color:green; font-style: italic; font-weight: normal; font-size: 1.10em" id="<portlet:namespace />respStatusMsg">
<%
	if(request.getAttribute("StatusMsg")!=null)
	{
%>
		<%=request.getAttribute("StatusMsg")%>
<%
	}
%>
</label><br/><br/>


<table>
	<tr>
		<td>
			<%
				if(StringUtils.isEmpty(selectedTab) || "GoogleMap".equalsIgnoreCase(selectedTab))
				{
			%>
					<b><input type="radio" id="<portlet:namespace />configOptions" name="<portlet:namespace />configOptions" checked="checked" value="map" onchange="<portlet:namespace />_toggleCofigView('map')">&nbsp;&nbsp;Configure Google Map</b>&nbsp;&nbsp;
			<%
				}
				else
				{
			%>
					<b><input type="radio" id="<portlet:namespace />configOptions" name="<portlet:namespace />configOptions" value="map" onchange="<portlet:namespace />_toggleCofigView('map')">&nbsp;&nbsp;Configure Google Map</b>&nbsp;&nbsp;	
			<%
				}
			%>
		</td>
		<td>
			<%
				if("SocrataView".equalsIgnoreCase(selectedTab))
				{
			%>
					<b><input type="radio" id="<portlet:namespace />configOptions" name="<portlet:namespace />configOptions" value="socrata" checked="checked" onchange="<portlet:namespace />_toggleCofigView('socrata')">&nbsp;&nbsp;Configure Socrata Views</b>&nbsp;&nbsp;
			<%
				}
				else
				{
			%>
					<b><input type="radio" id="<portlet:namespace />configOptions" name="<portlet:namespace />configOptions" value="socrata" onchange="<portlet:namespace />_toggleCofigView('socrata')">&nbsp;&nbsp;Configure Socrata Views</b>&nbsp;&nbsp;
			<%
				}
			%>
		</td>
	</tr>
</table>
<br/>

<form id ="<portlet:namespace />defineGoogleMapForm" action="<%=defineGoogleMapURL %>" name="defineGoogleMapForm" method="post" onsubmit="return <portlet:namespace />_validateGoogleMap();">

	<%
		if(StringUtils.isEmpty(selectedTab) || "GoogleMap".equalsIgnoreCase(selectedTab))
		{
	%>
			<table id="<portlet:namespace />tblGoogleMapConfig" style="display: block;">
	<%
		}
		else
		{
	%>
			<table id="<portlet:namespace />tblGoogleMapConfig" style="display: none;">	
	<%
		}
	%>
		<tr>
			<td>
				<b>Google Map Key:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text"  id="<portlet:namespace />mapKey" name = "mapKey" maxlength="1000" value="<%=mapKey%>" size="70"/> 
			</td>
		</tr>
		<tr>
			<td>
				<b>Web Service URL:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />wsUrl" name = "wsUrl" maxlength="1000" value="<%=wsUrl%>" size="70"/> 
			</td>
		</tr>
		<tr>
			<td>
				<b>Socrata URL:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />socrataUrl" name = "socrataUrl" maxlength="1000" value="<%=socrataUrl%>" size="70"/> 
			</td>
		</tr>
		<tr>
			<td>
				<b>Socrata UserId:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />socrataUserId" name = "socrataUserId" maxlength="1000" value="<%=socrataUserId%>" size="50"/> 
			</td>
		</tr>
		<tr>
			<td>
				<b>Socrata Password:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "password" id="<portlet:namespace />socrataPwd" name = "socrataPwd" maxlength="1000" value="<%=socrataPwd%>" size="50"/> 
			</td>
		</tr>
		<tr>
			<td>
				<b>Login Page WebContent ID:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />webContentId" name = "webContentId" maxlength="1000" value="<%=webContentId%>" size="50"/> 
			</td>
		</tr>

		<tr>
			<td colspan="2">
				<input type="submit" value="Save"/>
			</td>
		</tr>
	</table>
</form>


<form id ="<portlet:namespace />defineSocrataViewForm" action="<%=defineSocrataView %>" name="defineSocrataViewForm" method="post" onsubmit="return <portlet:namespace />_validateSocrataView();">
	<%
		if("SocrataView".equalsIgnoreCase(selectedTab))
		{
	%>
		<table id="<portlet:namespace />tblSocrataConfig" style="display:block;">
	<%
		}
		else
		{
	%>
		<table id="<portlet:namespace />tblSocrataConfig" style="display:none;">
	<%
		}
	%>
		<tr>
			<td>
				<b>View Name:</b>&nbsp;&nbsp;
			</td>
			<td>
				<select
				name="selProbType" id="<portlet:namespace />selProbType"
				style="width: 100%; height: 20px" onchange="<portlet:namespace />_loadPrbTypeDetails(this)">
					<option value="">Select Problem Type</option>
					<%
			  			java.util.HashMap<String,com.sf311.portal.beans.ViewBean> prbMap 
	  						= (java.util.HashMap<String,com.sf311.portal.beans.ViewBean>)request.getAttribute("prbTypes");
	  					java.util.Set<String> prbs = prbMap.keySet();
		  				for(String prb: prbs)
		  				{
		  					com.sf311.portal.beans.ViewBean bean = prbMap.get(prb);
		  					
		  					if(prb.equalsIgnoreCase(selectedPrbType))
		  					{
		  			%>
								<option value="<%=prb%>" selected><%=bean.getViewDesc()%></option>
					<%				
							}
		  					else
		  					{
					%> 
								<option value="<%=prb%>"><%=bean.getViewDesc()%></option>
					<%
	  						}
		  				}
	  				%>
			</select>
			</td>
		</tr>
		<tr>
			<td>
				<b>View ID:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />viewId" name = "viewId" size = "15" value="<%=selectedViewId%>"/> 
			</td>
		</tr>		
		<tr>
			<td>
				<b>View Name:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />viewName" name = "viewName" size="70" value="<%=selectedViewName%>"/> 
			</td>
		</tr>		
		<tr>
			<td>
				<b>View Description:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />viewDesc" name = "viewDesc"  size="70" value="<%=selectedViewDesc%>"/> 
			</td>
		</tr>		
		<tr>
			<td>
				<b>Column Field Name:</b>&nbsp;&nbsp;
			</td>
			<td>
				<input type = "text" id="<portlet:namespace />viewColId" name = "viewColId" size="15" value="<%=selectedViewColId%>"/> 
			</td>
		</tr>		

		<tr>
			<td colspan="2">
				<input type="submit" value="Save"/>
			</td>
		</tr>
	</table>
</form>