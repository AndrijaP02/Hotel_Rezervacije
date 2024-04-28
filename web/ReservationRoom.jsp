
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation Room</title>
    </head>

    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";
            Connection conn = null;

            try {
                conn = DriverManager.getConnection(url, user, password);

                String roomId = request.getParameter("roomId");
                String hotelId = request.getParameter("hotelId");

                String checkin = request.getParameter("Checkin");
                String checkout = request.getParameter("Checkout");

                int adults = Integer.parseInt(request.getParameter("adults"));
                int children = Integer.parseInt(request.getParameter("Children"));

                String username = (session.getAttribute("username") != null) ? session.getAttribute("username").toString() : "";

                if (roomId != null && hotelId != null && checkin != null && checkout != null && username != null) {
                    String query_hotel = "SELECT * FROM hotel WHERE hotelId = '" + hotelId + "'";
                    Statement st1 = conn.createStatement();
                    ResultSet rs1 = st1.executeQuery(query_hotel);

                    if (rs1.next()) {
                        String hotelname = rs1.getString("hotelName");
                        Statement st = conn.createStatement();
                        String query = "SELECT * FROM room WHERE roomId = '" + roomId + "' AND adultsNum = '" + adults + "' AND childrenNum = '" + children + "'";
                        ResultSet rs = st.executeQuery(query);

                        String query2 = "SELECT * FROM reservation";
                        Statement st2 = conn.createStatement();
                        ResultSet rs2 = st2.executeQuery(query2);
                        boolean empty = !rs2.next();

                        if (rs.next()) {
                            query = "SELECT * FROM reservation WHERE roomId = '" + roomId + "'  AND (checkIn > '" + checkout + "' OR checkout < '" + checkin + "')";
                            rs = st.executeQuery(query);
                            if (!rs.next()) {
                                query = "INSERT INTO reservation (roomId , username , checkIn , checkout, hotelname)  VALUES('" + roomId + "', '" + username + "' , '" + checkin + "' , '" + checkout + "','" + hotelname + "')";
                                st.executeUpdate(query);
                                out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");
                                out.println("<h1 style='color:black;'>Reservation will be confirmed within 1 hour.!</h1>");
                            } else if (empty) {
                                query = "INSERT INTO reservation (roomId , username , checkIn , checkout, hotelname)  VALUES('" + roomId + "', '" + username + "' , '" + checkin + "' , '" + checkout + "','" + hotelname + "')";
                                st.executeUpdate(query);
                                out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");
                                out.println("<h1 style='color:black;'>Reservation will be confirmed within 1 hour.!</h1>");
                                response.sendRedirect("index.jsp");
                            } else {
                                out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");
                                out.println("Room not available now");
                            }
                        } else {
                            out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");

                            out.println("Required information: Room not available now");
                        }
                    } else {
                        out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");
                        out.println("Hotel not found");
                    }
                } else {
                    out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");
                    out.println("Missing or invalid parameters");
                }
            } catch (Exception e) {
                out.println("An error occurred: " + e.getMessage());
            } finally {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        out.println("Error closing database connection: " + e.getMessage());
                    }
                }
            }
        %>


    </body>

</html>

