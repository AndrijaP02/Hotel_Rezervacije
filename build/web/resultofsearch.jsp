

<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Result</title>
        <link rel="stylesheet" href="css/resultofsearch1.css">
        <link rel="stylesheet" href="css/lightslider.css">

    </head>
    <body>
        <%
            //connect to database
            Connection con = null;
            Blob image = null;

            try {

                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel2", "root", "");

            } catch (ClassNotFoundException ex) {

            }
            String going = request.getParameter("going");
            String chechin = request.getParameter("Checkin");
            String chechout = request.getParameter("Checkout");
            String adults = request.getParameter("adults");
            String children = request.getParameter("Children");

            String query = "SELECT * FROM room WHERE adultsNum <= ? AND childrenNum <= ? AND room.hotelId IN (SELECT hotelId FROM hotel WHERE location = ?)";
            PreparedStatement preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, adults);
            preparedStatement.setString(2, children);
            preparedStatement.setString(3, going);
           
            ResultSet rs = preparedStatement.executeQuery();

        %>
        <section id="main">
            <!--showcase----------------------->
            <!--heading------------->
            <h1 class="showcase-heading">Available Rooms</h1>

            <ul id="autoWidth" class="cs-hidden">

                <!--box-1--------------------------->
                <%while (rs.next()) {

                %>
                <li class="item-a">

                    <!--showcase-box------------------->
                    <div class="showcase-box">
                        <% image = rs.getBlob("image");
                            byte[] imageBytes = image.getBytes(1, (int) image.length());
                            String encodedImage = Base64.getEncoder().encodeToString(imageBytes);
                            String image2 = "data:image/jpg;base64," + encodedImage;
                            out.print("<img src=" + image2 + ">");%>
                    </div>
                    <div class="latest-b-text">
                        <h3>Hotel Number :  <%= rs.getString("hotelId")%></h3>
                        <h3>Children Number :  <%= rs.getString("childrenNum")%> child</h3>
                        <h3>Adults number :  <%= rs.getString("adultsNum")%> adult</h3>
                        <h3>Price :  <%= rs.getString("price")%> $</h3>
                        <button><a href='readmore.jsp?roomid="+<%=rs.getString("roomId")%>+"&hotilid="+<%=rs.getString("hotelId")%>+"'>Read More...</a></button>
                    </div>
                </li>
                <% }%>
            </ul>
        </section>
    </body>
</html>
