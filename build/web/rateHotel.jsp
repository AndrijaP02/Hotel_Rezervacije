<!DOCTYPE html> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rate Hotel</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #ebe5fd;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column; /* Postavi flex direction na kolonu */
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            h1 {
                text-align: center;
                color: black;
                text-shadow: 1px 1px 2px #ac5aff;
            }

            form {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px #a98dff;
            }

            form label {
                display: block;
                margin: 10px 0;
                text-align: center; /* Poravnanje teksta na levoj strani */
            }

            form input,
            form textarea,
            form select,
            form input[type="submit"] {
                display: block;
                margin: 10px 0;
                margin: 0 auto;/* Puna širina unutar forme */
                border-radius: 5px;
                border: 2px solid #a98dff;
                padding: 5px; /* Dodaj odgovarajući padding za bolji izgled */
            }

            form input[type="submit"] {
                background-color: #d0c2fa;
                margin-top: 15px;
            }

            form input[type="submit"]:hover {
                color: white;
                background-color: #ac5aff;
            }
        </style>

    </head>
    <body>
        <h1>Rate Hotel</h1>
        <form action="rateHotel" method="POST">
            <input type="hidden" name="hotelId" value="<%= request.getParameter("hotelId")%>">

            <label for="userName">Your Username:</label>
            <input type="text" name="userName" required placeholder="Enter Your Username">

            <label for="StarsNumber">Stars Number (1-5):</label>
            <input type="number" name="StarsNumber" min="1" max="5" required placeholder="*">

            <label for="comment">Comment:</label>
            <textarea name="comment" rows="4" cols="50" required placeholder="Enter Your Review"></textarea>

            <input type="submit" value="Submit Rating">
        </form>
    </body>
</html>
