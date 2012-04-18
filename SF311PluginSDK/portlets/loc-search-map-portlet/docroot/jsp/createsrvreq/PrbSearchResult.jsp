<%@page import="org.apache.commons.lang.StringUtils"%>
<%
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * The contents of this file are subject to the terms of the Liferay Enterprise
 * Subscription License ("License"). You may not use this file except in
 * compliance with the License. You can obtain a copy of the License by
 * contacting Liferay, Inc. See the License for the specific language governing
 * permissions and limitations under the License, including but not limited to
 * distribution rights of the Software.
 *
 *
 *
 */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ page import="com.sf311.portal.beans.*"%>
<jsp:useBean class="java.lang.String" id="selectedProbType"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedProbTypeDesc"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedAddress"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedLat"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedLng"
	scope="request" />
<jsp:useBean class="java.lang.String" id="mapKey"
	scope="request" />
<jsp:useBean class="java.lang.String" id="descPanelBottomPg"
	scope="request" />
<jsp:useBean class="java.lang.String" id="descPanelRightPg"
	scope="request" />
<jsp:useBean class="java.util.LinkedList" id="serviceRequests"
	scope="request" />
<jsp:useBean class="java.lang.String" id="userFirstName"
	scope="request" />
<jsp:useBean class="java.lang.String" id="userLastName"
	scope="request" />
<jsp:useBean class="java.lang.String" id="userFullName"
	scope="request" />
<jsp:useBean class="java.lang.String" id="userEmail"
	scope="request" />
<jsp:useBean class="java.lang.String" id="popupFlag"
	scope="request" />
<jsp:useBean class="java.lang.String" id="refinementUrl"
	scope="request" />
<jsp:useBean class="java.lang.String" id="isExternalFlag"
	scope="request" />
<jsp:useBean class="java.lang.String" id="prbType"
	scope="request" />
<jsp:useBean class="java.lang.String" id="extProcFlag"
	scope="request" />

<portlet:defineObjects />

<portlet:actionURL var="externalRequestURL">
	<portlet:param name="action" value="EXTERNAL_REQUEST" />
	<portlet:param name="selProbType" value="<%=prbType%>" />
</portlet:actionURL>

<script type="text/javascript">

	var externalFlag = '<%=isExternalFlag%>';
	var extenalUrl = '<%=externalRequestURL%>';
	
	if(externalFlag=='true')
	{
		location.href=extenalUrl;
	}
	
	
</script>


<portlet:actionURL var="refinePrbURL">
	<portlet:param name="action" value="refineProblemType" />
</portlet:actionURL>

<portlet:actionURL var="searchActionURL">
	<portlet:param name="action" value="SearchReqByAddress" />
</portlet:actionURL>


<portlet:actionURL var="createSrvReqURL">
	<portlet:param name="action" value="forwardToDestination" />
</portlet:actionURL>

<portlet:resourceURL var="updateSrvReqURL">
	<portlet:param name="action" value="updateSrvReqCount" />
</portlet:resourceURL>
<script
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<%=mapKey%>&sensor=false"
	type="text/javascript"></script>

<script type="text/javascript">
	<%@ include file="/js/marker_script.js" %>
	<%@ include file="/js/map_script.js" %>
</script>


<script type="text/javascript">

var globalPortletNamespace = '<portlet:namespace />_';
function <portlet:namespace />_updateCount(caseId)
{
    var url = '<%=updateSrvReqURL%>';
    url+="&caseId="+caseId;
    var msg = '<img src=\"<%=request.getContextPath()%>/images/transparent_loading.gif\"/>&nbsp;Processing...';
    
    
    //Block the UI before making ajax call
    $.blockUI({ message:msg, css:{width: '160px', top:  ($(window).height() - 50) /2 + 'px', left: ($(window).width() - 150) /2 + 'px'}});
    
    //Make ajax call to update the count
    
    $.ajax({
    type : "POST",
    url : url,
    cache:false,
    dataType: "text",
    success : function(data) 
    {
    	//alert("Result success ---"+data);
    	//Unblock the UI and show result of ajax call
    	$.unblockUI();
    	
        //Show processing message with slow fade-in effect
        document.getElementById("<portlet:namespace />_respStatusMsg").innerHTML=data;
        
        $('#<portlet:namespace />_respStatusMsg').fadeOut(5000, function() {
            //Reset status-msg innerHTML to &nbsp;
            document.getElementById("<portlet:namespace />_respStatusMsg").innerHTML="&nbsp;";
            $('#<portlet:namespace />_respStatusMsg').fadeIn('fast', function() {});
          });


    },
    error : function(XMLHttpRequest, textStatus, errorThrown) 
    {
    	//alert("Result error ---"+errorThrown);


    	//Unblock the UI and show result of ajax call
    	$.unblockUI();

        //Show processing message with slow fade-in effect

        document.getElementById("<portlet:namespace />_respStatusMsg").innerHTML="Error occured while processing your request. Please contact administrator.";
        
        $('#<portlet:namespace />_respStatusMsg').fadeOut(5000, function() {
            //Reset status-msg innerHTML to &nbsp;
            document.getElementById("<portlet:namespace />_respStatusMsg").innerHTML="&nbsp;";
            
            $('#<portlet:namespace />_respStatusMsg').fadeIn('fast', function() {});
          });


    }
	});
}

function <portlet:namespace />_refineProblemType(redirectUrl)
{
	var usrFName = '<%=userFirstName%>';
	var usrLName = '<%=userLastName%>';
	var usrFullName = '<%=userFirstName%>';
	var usrEmail = '<%=userEmail%>';
	var popupFlag = '<%=popupFlag%>';
	var selectedAddr = document.getElementById('<portlet:namespace />_txtAddress').value;
    var refinementForm = document.getElementById("<portlet:namespace />_refinementForm");
	//updateLatLngForRefinement(getCurCenterLat(),getCurCenterLng());

	var redUrl = redirectUrl;
	if(redirectUrl.indexOf('?') != -1)
	{
		redUrl = redUrl+'&userEmail='+escape(usrEmail)+'&userFirstName='+escape(usrFName)+'&userLastName='+escape(usrLName)+'&centerLat='+escape(getCurCenterLat())+'&centerLng='+escape(getCurCenterLng())+'&currentZoom='+getCurZoom()+'&searchAddress='+escape(selectedAddr);
	}
	else
	{
		redUrl = redUrl+'?userEmail='+escape(usrEmail)+'&userFirstName='+escape(usrFName)+'&userLastName='+escape(usrLName)+'&centerLat='+escape(getCurCenterLat())+'&centerLng='+escape(getCurCenterLng())+'&currentZoom='+getCurZoom()+'&searchAddress='+escape(selectedAddr);
	}
		
	if(popupFlag=='true')
	{
		window.open(redUrl);
	}
	else
	{
		document.getElementById("<portlet:namespace />_refinementUrl").value=redirectUrl;
		document.getElementById("<portlet:namespace />_currentZoom").value=getCurZoom();
		refinementForm.submit();		
	}
}

function <portlet:namespace />_validateInputs()
{
	//alert("<portlet:namespace />_validateInputs called");
	var addr = document.getElementById("<portlet:namespace />_txtAddress").value;
	if(addr == null || addr == '')
	{
		alert("Please enter address.");	
		return false;
	}else
	{
		getLatLngByAddress(addr,"<portlet:namespace />_setLatLngForSearch");	
	}
	
	return false;
}




var latList = new Array();
var lngList = new Array();
var addrList = new Array();

</script>

<script type="text/javascript">

	<%
		for(int i=0;i<serviceRequests.size();i++)
		{
			ServiceRequestBean sb = (ServiceRequestBean)serviceRequests.get(i);
	%>	
			latList[<%= i %>] = '<%=sb.getLattitude()%>';
			lngList[<%= i %>] = '<%=sb.getLongitude()%>';
			addrList[<%= i %>] = '<DIV STYLE="overflow:auto;width:250px;height:80px"><table style="font-size: 0.80em"><tr><td align="left"><b>Case Id : </b><a href="javascript:<portlet:namespace />_updateCount(\'<%=sb.getCaseId()%>\');" style="color:blue"><%=sb.getCaseId()%></a></td></tr>'
								+ '<tr><td align="left"><b>Opened : </b><%=sb.getOpenDate()%></td></tr>'
								+ '<tr><td align="left"><b>Request Type : </b><%=sb.getReqType()%></td></tr>'
								+ '<tr><td align="left"><b>Location : </b><%=sb.getLocation()%></td></tr>'
								+ '<tr><td align="left"><b><%=sb.getInterest()%></b></td></tr></table></DIV>';
	<%
		}
	%>

</script>
<br />
<br />

<table align="center" width="98%" height="100%" border="1"
	cellspacing="5" cellpadding="10"
	style="font-size: 1.2em">
	<tr>
		<th align="left" width="100%" colspan="2" valign="middle"
			bgcolor="#cccccc"
			style="font-size: 1.3em; font-weight: bold; color: #ffffff">
			&nbsp;Report <%=selectedProbTypeDesc%></th>
	</tr>
	<tr>
		<td align="center" width="65%" valign="middle"><br />Here are the
			open Requests for <%=selectedProbTypeDesc%> in the City(Updated Nightly)<br />
		<br />
			<form id="<portlet:namespace />_searchForm"
				action="<%=searchActionURL %>" name="searchForm" method="post">
				<input type="hidden" name="txtLattitude" id="<portlet:namespace />_txtLattitude" value="<%=selectedLat%>" />
				<input type="hidden" name="txtLongitude" id="<portlet:namespace />_txtLongitude" value="<%=selectedLng%>" />
				<input type="hidden" name="selProbType" id="<portlet:namespace />_selProbType" value="<%=selectedProbType%>" />
				<input type="hidden" name="selAddress" id="<portlet:namespace />_selAddress" value="<%=selectedAddress%>" />
				<table align="center" width="95%" border="0">
					<tr>
						<td align="right" width="5%" valign="middle">&nbsp;&nbsp;<font
							style="font-weight: bold; font-size: 1.3em">Address:</font>&nbsp;&nbsp;</td>
						<td align="left" width="90%" valign="bottom"><input
							type="text" id="<portlet:namespace />_txtAddress" name="txtAddress"
							style="width: 90%; vertical-align: bottom;"
							value="<%=selectedAddress%>" onkeydown="javascript:return invokeEnterKey(event);"/>&nbsp;&nbsp;</td>
						<td align="left" width="5%" valign="middle"><input
							type="button" value="Search" onClick="<portlet:namespace />_validateInputs()" />
						</td>
					</tr>
				</table>
			</form> <br />

			<%
				if((StringUtils.isEmpty(selectedLat) || StringUtils.isEmpty(selectedLng) 
						|| ("null".equalsIgnoreCase(selectedLat))  || ("null".equalsIgnoreCase(selectedLng))) 
						&& (!("true".equalsIgnoreCase(extProcFlag))))
				{
			%>
					<div id="divAlert" style="width: 95%;font-weight: bold; font-size: 0.95em; color: #FF0000; text-align: left;">
						Address <i>"<%=selectedAddress %>"</i> you entered could not be found. You may choose any of the following options:<br/>
						<ul>
							<li>Verify the address and click Search.</li>
							<li>Adjust the blue pin and press Enter.</li>
							<li>Continue with the same address by selecting reporting options below.</li>
						</ul>
					</div><br/>
			<%
				}
			%>
			<div style="color:red; font-style: italic; font-weight: bold; font-size: 1.05em" id="<portlet:namespace />_respStatusMsg">&nbsp;</div><br/>
			<div id="<portlet:namespace />_map_canvas" style="width: 95%; height: 300px;"></div><br/>
			<div id="<portlet:namespace />_descPanelBottom" style="text-align: left; width:95%"><jsp:include page="<%=descPanelBottomPg%>"/></div>
		</td>
		<td align="center" width="35%" valign="top"><div id="<portlet:namespace />_descPanelRight" style="width:95%;text-align:left"><jsp:include page="<%=descPanelRightPg%>"/></div></td>
	</tr>
</table>
<script type="text/javascript">

	if(latList.length == 0)
	{
	   latList[0] = '<%=selectedLat%>';
	}

	if(lngList.length == 0)
	{
		lngList[0] = '<%=selectedLng%>';
	}

	loadMap(latList,lngList,addrList,'<portlet:namespace />_map_canvas');
		
	locateAddressOnMap('<%=selectedLat%>','<%=selectedLng%>','<portlet:namespace />_updateSelectedAddr');
</script>
<form id="<portlet:namespace />_refinementForm"
	action="<%=refinePrbURL%>" name="refinementForm" method="post" target="_blank">
	<input type="hidden" name="txtLattitude" id="<portlet:namespace />_txtLattitude" value="<%=selectedLat%>" />
	<input type="hidden" name="txtLongitude" id="<portlet:namespace />_txtLongitude" value="<%=selectedLng%>" />
	<input type="hidden" name="selProbType" id="<portlet:namespace />_selProbType" value="<%=selectedProbType%>" />
	<input type="hidden" name="refinementUrl" id="<portlet:namespace />_refinementUrl" value="" />
	<input type="hidden" name="selAddress" id="<portlet:namespace />_selAddress" value="<%=selectedAddress%>" />
	<input type="hidden" name="actUrl" id="<portlet:namespace />_actUrl" value="<%=createSrvReqURL%>" />
	<input type="hidden" name="currentZoom" id="<portlet:namespace />_currentZoom" value="" />
</form>
