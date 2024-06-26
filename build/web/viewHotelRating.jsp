
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            
            table {
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 100%;
                background-color: white;
                border-radius: 10px;
            }

            td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            tr:nth-child(even) {
                background-color: #dddddd;
            }
            h1{
                text-align: center;
                color: black;
                text-shadow: 1px 1px 2px #ac5aff;
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
        <h1>Hotel Rating</h1>
        <%

            java.sql.Connection con;
            try {

                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/hotel2";
                String user = "root";
                String password = "";
                Statement stat = null;
                con = DriverManager.getConnection(url, user, password);
                stat = con.createStatement();
                ResultSet result = stat.executeQuery("SELECT rate.*, hotel.hotelName "
                        + "FROM rate "
                        + "INNER JOIN hotel ON rate.hotelId = hotel.hotelId;");
        %>
        <table>
            <tr>
                <th>
                    Hotel
                </th>
                <th>
                    Comment
                </th>
                <th>
                    Stars Number
                </th>
                <th>
                    Client
                </th>
            </tr>

            <%
                while (result.next()) {


            %> <tr> <td>
                    <%                        out.println(result.getString("hotelName"));
                    %>
                </td>  
                <td>
                    <%
                        out.println(result.getString("comment"));
                    %>
                </td>
                <td>
                    <%
                        out.println(result.getString("starsNumber"));

                    %>
                </td>
                <td>
                    <%                        out.println(result.getString("userName"));
                    %>
                </td></tr>
                <%
                    }
                %>
        </table>
        <%
                result.close();
            } catch (SQLException e) {
                out.println("SQLException caught: " + e.getMessage());
            }

        %>
    </body>
</html>
