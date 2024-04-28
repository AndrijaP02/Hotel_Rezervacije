
<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/readmore1.css">
        <link rel="stylesheet" href="css/lightslider.css">
        <script src="js/JQuery3.3.1.js"></script>
        <script src="js/lightslider.js"></script>
    </head>
    <body >


        <%
            Connection con = null;
            Blob image = null;
            try {

                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel2", "root", "");

            } catch (ClassNotFoundException ex) {

            }
            String roomwithgar = request.getParameter("roomid");
            String room = roomwithgar.substring(2, roomwithgar.length() - 2);
            String hotilwithgare = request.getParameter("hotilid");
            String hotil = hotilwithgare.substring(2, hotilwithgare.length() - 2);

            PreparedStatement preparedStatement = con.prepareStatement("select * from hotel where hotelId  = '" + hotil + "'");

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
        %>
        <div class="container">
            <%
                PreparedStatement preparedStatement2 = con.prepareStatement("select * from room where roomId  = '" + room + "'");

                ResultSet rs2 = preparedStatement2.executeQuery();
                while (rs2.next()) {

            %>
            <div class="content">
                <h1>Hotel Name : <%=rs.getString("hotelName")%></h1>
                <h3>Number Of Adults :  <%=rs2.getString("adultsNum")%> adult</h3>
                <h3>Number Of Children :  <%=rs2.getString("childrenNum")%> child</h3>
                <h3>Price :  <%=rs2.getString("price")%> $</h3>
                <h3>Location :  <%=rs.getString("location")%> </h3>
                <button><a href='ReservationForm.jsp?roomid2="+<%=rs2.getString("roomId")%>+"&hotelid2="+<%=rs2.getString("hotelId")%>+"'>Reserve</a></button>
            </div>
        </div>
        <% } %>

        <section id="main">
            <!--showcase----------------------->
            <!--heading------------->


            <ul id="autoWidth" class="cs-hidden">

                <!--box-1--------------------------->

                <li class="item-a">
                    <!--showcase-box------------------->
                    <div class="showcase-box">
                        <% image = rs.getBlob("image");
                            byte[] imageBytes = image.getBytes(1, (int) image.length());
                            String encodedImage = Base64.getEncoder().encodeToString(imageBytes);
                            String image2 = "data:image/jpg;base64," + encodedImage;
                            out.print("<img src=" + image2 + ">"); %>
                    </div>
                </li>

            </ul>
        </section>

        <% }%>

        <script>
            $(document).ready(function () {
                $('#autoWidth,#autoWidth2').lightSlider({
                    autoWidth: true,
                    loop: true,
                    onSliderLoad: function () {
                        $('#autoWidth,#autoWidth2').removeClass('cS-hidden');
                    }
                });
            });
        </script>
    </body>
</html>
