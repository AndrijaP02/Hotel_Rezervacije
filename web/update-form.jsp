
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Profile</title>
        <style>
            h3{
                text-align: center;
            }
            body{
                font-family: Arial;
                background-color: #ebe5fd;
            }
            .form-section{
                width:50%;
                height:50%;
                padding: 20px;
                background-color: #F1F1F1;
                margin-left:23%;
                margin-top: 5%;
                border-radius: 15px;
                box-shadow: 0 0 3px #9e81f3 inset;
            }
            
            .form-section input{
                border-radius: 5px;
                border: 2px solid #ac92f5;
            }
            
            .int{
                color: white;
                background-color: #ac92f5;
                padding: 5px;
                width:60px;
            }
            .int:hover{
                background-color: #ebe5fd;
                color:#222222;
            }
            hr.line1{
                border-top: 1px solid #9e81f3;
            }

        </style>
    </head>

    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";
            Connection conn = null;

            conn = (Connection) DriverManager.getConnection(url, user, password);
            String usernameWithGar = request.getParameter("username");

            String username = usernameWithGar.substring(2, usernameWithGar.length() - 2);

            String query = "SELECT * FROM client WHERE userName = '" + username + "'";

            Statement st = (Statement) conn.createStatement();
            ResultSet rs = st.executeQuery(query);
        %>

        <%if (rs.next() == true) {%>
        <form class="form-section" action="updateProfile?username= <%= username%>">

            <h3>UPDATE PROFILE</h3>   
            <hr class="line1">
            <label>Username:</label><br>
            <input type="text" value="<%= rs.getString("userName")%>"  name="username" readonly><br><br>
            <label>First name:</label><br>
            <input type="text" value="<%= rs.getString("fname")%>"  name="fname"><br><br>
            <label>Last name</label><br>
            <input type="text" value="<%= rs.getString("lname")%>"  name="lname"><br><br>
            <label>Email:</label><br>
            <input type="text" value="<%= rs.getString("email")%>"  name="email"><br><br>
            <label>Password:</label><br>
            <input type="text" value="<%= rs.getString("password")%>"  name="password"><br><br>
            <label>Phone number:</label><br>
            <input type="text" value="<%= rs.getString("phone")%>" name="phone"><br><br>

            <input class="int" type="submit" value="Save"><br><br>
            <%}%>
        </form>
    </body>
</html>
