<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>

<head>
<meta http-equiv="Content-Language" content="en-us">
<style type="text/css">
.style1 {
	font-family: Arial, Helvetica, sans-serif;
}
</style>
</head>

<table style="width: 100%">
	<tr>
		<td style="width: 50%">

<portlet:defineObjects />

<p><span class="style1"><strong>Street issues</strong></span>
<span class="style1"> <a title="In a park" onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Structural_Maintenance&amp;Nature_of_request=Pavement&amp;eformTitle=Recreation and Park - Pavement','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Structural_Maintenance&amp;Nature_of_request=Pavement&amp;eformTitle=Recreation%20and%20Park%20-%20Pavement">
<strong>in a park</strong></a><strong> 
or
</strong>
<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Street_Defects.xml?&amp;Nature_of_request=Manhole_Cover_Off&amp;eformTitle=DPW - Manhole Cover','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Street_Defects.xml?&amp;Nature_of_request=Manhole_Cover_Off&amp;eformTitle=DPW%20-%20Manhole%20Cover">
<strong>other locations</strong></a></span></p>
<ul>
	<li class="style1">Street / Road Defects (Potholes)</li>
	<li class="style1">Manhole / Construction Plates Shifted / Off</li>
</ul>
		<p class="style1">&nbsp;</p>
		</td>
		<td valign="top">
		<p><span class="style1"><strong>Street cleaning issues</strong></span>
		<span class="style1">
			<a href="%3CA%20onclick=%22javascript:window.open('http:/crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;amp;GroupName=Neighborhood_Services_Area&amp;amp;Nature_of_request=Other&amp;amp;eformTitle=Recreation and Parks','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false&quot; href=&quot;http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;amp;GroupName=Neighborhood_Services_Area&amp;amp;Nature_of_request=Other&amp;amp;eformTitle=Recreation%20and%20Parks&quot;&gt;In a park&lt;/A&gt;">
			<strong>in a park</strong></a><strong> or
			</strong>
			<a href="%3CA%20onclick=%22javascript:window.open('http:/crmproxy.sfgov.org/Ef3/SSP_Street_Sidewalk_Cleaning.xml?&amp;amp;Nature_of_request=Street_Cleaning&amp;amp;eformTitle=DPW - Street Cleaning','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false&quot; href=&quot;http://crmproxy.sfgov.org/Ef3/SSP_Street_Sidewalk_Cleaning.xml?&amp;amp;Nature_of_request=Street_Cleaning&amp;amp;eformTitle=DPW%20-%20Street%20Cleaning&quot;&gt;Other locations&lt;/A&gt;">
			<strong>other locations</strong></a></span></p>
		<ul>
			<li class="style1">
			Illegal Dumping</li>
			<li class="style1">
			Missed Route</li>
		</ul>
		</td>
	</tr>
	<tr>
		<td style="height: 10px" colspan="2">
		<p class="style1"><strong>Sewers Flooding / Sewage </strong>
		<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Structural_Maintenance&amp;Nature_of_request=Other&amp;eformTitle=Recreation and Park - Other','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Structural_Maintenance&amp;Nature_of_request=Other&amp;eformTitle=Recreation%20and%20Park%20-%20Other">
		<strong>in a park</strong></a><strong> or </strong>
		<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Sewer_Issues.xml?&amp;Nature_of_request=Flooding&amp;eformTitle=DPW - Sewers','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Sewer_Issues.xml?&amp;Nature_of_request=Flooding&amp;eformTitle=DPW%20-%20Sewers">
		<strong>Other locations</strong></a><br>
		</p>
		</td>
	</tr>
	<tr>
		<td>
		<p class="style1">&nbsp;</p>
		</td>
		<td class="style1">&nbsp;</td>
	</tr>
</table>


