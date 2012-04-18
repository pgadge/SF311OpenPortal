package com.sf311.portal.mvc;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.GenericPortlet;
import javax.portlet.PortletException;
import javax.portlet.PortletMode;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.PortletSession;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.WindowState;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sfgov.liferayusrcases.services.LiferayUsrCasesServiceStub;
import org.sfgov.liferayusrcases.services.LinkInteractionToCaseDocument;
import org.sfgov.liferayusrcases.services.LinkInteractionToCaseResponseDocument;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.User;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.PortletKeys;
import com.liferay.portlet.PortletURLFactoryUtil;
import com.sf311.portal.beans.ServiceRequestBean;
import com.sf311.portal.beans.ViewBean;
import com.sf311.portal.util.LocationSearchUtil;
import com.sf311.portal.util.SF311Constants;

public class SearchResultPortlet extends GenericPortlet 
{
	protected String viewJSP;
	protected String editJSP;
	protected String searchResJSP;
	protected String createSrvReqJSP;

	private static Log Logger = LogFactory.getLog(SearchResultPortlet.class);
	
	public void init() throws PortletException 
	{ 
		viewJSP = getInitParameter("view-jsp");
		editJSP = getInitParameter("edit-jsp");
		searchResJSP = getInitParameter("search-result-jsp");
		createSrvReqJSP = getInitParameter("create-srv-req-jsp");
	}
	
	private boolean portletNotConfigured(PortletRequest request)
	{
		boolean validated = false;
		String mapKey = getPrefAttribute(request,SF311Constants.GOOGLE_MAP_KEY);
		String wsUrl = getPrefAttribute(request,SF311Constants.WEB_SERVICE_URL);
		String socrataUrl = getPrefAttribute(request,SF311Constants.SOCRATA_URL);
		String socrataUserId = LocationSearchUtil.getUserId();
		String socrataPwd = LocationSearchUtil.getPassword();
		String webContentId = getPrefAttribute(request,SF311Constants.WEB_CONTENT_ID);
		
		if(StringUtils.isEmpty(mapKey)
				|| StringUtils.isEmpty(wsUrl)
				|| StringUtils.isEmpty(socrataUrl)
				|| StringUtils.isEmpty(socrataUserId)
				|| StringUtils.isEmpty(socrataPwd)
				|| StringUtils.isEmpty(webContentId))
		{
			validated=true;
		}
		
		return validated;
	}
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException 
	{ 
		
		String mapKey = getPrefAttribute(renderRequest,SF311Constants.GOOGLE_MAP_KEY); 
		String wsUrl = getPrefAttribute(renderRequest,SF311Constants.WEB_SERVICE_URL);
		String socrataUrl = getPrefAttribute(renderRequest,SF311Constants.SOCRATA_URL);
		//String socrataUserId = getPrefAttribute(renderRequest,SF311Constants.SOCRATA_USER_ID);
		//String socrataPwd = getPrefAttribute(renderRequest,SF311Constants.SOCRATA_PWD);
		String socrataUserId = LocationSearchUtil.getUserId();
		String socrataPwd = LocationSearchUtil.getPassword();
		String webContentId = getPrefAttribute(renderRequest,SF311Constants.WEB_CONTENT_ID);

		if (portletNotConfigured(renderRequest)) 
		{
			renderRequest.setAttribute("StatusMsg", "Please configure Portlet Before Use.");
			HashMap<String,ViewBean> prbTypes = LocationSearchUtil.getViewMap();
			renderRequest.setAttribute("prbTypes", prbTypes);
			renderRequest.setAttribute("mapKey", mapKey); 
			renderRequest.setAttribute("wsUrl", wsUrl); 
			renderRequest.setAttribute("socrataUrl", socrataUrl); 
			renderRequest.setAttribute("socrataUserId", socrataUserId); 
			renderRequest.setAttribute("socrataPwd", socrataPwd); 
			renderRequest.setAttribute("webContentId", webContentId); 
			
			include(editJSP, renderRequest, renderResponse);
		} 
		else
		{
			renderRequest.setAttribute("mapKey", mapKey); 
			renderRequest.setAttribute("wsUrl", wsUrl); 
			renderRequest.setAttribute("socrataUrl", socrataUrl); 
			renderRequest.setAttribute("socrataUserId", socrataUserId); 
			renderRequest.setAttribute("socrataPwd", socrataPwd); 
			renderRequest.setAttribute("webContentId", webContentId); 
			
			HttpServletRequest originalReq = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
			String prbType = ParamUtil.get(originalReq, "prbType", null);
			String command = ParamUtil.get(originalReq, "command", null);

			if("EXTERNAL".equalsIgnoreCase(command))
			{
				//request is coming from external source.... display map landing page with search address as NULL
				
				if(StringUtils.isEmpty(prbType) || !LocationSearchUtil.isValidPrbType(prbType))
				{
					Logger.error("Problem Type from Incoming Request = "+prbType);
					Logger.error("No problem type/Invalid problem type specified in incoming request. Redirect to home page where user can select problem type.");
					
					HashMap<String,ViewBean> prbTypes = LocationSearchUtil.getViewMap();
					renderRequest.setAttribute("prbTypes", prbTypes);
					include(viewJSP, renderRequest, renderResponse);
				}
				else
				{
					renderRequest.setAttribute("prbType", prbType);
					renderRequest.setAttribute("isExternalFlag", "true");
					include(searchResJSP, renderRequest, renderResponse);
				}				

			}
			else if("SEARCH_RESULT".equalsIgnoreCase((String)renderRequest.getAttribute("command")))
			{
				include(searchResJSP, renderRequest, renderResponse);
			}
			else if("CREATE_SRV_REQ".equalsIgnoreCase((String)renderRequest.getAttribute("command")))
			{
				include(createSrvReqJSP, renderRequest, renderResponse);				
			}
			else 
			{
				HashMap<String,ViewBean> prbTypes = LocationSearchUtil.getViewMap();
				renderRequest.setAttribute("prbTypes", prbTypes);
				include(viewJSP, renderRequest, renderResponse);
			}
		}
	}
	
	public void processAction(ActionRequest actionRequest,	ActionResponse actionResponse) throws IOException, PortletException 
	{
		String action = actionRequest.getParameter("action");
		PortletPreferences preferences= actionRequest.getPreferences();
		String lat = actionRequest.getParameter("txtLattitude");
		String lng = actionRequest.getParameter("txtLongitude");
		String prbType = actionRequest.getParameter("selProbType");

		if("configureGoogleMap".equalsIgnoreCase(action))
		{
			String mapKey = actionRequest.getParameter("mapKey");
			String wsUrl = actionRequest.getParameter("wsUrl");
			String socrataUrl = actionRequest.getParameter("socrataUrl");
			String socrataUserId = actionRequest.getParameter("socrataUserId");
			String socrataPwd = actionRequest.getParameter("socrataPwd");
			String webContentId = actionRequest.getParameter("webContentId");
			

			preferences.setValue(SF311Constants.GOOGLE_MAP_KEY, mapKey);
			preferences.setValue(SF311Constants.WEB_SERVICE_URL,wsUrl);
			preferences.setValue(SF311Constants.SOCRATA_URL,socrataUrl);
			preferences.setValue(SF311Constants.WEB_CONTENT_ID,webContentId);

			//preferences.setValue(SF311Constants.SOCRATA_USER_ID,socrataUserId);
			//preferences.setValue(SF311Constants.SOCRATA_PWD,socrataPwd);
			preferences.store();
			
			LocationSearchUtil.setUrl(socrataUrl);
			LocationSearchUtil.setUserId(socrataUserId);
			LocationSearchUtil.setPassword(socrataPwd);
			
			actionRequest.setAttribute("StatusMsg", "Request Processed Successfully");
			actionRequest.setAttribute("selectedTab", "GoogleMap");
			return;	
		}
		else if("configureSocrataView".equalsIgnoreCase(action))
		{
			String pType = actionRequest.getParameter("selProbType");
			String vId = actionRequest.getParameter("viewId");
			String vName = actionRequest.getParameter("viewName");
			String vDesc = actionRequest.getParameter("viewDesc");
			String vColId = actionRequest.getParameter("viewColId");

			LocationSearchUtil.getViewMap().get(pType).setViewId(vId);
			LocationSearchUtil.getViewMap().get(pType).setViewName(vName);
			LocationSearchUtil.getViewMap().get(pType).setViewDesc(vDesc);
			LocationSearchUtil.getViewMap().get(pType).setColumnId(vColId);
			
			actionRequest.setAttribute("StatusMsg", "Request Processed Successfully");
			actionRequest.setAttribute("selectedTab", "SocrataView");
			actionRequest.setAttribute("selectedPrbType", pType);
			actionRequest.setAttribute("selectedViewId", vId);
			actionRequest.setAttribute("selectedViewName", vName);
			actionRequest.setAttribute("selectedViewDesc", vDesc);
			actionRequest.setAttribute("selectedViewColId", vColId);
 
			

			return;	
		}	
		else if("SearchReqByAddress".equalsIgnoreCase(action) || "EXTERNAL_REQUEST".equalsIgnoreCase(action))
		{
			List<ServiceRequestBean> srvReqs = new LinkedList<ServiceRequestBean>();
			
			if(!("EXTERNAL_REQUEST".equalsIgnoreCase(action)))
			{
				try {
					if(StringUtils.isNotEmpty(lat) && StringUtils.isNotEmpty(lng) 
							&& !("null".equalsIgnoreCase(lat)) && !("null".equalsIgnoreCase(lng)))
					{
						String jsonResp = LocationSearchUtil.getSrvReqInfo(lat, lng, prbType);
						srvReqs = LocationSearchUtil.getServiceReqDataByPrbType(jsonResp, prbType);
					}
				} catch (Exception e) 
				{
					Logger.error("Exception occured in SearchResultPortlet.processAction()",e);
					//throw new PortletException("Error occured while processing your request. Please contact administrator.");
				}
			}
			
			if("EXTERNAL_REQUEST".equalsIgnoreCase(action))
				actionRequest.setAttribute("extProcFlag", "true");
			
			actionRequest.setAttribute("command", "SEARCH_RESULT");
			actionRequest.setAttribute("serviceRequests",srvReqs);
			actionRequest.setAttribute("selectedProbType", prbType);
			actionRequest.setAttribute("selectedProbTypeDesc", LocationSearchUtil.getPrbTypeDesc(prbType));
			actionRequest.setAttribute("selectedAddress", actionRequest.getParameter("txtAddress"));
			actionRequest.setAttribute("selectedLat", lat);
			actionRequest.setAttribute("selectedLng", lng);
			actionRequest.setAttribute("descPanelBottomPg", LocationSearchUtil.getBottomPanelPgName(prbType));
			actionRequest.setAttribute("descPanelRightPg", LocationSearchUtil.getRightPanelPgName(prbType));
			
			
			//check if user is already logged in and set the flag accordingly
			ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
			User user = null;

			if(themeDisplay.isSignedIn())
			{
				try 
				{
					user = UserLocalServiceUtil.getUser(themeDisplay.getUserId());
					actionRequest.setAttribute("userFirstName",user.getFirstName());
					actionRequest.setAttribute("userLastName",user.getLastName());
					actionRequest.setAttribute("userFullName",user.getFullName());
					actionRequest.setAttribute("useEmail",user.getEmailAddress());
					actionRequest.setAttribute("popupFlag", "true");

				} catch (PortalException e) 
				{
					Logger.error("Exception occured in SearchResultPortlet.processAction()",e);
					throw new PortletException("Error occured while processing your request. Please contact administrator.");
				} catch (SystemException e) 
				{
					Logger.error("Exception occured in SearchResultPortlet.processAction()",e);
					throw new PortletException("Error occured while processing your request. Please contact administrator.");
				}
			}
			else
			{
				actionRequest.setAttribute("popupFlag", "false");
			}

			
			actionResponse.setWindowState(WindowState.MAXIMIZED);
			actionResponse.setPortletMode(PortletMode.VIEW);		
		}
		else if("refineProblemType".equalsIgnoreCase(action))
		{
			actionRequest.setAttribute("command", "CREATE_SRV_REQ");
			actionRequest.setAttribute("selectedProbType", prbType);
			actionRequest.getPortletSession().setAttribute("refinementUrl", actionRequest.getParameter("refinementUrl"),PortletSession.APPLICATION_SCOPE);
			actionRequest.setAttribute("selectedProbTypeDesc", LocationSearchUtil.getPrbTypeDesc(prbType));
			actionRequest.setAttribute("selectedAddress", actionRequest.getParameter("selAddress"));
			actionRequest.setAttribute("selectedLat", lat);
			actionRequest.setAttribute("selectedLng", lng);
			actionRequest.setAttribute("popupFlag", "false");			
			actionRequest.setAttribute("currentZoom", actionRequest.getParameter("currentZoom"));
			
			String refinementUrl = actionRequest.getParameter("refinementUrl");
			
			if(refinementUrl != null && refinementUrl.indexOf("?") != -1)
			{
				refinementUrl+="&centerLat="+lat+"&centerLng="+lng+"&currentZoom="+actionRequest.getParameter("currentZoom")+"&searchAddress="+actionRequest.getParameter("selAddress");
			}
			else
			{
				refinementUrl+="?centerLat="+lat+"&centerLng="+lng+"&currentZoom="+actionRequest.getParameter("currentZoom")+"&searchAddress="+actionRequest.getParameter("selAddress");
			}

			
			URL url = new URL(actionRequest.getParameter("actUrl").toString());
			
			actionRequest.setAttribute("redActUrl", url.getPath()+"?"+url.getQuery()
					+"&finalUrl="+java.net.URLEncoder.encode(refinementUrl,"utf-8"));

			ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
			
			HttpServletRequest httpRequest = PortalUtil.getHttpServletRequest(actionRequest);

			PortletURL liferayPortletURL = PortletURLFactoryUtil.create(httpRequest, PortletKeys.LOGIN, themeDisplay.getPlid(), PortletRequest.RENDER_PHASE);

			liferayPortletURL.setWindowState(WindowState.MAXIMIZED);
			liferayPortletURL.setPortletMode(PortletMode.VIEW);
			liferayPortletURL.setParameter("saveLastPath", "0");
			liferayPortletURL.setParameter("struts_action", "/login/create_account");
			
			actionRequest.setAttribute("createAcctUrl", liferayPortletURL.toString());
			actionResponse.setWindowState(WindowState.MAXIMIZED);
			actionResponse.setPortletMode(PortletMode.VIEW);		
		}
		else if("forwardToDestination".equalsIgnoreCase(action))
		{
			String refinementUrl = actionRequest.getParameter("finalUrl");
			
			ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
			User user = null;

			if(themeDisplay.isSignedIn())
			{
				try 
				{
					user = UserLocalServiceUtil.getUser(themeDisplay.getUserId());
				} catch (PortalException e) 
				{
					Logger.error("Exception occured in SearchResultPortlet.processAction()",e);
					throw new PortletException("Error occured while processing your request. Please contact administrator.");
				} catch (SystemException e) 
				{
					Logger.error("Exception occured in SearchResultPortlet.processAction()",e);
					throw new PortletException("Error occured while processing your request. Please contact administrator.");
				}
				
				if(refinementUrl != null && refinementUrl.indexOf("?") != -1)
				{
					refinementUrl+="&userEmail="+java.net.URLEncoder.encode(user.getEmailAddress(),"utf-8")
						+"&userFirstName="+java.net.URLEncoder.encode(user.getFirstName(),"utf-8")
						+"&userLastName="+java.net.URLEncoder.encode(user.getLastName(),"utf-8");
				}
				else
				{
					refinementUrl+="?userEmail="+java.net.URLEncoder.encode(user.getEmailAddress(),"utf-8")
					+"&userFirstName="+java.net.URLEncoder.encode(user.getFirstName(),"utf-8")
					+"&userLastName="+java.net.URLEncoder.encode(user.getLastName(),"utf-8");
				}

			}
			else
			{
				if(refinementUrl != null && refinementUrl.indexOf("?") != -1)
				{
					refinementUrl+="&userEmail=ANONYMOUS&userFirstName=ANONYMOUS&userLastName=ANONYMOUS";
				}
				else
				{
					refinementUrl+="?userEmail=ANONYMOUS&userFirstName=ANONYMOUS&userLastName=ANONYMOUS";
				}
			}

			Logger.debug("########"+refinementUrl);
			actionRequest.setAttribute("popupFlag", "true");
			actionRequest.setAttribute("command", "CREATE_SRV_REQ");
			actionRequest.setAttribute("finalUrlToPopup",refinementUrl);
			actionResponse.setWindowState(WindowState.MAXIMIZED);
			actionResponse.setPortletMode(PortletMode.VIEW);		

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

		String mapKey = getPrefAttribute(renderRequest,SF311Constants.GOOGLE_MAP_KEY); 
		renderRequest.setAttribute("mapKey", mapKey);

		String wsUrl = getPrefAttribute(renderRequest,SF311Constants.WEB_SERVICE_URL); 
		renderRequest.setAttribute("wsUrl", wsUrl);

		String socrataUrl = getPrefAttribute(renderRequest,SF311Constants.SOCRATA_URL); 

		renderRequest.setAttribute("socrataUrl", socrataUrl);

		renderRequest.setAttribute("socrataUserId", LocationSearchUtil.getUserId());
		renderRequest.setAttribute("socrataPwd", LocationSearchUtil.getPassword());

		String webContentId = getPrefAttribute(renderRequest,SF311Constants.WEB_CONTENT_ID); 
		renderRequest.setAttribute("webContentId", webContentId); 
		
		HashMap<String,ViewBean> prbTypes = LocationSearchUtil.getViewMap();
		renderRequest.setAttribute("prbTypes", prbTypes);

		include(editJSP, renderRequest, renderResponse);
	} 

	private String getPrefAttribute(PortletRequest portletRequest,String attrName)
	{
		PortletPreferences prefs = portletRequest.getPreferences();
		String mapKey = (String)prefs.getValue(attrName, ""); 
		return mapKey;
	}


	public void serveResource(ResourceRequest request, ResourceResponse response) throws PortletException,IOException
	{
		String action = request.getParameter("action");
		
		if("updateSrvReqCount".equalsIgnoreCase(action))
		{
			String caseId = request.getParameter("caseId");
			String wsUrl = getPrefAttribute(request,SF311Constants.WEB_SERVICE_URL);
			String result="";

			try 
			{
		        LiferayUsrCasesServiceStub stub = new LiferayUsrCasesServiceStub(wsUrl);
				
		        LinkInteractionToCaseDocument caseDoc = LinkInteractionToCaseDocument.Factory.newInstance();
		        caseDoc.addNewLinkInteractionToCase().setCaseId(caseId);
		        LinkInteractionToCaseResponseDocument caseResp = null;
		        caseResp = stub.linkInteractionToCase(caseDoc);
		       
		        if(StringUtils.isEmpty(caseResp.getLinkInteractionToCaseResponse().getLinkInteractionToCaseResponse().getErrorDescription()))
		        {
		        	result="Request processed successfully.";
		        }
		        else
		        {
		        	Logger.debug(caseResp.getLinkInteractionToCaseResponse().getLinkInteractionToCaseResponse().getErrorDescription());
		        	result="Error occured while updating the request count. Please contact administrator.";
		        }

			}
			catch(Exception e)
			{
				Logger.error("Exception occured in SearchResultPortlet.serveResource()",e);
	        	result="Error occured while updating the request count. Please contact administrator.";
			}
			
			
	        response.setContentType("text");
	        response.resetBuffer();
	        response.getWriter().print(result);
	        response.flushBuffer();
			
		}
		else if("getProblemDetails".equalsIgnoreCase(action))
		{
			String prbType = request.getParameter("prbType");
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("viewId", LocationSearchUtil.getViewMap().get(prbType).getViewId());
			jsonObj.put("viewName", LocationSearchUtil.getViewMap().get(prbType).getViewName());
			jsonObj.put("viewDesc", LocationSearchUtil.getViewMap().get(prbType).getViewDesc());
			jsonObj.put("viewColId", LocationSearchUtil.getViewMap().get(prbType).getColumnId());
					
	        response.setContentType("json");
	        response.resetBuffer();
	        response.getWriter().print(jsonObj.toString());
	        response.flushBuffer();

		}
		
	}
}
