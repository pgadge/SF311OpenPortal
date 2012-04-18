package com.sf311.portal.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sf311.portal.beans.ServiceRequestBean;
import com.sf311.portal.beans.ViewBean;

public class LocationSearchUtil 
{
	private static HashMap<String,ViewBean> viewMap = null;
	private static URL url;
	private static Log Logger = LogFactory.getLog(LocationSearchUtil.class);
	private static String userId = null;
	private static String password = null;
	private static String encPassword = null;

	//app_token=ymTW3b4fkG1w3TTFjil8wv6oq

	public static HashMap<String, ViewBean> getViewMap() {
		return viewMap;
	}

	static
	{
				
		viewMap = new HashMap<String,ViewBean>();
		viewMap.put("This is the full description for abandoned vehicles!!!!", new ViewBean("a7gn-frv9","90-Days-Abandoned-Vehicles","An Abandoned Vehicle", "point","AbandonedVehicleDescPanelRight.jsp","AbandonedVehicleDescPanelBottom.jsp"));
		viewMap.put("This is the full description for building related issues!!!!", new ViewBean("zz9n-57hb","90-Days-Building-Requests","Building Related Issue", "point","","GraffitiDescPanelBottom.jsp"));
		viewMap.put("This is the full description for Issuess in a park!!!!!", new ViewBean("cmwf-tt8s","90-Day-City-Parks","Issue in a Park", "point","CityParks_Right.jsp","CityParks_Bottom.jsp"));
		viewMap.put("This is the full description for flooding or sewer issue", new ViewBean("cu5d-ea7g","Flooding-or-Sewer","Flooding or Sewer Issue",  "point","GraffitiDescPanelRight.jsp","GraffitiDescPanelBottom.jsp"));
		viewMap.put("This is the full description for issues with city garbage cans", new ViewBean("v8p7-9d2w","90-Day-Cases-City-Garbage-Can-Issues","Issues with City Garbage Cans",  "point","Garbage_Right.jsp","Garbage_Bottom.jsp"));
		//viewMap.put("Graffiti", new ViewBean("p65k-px8g","90-Days-of-Graffiti","Graffiti","2853515","GraffitiDescPanelRight.jsp","GraffitiDescPanelBottom.jsp"));
		viewMap.put("This is the full description for graffiti", new ViewBean("hn7d-hj5y","90-Days-of-Graffiti","Graffiti",  "point","GraffitiDescPanelRight.jsp","GraffitiDescPanelBottom.jsp"));
		viewMap.put("This is the full description for public siddewalk issue", new ViewBean("mxqc-nfie","90-Days-Street-and-Sidewalk","Public Sidewalk Issue", "point","SidewalkIssues_Right.jsp","SidewalkIssues_Bottom.jsp"));
		viewMap.put("This is the full description for city sign issue!!!!!", new ViewBean("t65w-rmxz","90-Days-City-Sign-Issues","City Sign Issue",  "point","GraffitiDescPanelRight.jsp","GraffitiDescPanelBottom.jsp"));
		viewMap.put("This is the full description for street issues!!!!", new ViewBean("5pve-mb84","90-Days-Street-and-Sidewalk ","Street Issues",  "point","StreetDefect_Right.jsp","StreetDefects_Bottom.jsp"));
		viewMap.put("This is the full description for streetlight issues!!!", new ViewBean("hck2-d3dr","Streetlights","Streetlight Issues",  "point","GraffitiDescPanelRight.jsp","GraffitiDescPanelBottom.jsp"));
		viewMap.put("This is the full description for city tree maintainenece!!!!!", new ViewBean("8fyr-98ga","90-Days-Tree-Maintenance","City Tree Maintenance",  "point","CityTrees_Right.jsp","CityTrees_Bottom.jsp"));
		viewMap.put("Send a compliment or file a Complaint concerning Muni services.", new ViewBean("2wer-27ui","Provide Feedback to SFMTA","Provide Feedback to SFMTA",  "point","GraffitiDescPanelRight.jsp","GraffitiDescPanelBottom.jsp"));
		
		
	}
	
	public static String getPrbTypeDesc(String prbType)
	{
		return viewMap.get(prbType).getViewDesc();
	}
	
	/*public static String getPrbTypeFullDescription(String prbType)
	{
		return viewMap.get(prbType).getViewFullDescription();
	}*/

	public static String getRightPanelPgName(String prbType)
	{
		return viewMap.get(prbType).getRightPanelPg();
	}

	public static String getBottomPanelPgName(String prbType)
	{
		return viewMap.get(prbType).getBottomPanelPg();
	}

	public static String getSrvReqInfo(String lat, String lng, String prbType) throws Exception
	{
		StringBuffer resp = null;
		HttpsURLConnection connection = null;
		DataOutputStream wr = null;
		BufferedReader rd  = null;
		ViewBean view = null;
		try 
		{
			view = viewMap.get(prbType);
			
			if (url == null)
			{
				Logger.error("com.sf311.portal.util.LocationSearchUtil : Socrata View JSON Service URL is not defined.");
				throw new Exception("com.sf311.portal.util.LocationSearchUtil : Socrata View JSON Service URL is not defined.");
			}
			connection = (HttpsURLConnection) url.openConnection();
			connection.setDoInput(true);
			connection.setDoOutput(true);
			
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestProperty("X-App-Token", "ymTW3b4fkG1w3TTFjil8wv6oq");
			connection.setRequestProperty( "Authorization", "Basic " + getEncPassword());
			
			//Send request
		      wr = new DataOutputStream (connection.getOutputStream());
		      
		      StringBuilder query = new StringBuilder();
		      
		      query.append("{");
		      query.append("\"originalViewId\": \""+view.getViewId()+"\",");
		      query.append("\"name\": \""+view.getViewName()+"\",");
		      query.append("\"query\": {");
		      query.append("\"filterCondition\": {");
		      query.append("\"type\": \"operator\",");
		      query.append("\"value\": \"AND\",");
		      query.append("\"children\": [");
		      query.append("{");
		      query.append("\"children\": [");
		      query.append("{");
		      query.append("\"type\": \"operator\",");
		      query.append("\"value\": \"within_circle\",");
		      query.append("\"metadata\": {");
		      query.append("\"freeform\": true");
		      query.append("},");
		      query.append("\"children\": [");
		      query.append("{");
		      query.append("\"type\": \"column\",");
		      query.append("\"columnFieldName\": \""+view.getColumnId()+"\"");
		      query.append("},");
		      query.append("{");
		      query.append("\"type\": \"literal\",");
		      query.append("\"value\": "+lat);
		      query.append("},");
		      query.append("{");
		      query.append("\"type\": \"literal\",");
		      query.append("\"value\": "+lng);
		      query.append("},");
		      query.append("{");
		      query.append("\"type\": \"literal\",");
		      query.append("\"value\": 1000");
		      query.append("}");
		      query.append("]");
		      query.append("}");
		      query.append("],");
		      query.append("\"type\": \"operator\",");
		      query.append("\"value\": \"OR\"");
		      query.append("}");
		      query.append("]");
		      query.append("}");
		      query.append("}");
		      query.append("}");
		      
		      wr.writeBytes (query.toString());
		      wr.flush ();
		      wr.close ();

		      //Get Response	
		      InputStream is = connection.getInputStream();
		      rd = new BufferedReader(new InputStreamReader(is));
		      String line;
		      resp = new StringBuffer(); 
		      while((line = rd.readLine()) != null) 
		      {
		        resp.append(line);
		        resp.append('\r');
		      }
		      rd.close();	
		 } catch (Exception e) 
		 {
			Logger.error(" Error occured while retreive service request data for problem type = "+prbType+" , lattitude = "+lat+" , longitude = "+lng+" , viewId = "+view.getViewId()+" , viewName = "+view.getViewName()+" , columnId = "+view.getColumnId(),e);
			e.printStackTrace();
			System.out.println(" Error occured while retreive service request data for problem type = "+prbType+" , lattitude = "+lat+" , longitude = "+lng+" , viewId = "+view.getViewId()+" , viewName = "+view.getViewName()+" , columnId = "+view.getColumnId());
			throw new Exception("Error occured while retreive service request data for problem type = "+prbType+" , lattitude = "+lat+" , longitude = "+lng+" , viewId = "+view.getViewId()+" , viewName = "+view.getViewName()+" , columnId = "+view.getColumnId());
		}
		 finally
		 {
			 if(rd != null)
				 rd.close();
			 
			 if(wr != null)
				 wr.close();
			 
			 if(connection != null)
				 connection.disconnect();
			 
		 }
		 
		 return resp.toString();

	}

	public static List<ServiceRequestBean> getServiceReqDataByPrbType(String json, String prbType) throws Exception
	{
		List<ServiceRequestBean> srvReqs = null;

		ViewBean view = viewMap.get(prbType);
		srvReqs = view.parse(json);
		return srvReqs;
	}
	
	public static boolean isValidPrbType(String prbType)
	{
		if(viewMap.containsKey(prbType))
			return true;
		else
			return false;
	}


	public static void setUrl(String urlName) 
	{
		try 
		{
			LocationSearchUtil.url = new URL(urlName);
		} catch (MalformedURLException e) 
		{
			Logger.error("com.sf311.portal.util.LocationSearchUtil : "+ e.getMessage(),e);
			throw new RuntimeException("com.sf311.portal.util.LocationSearchUtil : "+ e.getMessage());
		}
	}

	public static String getUserId() {
		return userId;
	}

	public static void setUserId(String userId) {
		LocationSearchUtil.userId = userId;
	}

	public static String getPassword() {
		return password;
	}

	public static void setPassword(String password) {
		LocationSearchUtil.password = password;
	}

	public static String getEncPassword() {
		if(LocationSearchUtil.encPassword == null)
		{
			byte[] encodedPassword = (getUserId() + ":" + getPassword()).getBytes();
			sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
			setEncPassword(encoder.encode(encodedPassword));
		}
		
		return encPassword;
	}

	public static void setEncPassword(String encPassword) {
		LocationSearchUtil.encPassword = encPassword;
	}
	
}
