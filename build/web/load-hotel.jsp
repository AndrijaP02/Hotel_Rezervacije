

<%@page import="java.util.Base64"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hotel</title>
        <link rel="stylesheet" href="css/load-hotel1.css">
    </head>
    <body>

        <!--Our Room start-->
        <div class="our-room text-center ptb-80 white-bg">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-title">
                            <h2>Our <span>Hotels</span></h2>
                            <p>Your home away from home – for your entire extended stay.</p>
                        </div>
                    </div>
                </div>
                <div class="our-room-show">
                    <div class="row">
                        <div class="carousel-list">

                            <%
                                Connection con = null;
                                Blob image = null;
                                byte[] imgData = null;
                                PreparedStatement psmnt = null;

                                InputStream sImage;
                                try {

                                    Class.forName("com.mysql.jdbc.Driver");
                                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel2", "root", "");

                                } catch (ClassNotFoundException ex) {

                                }
                                PreparedStatement preparedStatement = con.prepareStatement("select * from hotel");

                                ResultSet rs = preparedStatement.executeQuery();
                                while (rs.next()) {
                            %>
                            <div class="col-md-4">
                                <div class="single-room">
                                    <div class="room-img">
                                        <% image = rs.getBlob("image");
                                            byte[] imageBytes = image.getBytes(1, (int) image.length());
                                            String encodedImage = Base64.getEncoder().encodeToString(imageBytes);
                                            String image2 = "data:image/jpg;base64," + encodedImage;
                                            out.print("<img src=" + image2 + ">");%>
                                    </div>
                                    <div class="room-desc">
                                        <div class="room-name" style="text-transform: uppercase; text-shadow: 1px 1px 1px #000000;">
                                            <h3><%=rs.getString("hotelName")%></h3>
                                        </div>
                                        <div class="room-adds">
                                            <h5>Email: <span><%=rs.getString("email")%></span></h5>
                                            <h5>Phone: <span><%=rs.getString("phone")%></span></h5>
                                        </div>
                                        <div class="room-rent">
                                            <h5>Location: <span><%=rs.getString("location")%></span></h5>
                                        </div>
                                        <div class="rate-button">
                                            <a  href="rateHotel.jsp?hotelId=<%= rs.getInt("hotelId")%>">Rate Hotel</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% }%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Our room end-->
        <div id="about">
            <div class="section-header">
            <h2>DOBRODOŠLI STE</h2>
            <p>Potrebna vam je pomoć? <span> Posetite nas! </span></p>
        </div>

        <div class="mb-3">
            <iframe style="width: 100%; height:350px; border:2px solid #9999ff; border-radius: 10px;"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2830.2983119370665!2d20.4758911!3d44.815487000000005!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x475a7abbf6cdcb45%3A0x4e87088a7a4bbcba!2sTakovska%2047%2C%20Beograd%2C%20Serbia!5e0!3m2!1sen!2s!4v1692041519997!5m2!1sen!2s"
                frameborder="0" allowfullscreen=""></iframe>
        </div>
        </div>
        <div id="contact">
             <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <div>
                            <h4>Adresa</h4>
                            <p>
                                Takovska 47 <br>
                                11108 Beograd - Srbija<br>
                            </p>
                        </div>

                    </div>

                    <div class="col-md-4">
                        <div>
                            <h4>Kontaktirajte nas</h4>
                            <p>
                                <strong>Telefon:</strong> +381 64 585 8787<br>
                                <strong>Email:</strong> info@starsHotel.com<br>
                            </p>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div>
                            <h4>Radno vreme</h4>
                            <p>
                                <strong>Pon-Sub: 09h - 20h </strong><br>
                                Nedelja: Zatvoreno
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>

