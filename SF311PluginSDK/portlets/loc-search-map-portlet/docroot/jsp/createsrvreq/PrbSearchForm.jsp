
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
<jsp:useBean class="java.lang.String" id="mapKey"
	scope="request" />

<portlet:defineObjects />

<portlet:actionURL var="searchActionURL">
	<portlet:param name="action" value="SearchReqByAddress" />
</portlet:actionURL>

<script
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<%=mapKey %>&sensor=false"
	type="text/javascript"></script>

<script type="text/javascript">
	<%@ include file="/js/marker_script.js" %>
	<%@ include file="/js/map_script.js" %>
</script>


<script type="text/javascript">
	function <portlet:namespace />_validateInputs()
	{
		var addr = document.getElementById("<portlet:namespace />_txtAddress").value;
		if(addr == null || addr == '')
		{
			alert("Please enter address.");	
			return false;
		}else
		{
			getLatLngByAddress(addr,'<portlet:namespace />_setLatLngForSearch');	
		}
		
		return false;
	}
	
	$(document).ready(function() {
		
		$("#<portlet:namespace />_txtAddress").focus();
		
		
		$("#<portlet:namespace />_myTextArea").show();
			$("#<portlet:namespace />_myTextArea").val($('#<portlet:namespace />_selProbType').val());
					   
		   
		
		$('#<portlet:namespace />_selProbType').change(function(){
		   
			$("#<portlet:namespace />_txtAddress").val('');
			 $("#<portlet:namespace />_txtAddress").attr('readonly',false);
			 $("#<portlet:namespace />_submitButton").attr('disabled',false);
			   
			$("#<portlet:namespace />_txtAddress").focus();
			$("#<portlet:namespace />_myTextArea").val($('#<portlet:namespace />_selProbType').val());
			
			 if($('#<portlet:namespace />_selProbType').val() == "Send a compliment or file a Complaint concerning Muni services.")
		   		{
				   $("#<portlet:namespace />_txtAddress").val('Not Applicable');
				   $("#<portlet:namespace />_txtAddress").attr('readonly',true);
				   $("#<portlet:namespace />_submitButton").attr('disabled',true);
		   		}
			   	
		  
		});
		
		
	});
	
	

	
</script>

<form id="<portlet:namespace />_searchForm"
	action="<%=searchActionURL %>" name="searchForm"  method="post"
	onsubmit="return validateInputs();">
	<input type="hidden" name="txtLattitude" id="<portlet:namespace />_txtLattitude" value="" />
	<input type="hidden" name="txtLongitude" id="<portlet:namespace />_txtLongitude" value="" />
	<font color="red"><b><center>If this is a police, fire, medical, or other emergency, please call 911 immediately.</center></b></font>
	<br>
	<table align="center" width="90%" border="0">
		<tr>
		
			<td align="right" width="30%" valign="middle"><font
				style="font-weight: bold; font-size: 1.3em">I would like to
					report</font>&nbsp;&nbsp;</td>
			<td align="left" width="30%" valign="middle">
			<select name="selProbType" id="<portlet:namespace />_selProbType"
				style="width: 100%; height: 20px">
					<%
	  			java.util.HashMap<String,com.sf311.portal.beans.ViewBean> prbMap 
	  				= (java.util.HashMap<String,com.sf311.portal.beans.ViewBean>)request.getAttribute("prbTypes");
	  				java.util.Set<String> prbs = prbMap.keySet();
	  				for(String prb: prbs)
	  				{
	  					com.sf311.portal.beans.ViewBean bean = prbMap.get(prb);
	  					//String fullDesc = bean.getViewFullDescription();
	  			%>			
					<option value="<%=prb%>" ><%=bean.getViewDesc()%></option>
					<% 
	  				}
	  			%>
			</select>
			</td>
			<td align="right" width="3%" valign="middle">&nbsp;&nbsp;<font
				style="font-weight: bold; font-size: 1.3em">Near:</font>&nbsp;&nbsp;</td>
			<td align="center" width="27%" valign="middle">
			<input
				type="text" id="<portlet:namespace />_txtAddress" name="txtAddress"
				style="width: 90%; height: 8px; vertical-align: middle;" onkeydown="javascript:return invokeEnterKey(event);"/>&nbsp;&nbsp;</td>
			<td align="left" width="10%" valign="middle"><input
				id ="<portlet:namespace />_submitButton"  type="button" value="NEXT"  onClick="<portlet:namespace />_validateInputs()"
				style="height: 23px" />
			</td>
		</tr>
		</table>
		
		<br>
		<table align="center" width="100%" >
		 <tr>		
			<td align="center" width = 80% valign="bottom" ><font
				style="font-weight: bold; font-size: 1.2em">
				
					<b>
					<textarea name = "content"  draggable="false" wrap="soft" id="<portlet:namespace />_myTextArea" cols="80" style= "width:80%; border: 2; border-width: medium; resize:none; text-align: center; font-size: medium; font: bold;"  rows="1.5"  readonly="readonly" >
									
					</textarea></b>
					<%-- <option value="<%=prb%>" ><%=bean.getViewDesc()%></option> --%>
					
				
			</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr> 
	</table>
	<br>
	
</form>