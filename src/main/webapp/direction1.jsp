<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  
    <title>Direction</title>
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
 
			<form>
			 <div class="row">
				<div class="form-group col-6">
					<label for="source">Source</label> <input
						type="text" class="form-control" id="source"
						placeholder="Example input">
				</div>
				<div class="form-group col-6">
					<label for="destination">Destination</label> <input
						type="text" class="form-control" id="destination"
						placeholder="Another input">
				</div>
				 
				</div>
			</form>
			  <button id="directionBtn" class="btn btn-primary float-right " >Submit</button>

   </div>
   
    <div id="map"  class="container mt-5" style="    height: 80%;"></div>
     
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script>
      // Note: This example requires that you consent to location sharing when
      // prompted by your browser. If you see the error "The Geolocation service
      // failed.", it means you probably did not give permission for the browser to
      // locate you.
    
      var address
      var source
      var dest
      var markerArray = [];
      var stepDisplay 
      var map
      var directionsDisplay;var directionsService 
   //   document.getElementById('end').addEventListener('click', onChangeHandler);
       function initMap() {

        // Instantiate a directions service.
        directionsService= new google.maps.DirectionsService;

        // Create a map and center it on Manhattan.
       map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 40.771, lng: -73.974}
        });
       stepDisplay = new google.maps.InfoWindow;
        // Create a renderer for directions and bind it to the map.
        directionsDisplay= new google.maps.DirectionsRenderer({map: map});

        // Instantiate an info window to hold step text.

        // Display the route between the initial start and end selections.
        calculateAndDisplayRoute(
            directionsDisplay, directionsService, markerArray, stepDisplay, map);
        // Listen to change events from the start and end lists.
       
      //  document.getElementById('end').addEventListener('change', onChangeHandler);
      }


       
       function onChangeHandler() {
       	console.log("event" );
         calculateAndDisplayRoute(
             directionsDisplay, directionsService, markerArray, stepDisplay, map);
       };
       function calculateAndDisplayRoute(directionsDisplay, directionsService,
           markerArray, stepDisplay, map) {
         // First, remove any existing markers from the map.
         for (var i = 0; i < markerArray.length; i++) {
           markerArray[i].setMap(null);
         }

         // Retrieve the start and end locations and create a DirectionsRequest using
         // WALKING directions.
         directionsService.route({
           origin: source,//document.getElementById('start').value,
           destination: dest,//document.getElementById('end').value,
           travelMode: 'DRIVING'
         }, function(response, status,error) {
           // Route the directions and pass the response to a function to create
           // markers for each step.
           if (status === 'OK') {
           /*   document.getElementById('warnings-panel').innerHTML =
                 '<b>' + response.routes[0].warnings + '</b>'; */
                 console.log("response.routes[0].warnings "+response.routes[0].warnings )
             directionsDisplay.setDirections(response);
             showSteps(response, markerArray, stepDisplay, map);
           } else {
        	   console.log(error)
             window.alert('Directions request failed due to ' + status);
           }
         });
       }
       
       function showSteps(directionResult, markerArray, stepDisplay, map) {
           // For each step, place a marker, and add the text to the marker's infowindow.
           // Also attach the marker to an array so we can keep track of it and remove it
           // when calculating new routes.
           var myRoute = directionResult.routes[0].legs[0];
           for (var i = 0; i < myRoute.steps.length; i++) {
             var marker = markerArray[i] = markerArray[i] || new google.maps.Marker;
             marker.setMap(map);
             marker.setPosition(myRoute.steps[i].start_location);
             attachInstructionText(
                 stepDisplay, marker, myRoute.steps[i].instructions, map);
           }
         }

         function attachInstructionText(stepDisplay, marker, text, map) {
           google.maps.event.addListener(marker, 'click', function() {
             // Open an info window when the marker is clicked on, containing the text
             // of the step.
             stepDisplay.setContent(text);
             stepDisplay.open(map, marker);
           });
         }
         $(document).ready(function(){
        	 $("#directionBtn").unbind().click(function(event){
        		//alert("hello"); 
        		  source=$("#source").val();
        		  dest= $("#destination").val();
        		//alert(source+" "+dest);
        		
        		  onChangeHandler()
        	 });
        	});
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbGE6mOdq0ReQRMbbEjWJnXfef3812dc0&callback=initMap">
    </script>
  </body>
</html>