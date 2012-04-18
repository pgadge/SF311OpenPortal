   var geocoder;
   var map;
   var html;
   var displayArray;
   var countDisplayElement=0;
   var tempCountDisplayElement;
   var zipArray;
   var geocoderForZip;
   var latForZip;
   var longForZip;
   var latitude = 0;
   var longitude = 0;
   var radius;
   var geocoderForLatitude;
   var newaddressforzip = '';
   var newcountryforzip = '';
   
   var swSFOLatLng = new GLatLng(37.635441,-122.494812);
   var neSFOLatLng = new GLatLng(37.875937,-122.304611);
   
   var sfoLattitude = 37.775;
   var sfoLongitude = -122.4183333;
   
   var mapCenterLat;
   var mapCenterLng;
   
   var sfzipcodes = new Array(94101,94102,94103,94104,94105,94107,94108,94109,94110,94111,94112,94114,94115,94116,94117,94118,94121,94122,94123,94124,94127,94129,94130,94131,94132,94133,94134,94158, 94159, 94160, 941601, 94162, 94163, 94164, 94165, 94166, 94167, 94168, 94169, 94170, 94171, 94172, 94175, 94177, 94188, 94199);
   geocoder = new GClientGeocoder();
   
   
// determines if an address is a SF address based on the zipcode. 

   function sf_only(zip){ 
       for(var i=0;i<sfzipcodes.length;i++){ 
           if(sfzipcodes[i] == zip) 
               return true; 
       } 
       return false; 
   } 
   
   function getCurCenterLat()
   {
	   return mapCenterLat;
   }   
   
   function getCurCenterLng()
   {
	   return mapCenterLng;	   
   }
   
   function getCurZoom()
   {
	   return map.getZoom();
   }
      
   function getLatFromZip(zipCode){
	   geocoderForZip = new GClientGeocoder();
	   geocoderForZip.getLocations(zipCode, addToMapForZip);
   }
   
   function addToMapForZip(response){
	   place = response.Placemark[0];
       latForZip = place.Point.coordinates[1];
       longForZip = place.Point.coordinates[0];
   }
   /*Calculate Latitude and Longitude for a Zip Code and submit*/
   
   function submitZipCode(){
	   var tempZipCode = document.xmlForm.zipCode.value;
       getLatitude(tempZipCode);
   }
   
   function getLatitude(zipCode){
	   geocoderForLatitude = new GClientGeocoder();
	   geocoderForLatitude.getLocations(zipCode, addToMapForLatitude);
   }
   
   function addToMapForLatitude(response){
	   place = response.Placemark[0];
	   latitude = place.Point.coordinates[1];
	   longitude = place.Point.coordinates[0];
	   newcountryforzip = place.AddressDetails.Country.CountryNameCode;
	   newaddressforzip = place.address;
	   if(longitude != 0)
    	   submitLatitude();
   }
   
   function submitLatitude(){
		document.xmlForm.latitudeHiddenField.value = latitude;
		document.xmlForm.longitudeHiddenField.value = longitude;
		document.xmlForm.newaddressforzip.value = newaddressforzip;
		document.xmlForm.newcountryforzip.value = newcountryforzip;
	    document.xmlForm.submitZipCodeHiddenField.value = '1';
	    document.xmlForm.submit();
   }
   
   /*Ends*/
   function loadMap(latitudesList,longitudesList,addressList,canvasName)
	{
	   if (GBrowserIsCompatible()) {

	   	  map = new GMap2(document.getElementById(canvasName));
	      map.addControl(new GLargeMapControl());
	      map.addControl(new GMapTypeControl());
	      var i = 0;
		  for(i=0;i<latitudesList.length;i++)
		  {
			  
			  if(latitudesList[i] != null && latitudesList[i] != 'null' && latitudesList[i] != ''
				   && longitudesList[i] != null && longitudesList[i] != 'null' && longitudesList[i] != '')
			  {
				   point = new GLatLng(latitudesList[i],
						   longitudesList[i]);

				   if(i == 0){
					   map.setCenter(point, 16);
				   }
				   
				   if(addressList.length > 0)
				   {
					   var marker = createMarker(point,addressList[i]);
					   map.addOverlay(marker);
				   }
	  
			  }
		  }  
	   }
	   
	   //alert("Map Loaded successfully......");


	}
   
   function updateLatLngForRefinement(lat,lng)
   {
	   document.refinementForm.txtLattitude.value=lat;
	   document.refinementForm.txtLongitude.value=lng;
   }
   
   function <portlet:namespace />_updateLatLngForRefinement(lat,lng)
   {
   	    var refinementForm = document.getElementById("<portlet:namespace />_refinementForm");
   	    refinementForm.txtLattitude.value=lat;
   	    refinementForm.txtLongitude.value=lng;
   }

   function locateAddressOnMap(selctdLat,selctdLng,callbkFunName)
   {
	   //alert("selctdLat = "+selctdLat);
	   //alert("selctdLng = "+selctdLng);
	   
	   //alert(callbkFunName);
	   
	   if(selctdLat != null && selctdLat != 'null' && selctdLat != ''
		   && selctdLng != null && selctdLng != 'null' && selctdLng != '')
	   {
		   //alert("Address found .... setting map to Lat-Lng found ");

		   mapCenterLat = selctdLat;
		   mapCenterLng = selctdLng;
		  
		   		   
		   var center = new GLatLng(mapCenterLat, mapCenterLng);
		   map.setCenter(center, 16);

			var icn = new GIcon(G_DEFAULT_ICON);
	        icn.image = 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png';
	        icn.iconSize = new GSize(35, 35);
	        //icn.iconAnchor = new GPoint(0, 0);
	         
	        var opts = {
	                "icon": icn,
	                "draggable": true
	        };

		   var mrkr = new GMarker(center,opts);

		   GEvent.addListener(mrkr, "dragend", function() {
			  // alert("lattitude = "+this.getLatLng().lat());
			  // alert("longitude = "+this.getLatLng().lng());
			   mapCenterLat = this.getLatLng().lat();
			   mapCenterLng = this.getLatLng().lng();
			   
			   //Update the address accrding to new location
		       geocoder = new GClientGeocoder();
	       	   geocoder.getLocations(this.getLatLng(), eval(callbkFunName));

		     });

		   map.addOverlay(mrkr);
		   
	   }
	   else
	   {
		   //alert("Address not found .... setting map to SFO, CA ");

		   mapCenterLat = sfoLattitude;
		   mapCenterLng = sfoLongitude;
		   
		   var center = new GLatLng(mapCenterLat, mapCenterLng);
		   map.setCenter(center, 16);

			var icn = new GIcon(G_DEFAULT_ICON);
	        icn.image = 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png';
	        icn.iconSize = new GSize(35, 35);
	        //icn.iconAnchor = new GPoint(0, 0);

	        var opts = {
	                "icon": icn,
	                "draggable": true
	        };

		   var mrkr = new GMarker(center,opts);

		   GEvent.addListener(mrkr, "dragend", function() {
			//   alert("lattitude = "+this.getLatLng().lat());
			//   alert("longitude = "+this.getLatLng().lng());
			   mapCenterLat = this.getLatLng().lat();
			   mapCenterLng = this.getLatLng().lng();
			   
			   //Update the address accrding to new location
		       geocoder = new GClientGeocoder();
	       	   geocoder.getLocations(this.getLatLng(), eval(callbkFunName));

		     });

		  // map.addOverlay(mrkr);
		   
	   }
   }
   
   
   /*Functions Changed as per new implementation*/
   
   function loadBasedOnAddress(addressList,addressToDisplayList){
	   displayArray = addressToDisplayList;
       map = new GMap2(document.getElementById("map_canvas"));
       map.addControl(new GLargeMapControl());
	   map.addControl(new GMapTypeControl());
       geocoder = new GClientGeocoder();
       //map.enableGoogleBar();
       
       for(i=0;i<=addressList.length;i++){
       		geocoder.getLocations(addressList[i], addToMap);
		 }  
	}
	
	function addToMap(response){
		//alert("response addToMap ---> "+response);
	  try{
		  place = response.Placemark[0];
	      point = new GLatLng(place.Point.coordinates[1],
	                          place.Point.coordinates[0]);
		  map.setCenter(point, 15);
	      var marker = createMarker(point,displayArray[countDisplayElement],(countDisplayElement+1));
	      countDisplayElement = countDisplayElement+1;
	      map.addOverlay(marker);
	  }catch(e){ countDisplayElement = countDisplayElement+1; }
	}
	
	function getLatLngByAddress(addr,callBkFun)
	{
		   //alert("getLatLngByAddress - "+callBkFun);
	       geocoder = new GClientGeocoder();
	       var searchBounds = new GLatLngBounds(swSFOLatLng,neSFOLatLng);
	       geocoder.setViewport(searchBounds);
       	   geocoder.getLocations(addr, eval(callBkFun));
	}

	function setLatLngForSearch(response){
			/*alert("response ---> "+response);
			alert("response status.code---> "+response.Status.code);
			alert("placemark--->"+response.Placemark[0]);
			alert("placemark point--->"+response.Placemark[0].Point);*/
		
		  try
		  {
			  
			  	  //alert("response.Placemark.length = "+response.Placemark.length);
				  for(var i=0;i<response.Placemark.length;i++)
				  {
					  place = response.Placemark[i];
		            var mapResponse = response.Placemark[i].AddressDetails.Country.AdministrativeArea; 
		           
		          //  alert("map response is "+ (mapResponse).toString);  
		              
		            
		              if(mapResponse != null)
		              { 
		                  if(mapResponse.SubAdministrativeArea != null) 
		                       var cityname = mapResponse.SubAdministrativeArea.Locality.LocalityName; 
		                  else 
		                       var cityname = mapResponse.Locality.LocalityName; 
		             } 

		             //alert("zipCode = "+zipcode);
		             if (cityname != 'undefined' && cityname!= 'San Francisco') 
		             {                           
		                     // NOT a SF address. Continue processing next address found. 
		            	    //alert("NOT a SF address. Continue processing next address found");
			            	 form.txtLattitude.value='null';
			            	 form.txtLongitude.value='null';		            	 	 
		             } 
		             else
		             { 
		            	 // SF address confirmed. Set Lat-Lng and submit the request. 
		            	 //alert("SF address confirmed. Set Lat-Lng and submit the request.");
		            	 document.searchForm.txtLattitude.value=place.Point.coordinates[1];
		            	 document.searchForm.txtLongitude.value=place.Point.coordinates[0];
		            	 //alert("lattitude for input -> "+place.Point.coordinates[1]);
		            	 //alert("longitude for input -> "+place.Point.coordinates[0]);
		            	 break;
		             } 
				  }
				  
            	 document.searchForm.submit();
		  }catch(e)
		  { 
			  form.txtLattitude.value='null';
         	 form.txtLongitude.value='null';	
         	 document.searchForm.submit();
			//  alert("Error occured while searching input address. Please provide more detailed address and try again or contact administrator.");
		  }

	}

	function createMarker(point,html,index) {
	       //var marker = new GMarker(point, {title:index,labelText:index});
			var icon = new GIcon(G_DEFAULT_ICON);
	        icon.image = 'http://www.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png';
	        icon.iconSize = new GSize(35, 35);
	        icon.iconAnchor = new GPoint(0, 0);

	        opts = {
	                "icon": icon,
	                "clickable": true,
	                "labelText": index
	        };
	        var marker = new GMarker(point, opts);

		   GEvent.addListener(marker, "click", function() {
	    	   map.openInfoWindowHtml(point,html,{pixelOffset:new GSize(13,13)});
	       });
	        
	       return marker;
	}
	
	
	function <portlet:namespace />_setLatLngForSearch(response){
	   //alert("<portlet:namespace />_setLatLngForSearch called");
		/*alert("response ---> "+response);
		alert("response status.code---> "+response.Status.code);
		alert("placemark--->"+response.Placemark[0]);
		alert("placemark point--->"+response.Placemark[0].Point);*/
	    var form = document.getElementById("<portlet:namespace />_searchForm");
	    //alert("form = "+form);
	    //alert("response = "+response);
	    try
	    {
		  
		  	  //alert("response.Placemark.length = "+response.Placemark.length);
			  for(var i=0;i<response.Placemark.length;i++)
			  {
				  place = response.Placemark[i];
	             var mapResponse = response.Placemark[i].AddressDetails.Country.AdministrativeArea; 
	            // alert("map response is "+ (mapResponse).toString);
	              
	              if(mapResponse != null)
	              { 
	                  if(mapResponse.SubAdministrativeArea != null) 
	                       var cityname = mapResponse.SubAdministrativeArea.Locality.LocalityName; 
	                  else 
	                       var cityname = mapResponse.Locality.LocalityName; 
	             } 

	             //alert("zipCode = "+zipcode);
	             if (cityname != 'undefined' && cityname!= 'San Francisco') 
	             {                           
	                     // NOT a SF address. Continue processing next address found. 
	            	    //alert("NOT a SF address. Continue processing next address found");
		            	 form.txtLattitude.value='null';
		            	 form.txtLongitude.value='null';		            	 	 
	             } 

	             else
	             { 
	            	 // SF address confirmed. Set Lat-Lng and submit the request. 
	            	 //alert("SF address confirmed. Set Lat-Lng and submit the request.");
	            	 form.txtLattitude.value=place.Point.coordinates[1];
	            	 form.txtLongitude.value=place.Point.coordinates[0];
	            	 //alert("lattitude for input -> "+place.Point.coordinates[1]);
	            	 //alert("longitude for input -> "+place.Point.coordinates[0]);
	            	 break;
	             } 
			  }
			  
			  form.submit();
	  }catch(e)
	  { 
		  form.txtLattitude.value='null';
     	 form.txtLongitude.value='null';	
     	 form.submit();
		  //alert("Error occured while searching input address. Please provide more detailed address and try again or contact administrator.");
		  //alert(e);
	  }

	}

	function <portlet:namespace />_updateSelectedAddr(response)
	{
			//alert ('<portlet:namespace />__updateSelectedAddr called');
	       var form = document.getElementById("<portlet:namespace />_searchForm");
		   form.selAddress.value = response.Placemark[0].address;
		   form.txtAddress.value = response.Placemark[0].address;
		   form.selAddress.value = response.Placemark[0].address;
		   form.txtAddress.focus();
		   
		   <portlet:namespace />_updateLatLngForRefinement(response.Placemark[0].Point.coordinates[1],response.Placemark[0].Point.coordinates[0]);
	}
	
	function invokeEnterKey(thisEvent)
	{
	    if(thisEvent.keyCode == 13) // enter key
	    {
	    	<portlet:namespace />_validateInputs();
	    	return false;
	    }
	}


