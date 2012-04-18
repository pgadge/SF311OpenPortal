<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>

<head>
<meta http-equiv="Content-Language" content="en-us">
<style type="text/css">
.style1 {
	border-left-width: 0;
	border-top-width: 0;
		border-right-color: #C0C0C0;
	border-right-width: 0;
	border-bottom-color: #C0C0C0;
	border-bottom-width: 0;
}
.style4 {
	border-left: 0 solid #C0C0C0;
	border-right-style: solid;
	border-right-width: 0;
	border-top: 0 solid #C0C0C0;
	border-bottom-style: solid;
	border-bottom-width: 0;
	text-align: center;
	font-family: Arial, Helvetica, sans-serif;
}
.style5 {
	border-left: 0 solid #C0C0C0;
	border-right-style: solid;
	border-right-width: 0;
	border-top: 0 solid #C0C0C0;
	border-bottom-style: solid;
	border-bottom-width: 0;
	font-family: Arial, Helvetica, sans-serif;
	margin-left: 40px;
}
</style>
</head>

<table style="width: 100%">
	<tr>
		<td style="width: 710px">
		<table style="width: 100%" class="style1">
			<tr>
				<td class="style5" style="width: 262px">
				<ul>
					<li>Illegal Dumping</li>
				</ul>
				</td>
				<td class="style4" style="width: 157px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&GroupName=Neighborhood_Services_Area&Nature_of_request=Trash_Dumping&eformTitle=Recreation%20and%20Parks','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&GroupName=Neighborhood_Services_Area&Nature_of_request=Trash_Dumping&eformTitle=Recreation%20and%20Parks">In a park</a></td>
				<td class="style4" style="width: 165px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Street_Sidewalk_Cleaning.xml?&amp;Nature_of_request=Illegal_Dumping&amp;eformTitle=DPW - Illegal Dumping','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Street_Sidewalk_Cleaning.xml?&amp;Nature_of_request=Illegal_Dumping&amp;eformTitle=DPW%20-%20Illegal%20Dumping">Other locations</a></td>
			</tr>
			<tr>
				<td class="style5" style="width: 262px">
				<ul>
					<li>Damaged Garbage Can</li>
				</ul>
				</td>
				<td class="style4" style="width: 157px">
				<a title="In a park" onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation and Park - Trash','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation%20and%20Park%20-%20Trash">In a park</a></td>
				<td class="style4" style="width: 165px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=Damaged_City_Can&amp;eformTitle=DPW - Damaged Garbage Can','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=Damaged_City_Can&amp;eformTitle=DPW%20-%20Damaged%20Garbage%20Can">Other locations</a></td>
			</tr>
			<tr>
				<td class="style5" style="width: 262px">
				<ul>
					<li>Overflowing Garbage Can</li>
				</ul>
				</td>
				<td class="style4" style="width: 157px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation and Park - Garbage Cans','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation%20and%20Park%20-%20Garbage%20Cans">In a park</a></td>
				<td class="style4" style="width: 165px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Street_Sidewalk_Cleaning.xml?&amp;Nature_of_request=Overflowing_City_Receptacle_or_Dumpster&amp;eformTitle=DPW - Overflowing City Receptacle ','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Street_Sidewalk_Cleaning.xml?&amp;Nature_of_request=Overflowing_City_Receptacle_or_Dumpster&amp;eformTitle=DPW%20-%20Overflowing%20City%20Receptacle">Other locations</a></td>
			</tr>
			<tr>
				<td class="style5" style="width: 262px">
				<ul>
					<li>Graffiti on Garbage Can</li>
				</ul>
				</td>
				<td class="style4" style="width: 157px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Structural_Maintenance&amp;Nature_of_request=Graffiti&amp;eformTitle=Recreation and Park - Other','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Structural_Maintenance&amp;Nature_of_request=Graffiti&amp;eformTitle=Recreation%20and%20Park%20-%20Other">In a park</a></td>
				<td class="style4" style="width: 165px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Graffiti_Public.xml?&amp;eformTitle=Graffiti - Public','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Graffiti_Public.xml?&amp;eformTitle=Graffiti%20-%20Public">Other locations</a></td>
			</tr>
			<tr>
				<td class="style5" style="width: 262px; height: 23px;">
				<ul>
					<li>Install/Remove Garbage Cans</li>
				</ul>
				</td>
				<td class="style4" style="width: 157px; height: 23px;">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation and Park','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation%20and%20Park">In a park</a></td>
				<td class="style4" style="width: 165px; height: 23px;">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=New_Litter_Receptacle&amp;eformTitle=DPW - City Garbage Can','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=New_Litter_Receptacle&amp;eformTitle=DPW%20-%20City%20Garbage%20Can">Other locations</a></td>
			</tr>
			<tr>
				<td class="style5" style="width: 262px">
				<ul>
					<li>Construction Debris 
				Boxes</li>
				</ul>
				</td>
				<td class="style4" style="width: 157px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation and Park','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;Nature_of_request=Trash_Dumping&amp;eformTitle=Recreation%20and%20Park">In a park</a></td>
				<td class="style4" style="width: 165px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=Debris_Box&amp;eformTitle=DPW - Debris Box','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=Debrix_Box&amp;eformTitle=DPW%20-%20Debris%20Box">Other locations</a></td>
			</tr>
			<tr>
				<td class="style5" style="width: 262px">
				<ul>
					<li>Other</li>
				</ul>
				</td>
				<td class="style4" style="width: 157px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;eformTitle=Recreation and Park','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Rec_Park.xml?&amp;GroupName=Neighborhood_Services_Area&amp;eformTitle=Recreation%20and%20Park">In a park</a></td>
				<td class="style4" style="width: 165px">
				<a onclick="javascript:window.open('http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=Other_enter_additional_details_below&amp;eformTitle=DPW - Garbage Cans','windows','width=900,height=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false" href="http://crmproxy.sfgov.org/Ef3/SSP_Litter_Receptacle_Issue.xml?&amp;Nature_of_request=Other_enter_additional_details_below&amp;eformTitle=DPW%20-%20Garbage%20Cans">Other locations</a></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>

