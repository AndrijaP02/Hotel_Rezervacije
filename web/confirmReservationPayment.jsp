

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Reservation </title>
        <style>
            .submit{
                width: 20%;
                background-color: #d0c2fa;
                border: 2px solid #a98dff;
                border-radius: 5px;
                margin-left: 299px;
            }
            .submit:hover{
                color:white;
                background-color: #ac5aff;

            }
            form h1{
                text-align: center;
                color: black;
                text-shadow: 1px 1px 2px #ac5aff;
            }
            .input{
                width: 30%;
                margin: 0 auto;
                margin-left: 250px;
                border: 2px solid #a98dff;
                border-radius: 5px;
                padding: 5px;
            } /* Centrirajte formu horizontalno */

            form {
                width: 50%; /* Postavite željenu širinu forme */
                margin: 0 auto; /* Centrirajte formu horizontalno */
                padding: 20px; /* Dodajte malo prostora oko forme */
            }

            body{

                background-color: #ebe5fd;
                margin: 0;
                padding: 0;
                display: flex; /* Koristi flex model za horizontalno poravnanje */
                flex-wrap: wrap; /* Omogućava wrap elementima unutar .topnav */
                justify-content: center; /* Centriraj sadržaj horizontalno */
            }

            .topnav {
                background-color: #d0c2fa;
                overflow: hidden;
                display: flex; /* Koristi flex model za horizontalno poravnanje linkova */
                flex-wrap: wrap; /* Omogućava wrap linkovima unutar .topnav */
                justify-content: center; /* Centriraj linkove horizontalno */
                gap: 10px; /* Dodaj razmak između linkova */
                border-radius: 10px;
            }

            /* Style the links inside the navigation bar */
            .topnav a {
                color: #5a4489;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
                font-size: 17px;
            }

            /* Change the color of links on hover */
            .topnav a:hover {
                background-color: #ac92f5;
                color: white;
                border-radius: 5px;
            }

            /* Add a color to the active/current link */
            .topnav a.active {
                background-color: #ac92f5;
                color: white;
                text-shadow: 1px 1px 2px white;
                border-radius: 5px;
            }

            .topnav a.active:hover {
                background-color: #ac5aff;
                color: white;
                text-shadow: 1px 1px 2px white;
            }
        </style>
    </head>
    <body>

        <div class="topnav">
            <a class="active" href="admin.html">STARS HOTEL</a>
            <a href="checkin.jsp">Check Client In</a>
            <a href="ckeckout.jsp">Check Client Out</a>
            <a href="ViewReservationList.jsp">View Reservation List</a>
            <a href="ReservationHistory.html">Reservation history</a>
            <a href="SearchForClient.html">Search For Client</a>
            <a href="cancelReservation.html">Cancel Reservation</a>
            <a href="confirmReservationPayment.jsp">Confirm Reservation Payment</a>
            <a href="updateHotelInformation.jsp">Update Hotel Information</a>
            <a href="uploadPhotos.jsp">Upload Hotel Photos</a>
            <a href="uploadPhotos.jsp">Update Hotel Photos</a>
            <a href="addHotel.jsp">Add Hotel</a>
            <a href="addroom.jsp">Add Room</a>
            <a href="updateroom.jsp">Update Room</a>
            <a href="viewHotelRating.jsp">View Hotel Rating</a>
            <a class="active" href="logout.jsp">Log Out</a>
        </div>
        <form action="confirmreservation">
            <h1>Please Enter Client Name To Confirm His Reservation </h1> 
            <input type="text" name="username" required class="input" placeholder="Enter Client Name"><br><br>
            <input type="submit" value="Confirm Reservation" class="submit">
        </form>
    </body>
</html>

