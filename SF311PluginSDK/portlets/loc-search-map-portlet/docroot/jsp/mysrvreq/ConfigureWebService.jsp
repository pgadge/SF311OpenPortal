<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<jsp:useBean class="java.lang.String" id="wsUrl"
	scope="request" />
<jsp:useBean class="java.lang.String" id="caseUrl"
	scope="request" />

<portlet:defineObjects />

<portlet:actionURL var="defineWebServiceURL">
	<portlet:param name="action" value="configureWebService" />
</portlet:actionURL>

<script type="text/javascript">

function validateInputs()
{
	var wsUrl = document.getElementById("wsUrl").value;
	var caseWsUrl = document.getElementById("caseWsUrl").value;
	
	if(wsUrl == null || wsUrl ==''  || ($.trim(wsUrl)).length == 0)
	{
		alert("Enter Web Service URL. ");
		return false;
	}

	if(caseWsUrl == null || caseWsUrl ==''  || ($.trim(caseWsUrl)).length == 0)
	{
		alert("Enter Case Details URL. ");
		return false;
	}

	return true;

}
</script>

<form id ="<portlet:namespace/>defineWebServiceForm" action="<%=defineWebServiceURL %>" name="defineWebServiceForm" method="post" onsubmit="return validateInputs();">
<%if(request.getAttribute("StatusMsg")!=null){
%>
	<label style="color:green; font-style: italic; font-weight: normal; font-size: 1.10em"><%=request.getAttribute("StatusMsg")%></label><br/><br/>
<%
}%>

<table>
<tr><td>
<b>Web Service URL:</b>&nbsp;&nbsp;
</td><td>
<input type = "text" id="wsUrl" name = "wsUrl" maxlength="1000" value="<%=wsUrl%>" size="70"/> 
</td>
</tr>
<tr><td>
<b>Case Details URL:</b>&nbsp;&nbsp;
</td><td>
<input type = "text" id="caseWsUrl" name = "caseWsUrl" maxlength="1000" value="<%=caseUrl%>" size="70"/> 
</td>
</tr>
<tr><td colspan="2">
<input type="submit" value="Save"/>
</td></tr>
</table>
</form>