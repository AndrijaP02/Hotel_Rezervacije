
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MY PROFILE</title>
        <link rel="styleSheet" href="css/profileStyle1.css">
        <link rel="styleSheet" href="css/LoginStyle1.css">
        <style>
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

            div{
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
        <%

            String id = (String) session.getAttribute("username");
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";
            Connection conn = null;

            conn = (Connection) DriverManager.getConnection(url, user, password);

            String query = "SELECT * FROM client WHERE userName = '" + id + "'";

            Statement st = (Statement) conn.createStatement();

            ResultSet rs_peronal = st.executeQuery(query);

            query = "SELECT * FROM reservation WHERE userName = '" + id + "'";
            Statement st2 = (Statement) conn.createStatement();
            ResultSet rs_reservation = st2.executeQuery(query);

        %>
        <ul class="menu">
            <li> <a href="index.jsp"> <strong>STARS HOTEL</strong></a></li>
        </ul>
        <h1>PROFILE</h1>

        <hr class="line1">

        <div>
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
            <button type="button"><a href='update-form.jsp?username=" <%= rs_peronal.getString("userName")%> "'>Update Personal Data</a></button>
            <%}%>
        </div>
        <hr class="line1">

        <div>
            <h2>RESERVATION</h2>
            <hr class="line1">

            <table>
                <tr>
                    <th>Room Number</th>
                    <th>Check in</th>
                    <th>Check out</th>
                    <th>Action</th>
                    <th>Status</th>
                </tr>
                <% while (rs_reservation.next()) {%>
                <tr>
                    <td><%= rs_reservation.getInt("roomId")%></td>
                    <td><%= rs_reservation.getString("checkIn")%></td>
                    <td><%= rs_reservation.getString("checkout")%></td>
                    <td class="btn"><button type="button"><a href='cancelReservation.jsp?roomid=" <%= rs_reservation.getInt("roomId")%> "'>Cancel</a></button></td>
                    <td class="btn">
                        <%
                            int confirmStatus = rs_reservation.getInt("confirm");
                            if (confirmStatus == 0) {
                        %>
                        <button type="button">Pending</button>
                        <%
                        } else {
                        %>
                        <button type="button">Confirmed</button>
                        <%
                            }
                        %>
                    </td>
                </tr>
                <%}%>
            </table>

        </div>
    </body>
</html>
