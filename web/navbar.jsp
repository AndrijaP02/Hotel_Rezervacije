<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>STARS</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="styleSheet" href="css/navbar.css">
        <link rel="styleSheet" href="css/lightslider.css">
        <script src="js/JQuery3.3.1.js"></script>
        <script src="js/lightslider.js"></script>
    </head>
    <body>
        <nav>
            <!--menu-------------->
            <ul class="menu">
                <li> <a id="name"> <strong>STARS Hotels</strong></a></li>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="#contact">Contact Us</a></li>
                <li><a href="#about">About Us</a></li>
            </ul>

            <ul class="menu">
                <% 
                    String username= (String) session.getAttribute("username");                     
                if (username == null) {
                %>
                <li><a href="Login.html">Login</a></li>
                <li><a href="SignUp.html">Sign Up</a></li>
                <% } else{
                %>
                <li><a href="logout.jsp">Log Out</a></li>
                <li><a href="Profile.jsp">Profile</a></li>
                <% } %>
            </ul>
        </nav>

    </body>
</html>
