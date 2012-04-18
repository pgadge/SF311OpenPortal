package com.sf311.portal.beans;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sf311.portal.util.LocationSearchUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ViewBean 
{
	private String viewId = null;
	private String viewName = null;
	private String viewDesc = null;
	private String columnId = null;
	private String rightPanelPg = null;
	private String bottomPanelPg = null;
	//private String viewFullDescription = null;
	private static Log Logger = LogFactory.getLog(ViewBean.class);

	
	public ViewBean(String viewId, String viewName, String viewDesc, String columnId,String rightPanelPg, String bottomPanelPg)
	{
		this.viewId = viewId;
		this.viewName = viewName;
		this.viewDesc = viewDesc;
		//this.viewFullDescription = viewFullDescription;
		this.columnId = columnId;
		this.rightPanelPg = rightPanelPg;
		this.bottomPanelPg = bottomPanelPg;
		
	}

	public String getViewId() {
		return viewId;
	}

	public void setViewId(String viewId) {
		this.viewId = viewId;
	}

	public String getViewName() {
		return viewName;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	public String getViewDesc() {
		return viewDesc;
	}

	public void setViewDesc(String viewDesc) {
		this.viewDesc = viewDesc;
	}
/*
	public String getViewFullDescription() {
		return viewFullDescription;
	}

	public void setViewFullDescription(String viewFullDescription) {
		this.viewFullDescription = viewFullDescription;
	}*/
	
	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	
	/*public synchronized List<ServiceRequestBean> parse(String json) throws Exception
	{
		List<ServiceRequestBean> srvReqs = new ArrayList<ServiceRequestBean>();

		JSONObject jsonObj = null;
		JSONArray dataArray = null;
		JSONArray data = null;
		try {
			jsonObj = JSONObject.fromObject(json);
			dataArray = jsonObj.getJSONArray("data");
			
			for(int i=0;i<dataArray.size();i++)
			{
				data = dataArray.getJSONArray(i);
				ServiceRequestBean srbean = new ServiceRequestBean();
				srbean.setCaseId(data.getString(8));
				srbean.setOpenDate(data.getString(9));
				srbean.setReqType(data.getString(11));
				srbean.setLocation(data.getString(13));
				srbean.setInterest(data.getString(15));
				
				JSONArray latlang = data.getJSONArray(16);
				
				srbean.setLattitude(latlang.getString(1));
				srbean.setLongitude(latlang.getString(2));
				
				srvReqs.add(srbean);
			}
			
		} catch (Exception e) 
		{
			e.printStackTrace();
			throw e;
		}
		return srvReqs;
	}*/

	
	public String getRightPanelPg() {
		return rightPanelPg;
	}

	public void setRightPanelPg(String rightPanelPg) {
		this.rightPanelPg = rightPanelPg;
	}

	public String getBottomPanelPg() {
		return bottomPanelPg;
	}

	public void setBottomPanelPg(String bottomPanelPg) {
		this.bottomPanelPg = bottomPanelPg;
	}

	public synchronized List<ServiceRequestBean> parse(String json) throws Exception
	{
		List<ServiceRequestBean> srvReqs = new LinkedList<ServiceRequestBean>();

		JSONObject jsonObj = null;
		JSONArray dataArray = null;
		JSONArray colArray = null;
		int caseIdIndex = -1;
		int openedIndex = -1;
		int reqTypeIndex = -1;
		int locIndex = -1;
		int interestIndex = -1;
		int latLngIndex = -1;
		JSONArray data = null;
		try {
			jsonObj = JSONObject.fromObject(json);
			colArray = jsonObj.getJSONObject("meta").getJSONObject("view").getJSONArray("columns");
			dataArray = jsonObj.getJSONArray("data");
			
			
			for(int i=0;i<colArray.size();i++)
			{
				if("case_id".equalsIgnoreCase(colArray.getJSONObject(i).getString("fieldName")))
				{
					caseIdIndex=i;
				}
				if("opened".equalsIgnoreCase(colArray.getJSONObject(i).getString("fieldName")))
				{
					openedIndex=i;
				}
				if("request_details".equalsIgnoreCase(colArray.getJSONObject(i).getString("fieldName")))
				{
					reqTypeIndex=i;
				}
				if("address".equalsIgnoreCase(colArray.getJSONObject(i).getString("fieldName")))
				{
					locIndex=i;
				}
				if("interest".equalsIgnoreCase(colArray.getJSONObject(i).getString("fieldName")))
				{
					interestIndex=i;
				}
				if("point".equalsIgnoreCase(colArray.getJSONObject(i).getString("fieldName")))
				{
					latLngIndex=i;
				}

			}
			
			if(caseIdIndex == -1 || 
					openedIndex == -1 ||
					reqTypeIndex == -1 || 
					locIndex == -1 || 
					interestIndex == -1 ||
					latLngIndex == -1)
			{
				Logger.error("com.sf311.portal.beans.ViewBean : Couldn't parse JSON response : "+json);
				throw new Exception("com.sf311.portal.beans.ViewBean : Couldn't parse JSON response");
			}

			
			for(int i=0;i<dataArray.size();i++)
			{
				data = dataArray.getJSONArray(i);
				ServiceRequestBean srbean = new ServiceRequestBean();
				srbean.setCaseId(data.getString(caseIdIndex));
				srbean.setOpenDate(data.getString(openedIndex));
				srbean.setReqType(data.getString(reqTypeIndex));
				srbean.setLocation(data.getString(locIndex));
				srbean.setInterest(data.getString(interestIndex));
				
				JSONArray latlang = data.getJSONArray(latLngIndex);
				
				srbean.setLattitude(latlang.getString(1));
				srbean.setLongitude(latlang.getString(2));
				
				srvReqs.add(srbean);
			}
			
		} catch (Exception e) 
		{
			e.printStackTrace();
			throw e;
		}
		return srvReqs;
	}

}
