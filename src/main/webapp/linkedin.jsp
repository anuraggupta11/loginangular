<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="//platform.linkedin.com/in.js">
    api_key: 819iggtnfj6aca
    authorize: true
    onLoad: onLinkedInLoad
    scope: r_basicprofile r_emailaddress
</script>
 
<title>Linkedin login</title>
</head>
<body>
<!-- sign in with linkedin button -->
<script type="in/Login"></script>
<!-- display profile info -->
<div  class="container" style="    text-align: center;">
<div id="profileData" style="display: none;">
    <p><a href="javascript:void(0);" onclick="logout()">Logout</a></p>
    <div id="picture"></div>
    <div class="info">
        <p id="name"></p>
        <p id="intro"></p>
        <p id="email"></p>
        <p id="location"></p>
        <p id="link"></p>
    </div>
</div>

</div>
<script type="text/javascript">
    // Setup an event listener to make an API call once auth is complete
    function onLinkedInLoad() {
        IN.Event.on(IN, "auth", getProfileData);
    }
    
    // Use the API call wrapper to request the member's profile data
    function getProfileData() {
        IN.API.Profile("me").fields("id", "first-name", "last-name", "headline", "location", "picture-url", "public-profile-url", "email-address").result(displayProfileData).error(onError);
    }

    // Handle the successful return from the API call
    function displayProfileData(data){
        var user = data.values[0];
        document.getElementById("picture").innerHTML = '<img src="'+user.pictureUrl+'" />';
        document.getElementById("name").innerHTML = user.firstName+' '+user.lastName;
        document.getElementById("intro").innerHTML = user.headline;
        document.getElementById("email").innerHTML = user.emailAddress;
        document.getElementById("location").innerHTML = user.location.name;
        document.getElementById("link").innerHTML = '<a href="'+user.publicProfileUrl+'" target="_blank">Visit profile</a>';
        document.getElementById('profileData').style.display = 'block';
    }

    // Handle an error response from the API call
    function onError(error) {
        console.log(error);
    }
    
    // Destroy the session of linkedin
    function logout(){
        IN.User.logout(removeProfileData);
    }
    
    // Remove profile data from page
    function removeProfileData(){
        document.getElementById('profileData').remove();
    }
</script>
</body>
</html>