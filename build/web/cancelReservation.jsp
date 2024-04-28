

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cancel Reservation</title>
    </head>
    <body>
        <%

            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";
            Connection conn = null;
            conn = (Connection) DriverManager.getConnection(url, user, password);

            String roomIdWithGar = request.getParameter("roomid");
            int roomId = Integer.parseInt(roomIdWithGar.substring(2, roomIdWithGar.length() - 2));

            Statement st = (Statement) conn.createStatement();

            String query = "SELECT * FROM reservation WHERE roomId = '" + roomId + "'";
            ResultSet rs = st.executeQuery(query);
            rs.next();
            String username = rs.getString("username");

            query = "SELECT * FROM client WHERE userName = '" + username + "'";
            rs = st.executeQuery(query);
            rs.next();
            String email = rs.getString("email");

            String quert_cancel = "DELETE FROM reservation WHERE roomId = '" + roomId + "' ";
            st.executeUpdate(quert_cancel);

            out.println("<html>");
            out.println("<head>");
            out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1 style='color:black;'>Uspešno obrisano!</h1>");
            out.println("</body>");
            out.println("</html>");


        %>
    </body>
</html>
