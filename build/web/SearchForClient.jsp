
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Client Page</title>
        <style>
            body{

                background-color: #ebe5fd;
            }
            .topnav a{
                margin: 5px 0px;
            }
            .topnav {
                background-color: #d0c2fa;
                overflow: hidden;
                display: flex;
                flex-wrap: wrap; /* Omogućava prelamanje elemenata na više redova */
                justify-content: center;
                gap: 10px;
                border-radius: 10px;
                flex-direction: row; /* Postavite da se elementi rasporede horizontalno */
            }

            /* Postavite početnu širinu linkova */
            .topnav a {
                flex-basis: auto; /* Postavite širinu na automatsko kako bi se linkovi pravilno rasporedili */
                color: #5a4489;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
                font-size: 17px;
                box-sizing: border-box; /* Uklonite dodatni prostor uzrokovan paddingom */
            }

            /* Promenite boju linkova na hover */
            .topnav a:hover {
                background-color: #ac92f5;
                color: white;
                border-radius: 5px;
            }

            /* Dodajte boju trenutnom linku */
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


            body{
                font-family:Arial;
            }
            h4{
                background-color: #f1f1f1;
                display: inline;
                border-radius: 5px;
                padding: 5px;
                margin-right: 10px;
            }

            ul{
                background-color: #d0c2fa;
            }
            h1{
                background-color: #F1F1F1;
                text-align: center;
                margin-top: 20px;
                text-shadow: 1px 1px 3px #d0c2fa;
            }
            h2{
                background-color: #F1F1F1;
                text-align: left;
                margin-top: 20px;
                padding: 5px;
                border-radius: 5px;
            }

            .sectionPrfole{
                width: 50%;
                height: 50%;
                padding: 20px;
                background-color: #d0c2fa;
                margin-left: 23%;
                margin-top: 2%;
                margin-bottom:  2%;
                border-radius: 10px;
            }
            button{
                color: #222222;
                background-color: #f1f1f1;
                padding: 5px;
                margin-top: 7px;
                border-radius: 5px;
                text-decoration: none;
            }
            button:hover{
                background-color: #ebe5fd;
            }
            a{
                color:#222222;
                padding: 5px;
                text-decoration: none;

            }
            table {
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 100%;
            }

            td, th {
                border: 1px solid #9e7ff4;
                text-align: center;
                padding: 8px;
                background-color: #F1F1F1;
            }

            tr:nth-child(even) {
                background-color: #dddddd;
            }
            .btn{
                background-color: #F1F1F1;
                text-align: center;
            }
            hr.line1{
                border-top: 1px solid #9e81f3;
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
        <%

            String username = request.getParameter("username");
            if (username == null || username.isEmpty()) {
                // Ako korisnik nije unio korisničko ime, prikažite poruku
                out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
                out.println("<h1 style='color:black;'>Molimo unesite korisničko ime!</h1>");
                return; // Prekida izvršavanje metode
            }
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";
            Connection conn = null;

            conn = (Connection) DriverManager.getConnection(url, user, password);

            String query = "SELECT * FROM client WHERE userName = '" + username + "'";

            Statement st = (Statement) conn.createStatement();

            ResultSet rs_peronal = st.executeQuery(query);

            query = "SELECT * FROM reservation WHERE userName = '" + username + "'";
            Statement st2 = (Statement) conn.createStatement();
            ResultSet rs_reservation = st2.executeQuery(query);


        %>

        <h1>PROFILE</h1>

        <hr class="line1">

        <div class='sectionPrfole'>
            <h2>PERSONAL INFORMATION</h2>
            <hr class="line1">

            <% while (rs_peronal.next()) {%>
            <h4>First name: </h4><%= rs_peronal.getString("fname")%><br><br>
            <h4>Last name: </h4><%= rs_peronal.getString("lname")%><br><br>
            <h4>Account balance: </h4><%= rs_peronal.getString("balance") + "$"%><br><br>
            <h4>Personal phone:</h4> <%= rs_peronal.getString("phone")%><br><br>
            <h4>Username:</h4> <%= rs_peronal.getString("userName")%><br><br>
            <h4>Personal Email:</h4> <%= rs_peronal.getString("email")%><br><br>
            <h4>Account password:</h4> <%= rs_peronal.getString("password")%><br><br>
            <%}%>
        </div>
        <hr class="line1">

        <div class='sectionPrfole'>
            <h2>RESERVATION</h2>
            <hr class="line1">

            <table>
                <tr>
                    <th>Room Number</th>
                    <th>Check in</th>
                    <th>Check out</th>
                </tr>
                <% while (rs_reservation.next()) {%>
                <tr>
                    <td><%= rs_reservation.getInt("roomId")%></td>
                    <td><%= rs_reservation.getString("checkIn")%></td>
                    <td><%= rs_reservation.getString("checkout")%></td>
                </tr>
                <%}%>
            </table>

        </div>

    </body>
</html>
