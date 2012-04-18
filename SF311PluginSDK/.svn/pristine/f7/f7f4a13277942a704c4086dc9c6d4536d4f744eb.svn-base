package com.sf311.portal.mvc;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.GenericPortlet;
import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import noNamespace.ServiceRequestDocument.ServiceRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sfgov.liferayusrcases.services.GetLiferayUserCasesDocument;
import org.sfgov.liferayusrcases.services.GetLiferayUserCasesResponseDocument;
import org.sfgov.liferayusrcases.services.LiferayUsrCasesServiceStub;

import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.sf311.portal.beans.MyServiceRequestBean;


public class MyServiceRequestsPortlet extends GenericPortlet 
{
	protected String viewJSP;
	protected String editJSP;

	private static Log Logger = LogFactory.getLog(MyServiceRequestsPortlet.class);
	
	public void init() throws PortletException 
	{ 
		viewJSP = getInitParameter("view-jsp");
		editJSP = getInitParameter("edit-jsp");
		
	}
	
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException 
	{ 
		String wsUrl = getPrefAttribute(renderRequest,"webServiceUrl");
		String caseUrl = getPrefAttribute(renderRequest,"caseWsUrl"); 

		
		if ("".equalsIgnoreCase(caseUrl) || "".equalsIgnoreCase(wsUrl) ) 
		{
			renderRequest.setAttribute("StatusMsg", "Please configure Web Service URL and Case Details URL.");
			include(editJSP, renderRequest, renderResponse);
		} 
		else
		{
			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
			
			wsUrl = getPrefAttribute(renderRequest,"webServiceUrl");
			caseUrl = getPrefAttribute(renderRequest,"caseWsUrl"); 

			try
			{
		        LiferayUsrCasesServiceStub stub = new LiferayUsrCasesServiceStub(wsUrl);

		        GetLiferayUserCasesDocument ucDoc = GetLiferayUserCasesDocument.Factory.newInstance();
		        ucDoc.addNewGetLiferayUserCases().setLiferayId(String.valueOf(themeDisplay.getUserId()));
		        //ucDoc.addNewGetLiferayUserCases().setLiferayId(String.valueOf(10374));
		        
		        GetLiferayUserCasesResponseDocument ucRespDoc = null;
		        ucRespDoc = stub.getLiferayUserCases(ucDoc);
		        		        
		        List<MyServiceRequestBean> srvReqList = new LinkedList<MyServiceRequestBean>();
		        
		        for(ServiceRequest sreq : ucRespDoc.getGetLiferayUserCasesResponse().getLiferayuserServiceRequests().getServiceRequestArray())
		        {
		        	MyServiceRequestBean bean = new MyServiceRequestBean();
		        	bean.setServiceReqId(sreq.getCaseId());
		        	bean.setCreatedDate(sreq.getCreatedDt());
		        	bean.setType(sreq.getRequestType());
		        	bean.setStatus(sreq.getStatus());
		        	srvReqList.add(bean);
		        }
		        
				//check if user is already logged in and set the flag accordingly
				//Long userId = themeDisplay.getUserId();
				String email = themeDisplay.getUser().getEmailAddress();
				

		        renderRequest.setAttribute("myServiceRequests", srvReqList);
		        //renderRequest.setAttribute("userId",String.valueOf(userId));
		        renderRequest.setAttribute("userEmail", email);
		        renderRequest.setAttribute("caseUrl", caseUrl);

			}
			catch(Exception e)
			{
				Logger.error("Exception occured in SearchResultPortlet.processAction()",e);
				throw new PortletException("Error occured while retrieving your service request. Please contact administrator.");
			}

			include(viewJSP, renderRequest, renderResponse);
		}
	}
	
	public void processAction(ActionRequest actionRequest,	ActionResponse actionResponse) throws IOException, PortletException 
	{
		String action = actionRequest.getParameter("action");
		PortletPreferences preferences= actionRequest.getPreferences();

		if("configureWebService".equalsIgnoreCase(action))
		{
			String wsUrl = actionRequest.getParameter("wsUrl");
			String caseUrl = actionRequest.getParameter("caseWsUrl"); 
			preferences.setValue("webServiceUrl",wsUrl);
			preferences.setValue("caseWsUrl",caseUrl);
			preferences.store();
			
			actionRequest.setAttribute("StatusMsg", "Request Processed Successfully");
			return;	
		}
	}
	
	protected void include(String path, RenderRequest renderRequest,RenderResponse renderResponse) throws IOException, PortletException 
	{
			PortletRequestDispatcher portletRequestDispatcher = getPortletContext().getRequestDispatcher(path);
			if (portletRequestDispatcher == null) 
			{ 
				Logger.error(path + " is not a valid include");
			} else 
			{ 
				portletRequestDispatcher.include(renderRequest, renderResponse);
			}
	}
	
	protected void doEdit(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException{

		String wsUrl = getPrefAttribute(renderRequest,"webServiceUrl"); 
		String caseUrl = getPrefAttribute(renderRequest,"caseWsUrl"); 

		renderRequest.setAttribute("wsUrl", wsUrl);
        renderRequest.setAttribute("caseUrl", caseUrl);

		include(editJSP, renderRequest, renderResponse);
	} 

	private String getPrefAttribute(RenderRequest renderRequest,String attrName)
	{
		PortletPreferences prefs = renderRequest.getPreferences();
		String mapKey = (String)prefs.getValue(attrName, ""); 
		return mapKey;
	}


}
