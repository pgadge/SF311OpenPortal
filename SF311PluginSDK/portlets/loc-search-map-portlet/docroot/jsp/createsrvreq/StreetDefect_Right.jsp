<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>

<head>
<style type="text/css">
.style2 {
	font-size: small;
	font-family: Arial, Helvetica, sans-serif;
}
.style3 {
	font-family: Arial, Helvetica, sans-serif;
}
</style>
</head>

<h2 class="style3">Streets of San Francisco</h2>
<span class="style3">Our streets are an important part of the City&#39;s infrastructure. They are our 
means of transport and connect us to many places whether we walk, drive, bike, 
or ride public transit.
</span>
<span class="style2">&nbsp;Department of Public Works (DPW) </span>
<span class="style3">is responsible for maintaining and ensuring that our roads and rights of way are 
clean, safe, accessible and enjoyable. <br>
<br>
<a href="http://sfdpw.org/index.aspx?page=1114">Information on DPW Projects and 
Programs</a></span></p>
<ul>
	<li class="style3">Resurfacing </li>
	<li class="style3">Slurry Seal Pavement Maintenance</li>
	<li class="style3">Assessing Pavement Conditions</li>
	<li class="style3">5-Year Plan</li>
	<li class="style3">Street Permits</li>
</ul>
<p class="style3"><a href="http://sfdpw.org/index.aspx?page=298">Information on Pothole Repair</a></p>
<p><span class="style3"><a href="http://sfdpw.org/index.aspx?page=322">Mechanical Street Sweeping 
Program Information</a><br>
</span>
<portlet:defineObjects />
<portlet:actionURL var="defineGoogleMapURL">
<portlet:param name="action" value="configureGoogleMap" /></portlet:actionURL>
</p>
<p class="style3">Please provide the following information with your service request:</p>
<ul>
	<li>
	<p class="style3">Location where service is needed (address or intersection)</p>
	</li>
	<li>
	<p class="style3">Type of defect (pothole, crack in pavement, sewers, etc.)</p>
	</li>
</ul>





