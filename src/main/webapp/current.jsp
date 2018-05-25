<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  
    <title>Geolocation</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
  <div class="container mt-5 mb-2">
  <div class="row">
   <div class="dropdownTest" id="drop">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Select Place
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a class="dropdown-item" href="#">forum mall</a>
     <a class="dropdown-item" href="#">Hebbal Bridge</a>
      <a class="dropdown-item" href="#">Majistic Bus Stop</a>
      <a class="dropdown-item" href="#">Orion Mall</a>
      <a class="dropdown-item" href="#">BTM Layout</a>
      <a class="dropdown-item" href="#"> No.18, Mayura Street, 10th Cross, Papanna Layout, Nagashettyhalli, RMV 2nd Stage, Bengaluru, Karnataka 560094</a>
  </div>
</div>
   </div>
   </div>
    <div id="map"  class="container" style="    height: 80%;"></div>
     
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script>
      // Note: This example requires that you consent to location sharing when
      // prompted by your browser. If you see the error "The Geolocation service
      // failed.", it means you probably did not give permission for the browser to
      // locate you.
    
      var address
      $(document).ready(function(){
    	  $(".dropdownTest>.dropdown-menu>.dropdown-item").unbind().click(function(event){
    		  address =  $(this).text();  // Get the text of the element
    		  //  alert(x);
    		    document.getElementById("dropdownMenuButton").innerHTML=address;
    		    
    		    codeAddress();
    		});
    	});
      
      
      var geocoder;
      var map, infoWindow;
      function initMap() {
        
        
        


        // Try HTML5 geolocation.
        if (navigator.geolocation) {
        	
        	
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            
            map = new google.maps.Map(document.getElementById('map'), {
                center: pos,
                zoom: 16
              });
            var infowindow = new google.maps.InfoWindow({
                content: "Gupta ji location"
              });
            
             
             geocoder = geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': pos }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                    	  infowindow.setContent( results[1].formatted_address);
                    }
                }
            });
            
            
     
            
            
            var marker = new google.maps.Marker({position: pos, map: map});

            marker.addListener('click', function() {
                infowindow.open(map, marker);
              });
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
      }

      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
      }
      function codeAddress() {
    	    //var address = address;//document.getElementById('address').value;
    	    console.log(address)
    	    geocoder.geocode( { 'address': address}, function(results, status) {
    	      if (status == 'OK') {
    	        map.setCenter(results[0].geometry.location);
    	         marker = new google.maps.Marker({
    	            map: map,
    	            position: results[0].geometry.location
    	        });
    	      } else {
    	        alert('Geocode was not successful for the following reason: ' + status);
    	      }
    	    });
    	  }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbGE6mOdq0ReQRMbbEjWJnXfef3812dc0&callback=initMap">
    </script>
  </body>
</html>