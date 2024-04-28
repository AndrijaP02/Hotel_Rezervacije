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
    <link rel="styleSheet" href="css/profileStyle.css">
    <link rel="styleSheet" href="css/LoginStyle.css">
    <style>
        <!-- Vaš stil ostaje nepromenjen -->
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
    <li> <a href="index.jsp"> <strong>PYRAMIDS.COM</strong></a></li>
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
    <button type="button"><a href='update-form.jsp?username=<%= rs_peronal.getString("userName")%>'>Update Personal Data</a></button>
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
            <th>Status</th>
        </tr>
        <% while (rs_reservation.next()) {%>
        <tr>
            <td><%= rs_reservation.getInt("roomId")%></td>
            <td><%= rs_reservation.getString("checkIn")%></td>
            <td><%= rs_reservation.getString("checkout")%></td>
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
</html><%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MY PROFILE</title>
    <link rel="styleSheet" href="css/profileStyle.css">
    <link rel="styleSheet" href="css/LoginStyle.css">
    <style>
        <!-- Vaš stil ostaje nepromenjen -->
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
    <li> <a href="index.jsp"> <strong>PYRAMIDS.COM</strong></a></li>
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
    <button type="button"><a href='update-form.jsp?username=<%= rs_peronal.getString("userName")%>'>Update Personal Data</a></button>
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
            <th>Status</th>
        </tr>
        <% while (rs_reservation.next()) {%>
        <tr>
            <td><%= rs_reservation.getInt("roomId")%></td>
            <td><%= rs_reservation.getString("checkIn")%></td>
            <td><%= rs_reservation.getString("checkout")%></td>
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