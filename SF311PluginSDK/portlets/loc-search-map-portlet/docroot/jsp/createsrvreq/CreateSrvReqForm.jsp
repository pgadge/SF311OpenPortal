
<%@page import="com.sf311.portal.util.SF311Constants"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.theme.ThemeDisplay"%>
<%@page import="com.liferay.portal.model.User"%>
<%@page import="com.liferay.portal.service.UserLocalServiceUtil"%>
<%@page import="javax.portlet.RenderRequest"%>
<%@page import="javax.portlet.PortletPreferences"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

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
<jsp:useBean class="java.lang.String" id="redActUrl"
	scope="request" />
<jsp:useBean class="java.lang.String" id="popupFlag"
	scope="request" />
<jsp:useBean class="java.lang.String" id="finalUrlToPopup"
	scope="request" />
<jsp:useBean class="java.lang.String" id="createAcctUrl"
	scope="request" />
<jsp:useBean class="java.lang.String" id="refinementUrl"
	scope="session" />
<jsp:useBean class="java.lang.String" id="selectedLat"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedLng"
	scope="request" />
<jsp:useBean class="java.lang.String" id="currentZoom"
	scope="request" />
<jsp:useBean class="java.lang.String" id="selectedAddress"
	scope="request" />

<portlet:defineObjects />

<portlet:actionURL var="createSrvReqURL">
	<portlet:param name="action" value="forwardToDestination" />
</portlet:actionURL>

<script type="text/javascript">

	var popupFlag = '<%=popupFlag%>';
	var popupUrl = '<%=finalUrlToPopup%>';
	var crAcctUrl = '<%=createAcctUrl%>';
	var refUrl = '<%=refinementUrl%>';
	var selLat = '<%=selectedLat%>';
	var selLng = '<%=selectedLng%>';
	var curZoom = '<%=currentZoom%>';
	var selAddr = '<%=selectedAddress%>';
	
	if(popupFlag=='true')
	{
		window.opener.location.reload();
		location.href=popupUrl;
	}

	function <portlet:namespace />_submitForm(action)
	{
		var redirectUrl = '<%=redActUrl%>';

		
		if(action == 'login')
		{
			location.href = '/c/portal/login?redirect='+escape(redirectUrl);
		}

		if(action == 'create_account')
		{
			location.href = crAcctUrl+'&redirect='+escape(redirectUrl);
		}

		if(action == 'remain_anonymous')
		{
			if(refUrl.indexOf('?') != -1)
				redirectUrl=refUrl+'&userEmail=ANONYMOUS&userFirstName=ANONYMOUS&userLastName=ANONYMOUS&centerLat='+escape(selLat)+'&centerLng='+escape(selLng)+'&currentZoom='+curZoom+'&searchAddress='+escape(selAddr);
			else
				redirectUrl=refUrl+'?userEmail=ANONYMOUS&userFirstName=ANONYMOUS&userLastName=ANONYMOUS&centerLat='+escape(selLat)+'&centerLng='+escape(selLng)+'&currentZoom='+curZoom+'&searchAddress='+escape(selAddr);

		    location.href=redirectUrl;
		}

	}
</script>
</table>
<%
	PortletPreferences pref = renderRequest.getPreferences();
	String contentId = pref.getValue(SF311Constants.WEB_CONTENT_ID,"-1");
	ThemeDisplay td = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
	long scopeGroupId = td.getScopeGroupId();
	
%>

<table align="center" width="60%" height="100%" border="1"
	cellspacing="5" cellpadding="10"
	style="font-size: 1.2em">
	<tr>
		<td align="center" width="100%" valign="middle" colspan="3">
			You are not logged in. You can either Login, Register or remain Anonymous. 
		</td>
	</tr>
	<tr>
		<td align="center" width="33%" valign="middle">
			<a href="javascript:<portlet:namespace />_submitForm('login');">Login</a> 
		</td>
		<td align="center" width="33%" valign="middle">
			<a href="javascript:<portlet:namespace />_submitForm('create_account');">Create Account</a> 
		</td>
		<td align="center" width="33%" valign="middle">
			<a href="javascript:<portlet:namespace />_submitForm('remain_anonymous');">Remain Anonymous</a> 
		</td>
	</tr>
<br/>
<table align="center" width="60%" height="100%" border="0"
	cellspacing="5" cellpadding="10"
	style="font-size: 1.2em">
	<tr>
		<td width="100%" valign="middle">
			<liferay-ui:journal-article articleId="<%=contentId%>" groupId="<%=scopeGroupId%>" /> 
		</td>
	</tr>
</table>

