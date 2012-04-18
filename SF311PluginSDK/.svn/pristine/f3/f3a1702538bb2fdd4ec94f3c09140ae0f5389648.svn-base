
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
<%@page import="com.sf311.portal.beans.MyServiceRequestBean" %>
<jsp:useBean class="java.util.LinkedList" id="myServiceRequests"
	scope="request" />
<jsp:useBean class="java.lang.String" id="caseUrl"
	scope="request" />
<jsp:useBean class="java.lang.String" id="userEmail"
	scope="request" />

<portlet:defineObjects />

<script type="text/javascript">
var tableId = '<portlet:namespace/>_MySrvReqTable';
$(document).ready( function () {
	$('#'+tableId).dataTable({
		"oSearch": {"sSearch": "", "bRegex": false, "bSmart": false}
	});
} );
</script>
<table id="<portlet:namespace/>_MySrvReqTable" class="display" width="80%" align="center">
	<thead>
		<tr>
			<th>Case ID</th>
			<th>Case Type</th>
			<th>Created Date</th>
			<th>Status</th>
		</tr>
	</thead>
	<tbody>
	<%
		for(int i=0;i<myServiceRequests.size();i++)
		{
	%>
		<tr>
			<td><a href="<%=caseUrl%>?ref=<%=((MyServiceRequestBean)myServiceRequests.get(i)).getServiceReqId()%>&email=<%=userEmail%>" target="caseDetWin"><%=((MyServiceRequestBean)myServiceRequests.get(i)).getServiceReqId() %></a></td>
			<td><%=((MyServiceRequestBean)myServiceRequests.get(i)).getType() %></td>
			<td><%=((MyServiceRequestBean)myServiceRequests.get(i)).getCreatedDate() %></td>
			<td><%=((MyServiceRequestBean)myServiceRequests.get(i)).getStatus() %></td>
		</tr>
	<%	
		} 
	%>
	</tbody>
</table>