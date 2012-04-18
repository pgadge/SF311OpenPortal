<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<portlet:defineObjects />

<p>
	<span style="font-size: 12px">&nbsp;<strong>You can adjust the map to see if we already have your request.</strong></span>
</p>
<ul>
	<li>
		<span style="font-size: 12px">&nbsp;If we do, click on the service request number to show you want it fixed too. (The totals update daily).</span>
	</li>
	<li>
		<span style="font-size: 12px">&nbsp;If we don't, use one of the links below to report the new problem.</span>
	</li>
</ul>
<div style="margin-left: 40px">
	<span style="font-size: 12px">
		<strong>
			<a href="javascript:<portlet:namespace />_refineProblemType('/testParameteres.jsp');">Graffiti on Private Property</a>
		</strong>
		<br />
		Personal residences, homes, office buildings and their sidewalks<br />&nbsp;
	</span>
</div>
<div style="margin-left: 40px">
	<span style="font-size: 12px">
		<strong>
			<a href="javascript:<portlet:namespace />_refineProblemType('http://crm-dev9.311.sfgov.org/Ef3/SSP_Graffiti_Public.xml?&eformTitle=Graffiti%20-%20Public%20Property');" >Graffiti on Public Property</a>
		</strong>
		<br />
		Bike racks, City garbage can, newsrack, mailbox, public toilets, parking meters, fire hydrants, etc.<br />&nbsp;
	</span>
</div>
<div style="margin-left: 40px">
	<span style="font-size: 12px">
		<strong>
			<a href="javascript:<portlet:namespace />_refineProblemType('http://crm-dev9.311.sfgov.org/Ef3/SSP_Rec_Park.xml?&GroupName=Structural_Maintenance&Nature_of_request=Graffiti&eformTitle=Recreation%20and%20Park%20-%20Graffiti');" >Graffiti in a Park</a>
		</strong>
		<br />
		City parks or playgrounds including Golden Gate Park and John McLaren Park
	</span>
</div>
<div style="margin-left: 40px">
	<br />
	<span style="font-size: 12px">
		<strong>
			<a href="javascript:<portlet:namespace />_refineProblemType('http://crm-dev9.311.sfgov.org/Ef3/SSP_DPT_SignRepairReplace.xml?username=eformws&eformtitle=DPT%20SignRepairReplace');">Graffiti on a Sign</a>
		</strong>
		<br />
		Graffiti located a sign such as parking and traffic signs (Such as Street Names, Directional (Right/Left), One Way) and Parking signs (Such as Street Cleaning, No Parking, Residential Parking Permit)<br />&nbsp;
	</span>
</div>