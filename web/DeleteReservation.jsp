<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Reservation</title>
    </head>
    <body>
        <%
            
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String username = request.getParameter("username");

            
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/hotel2";
                String user = "root";
                String password = "";
                con = DriverManager.getConnection(url, user, password);

                
                String deleteQuery = "DELETE FROM reservation WHERE roomId = ? AND username = ?";
                PreparedStatement preparedStatement = con.prepareStatement(deleteQuery);
                preparedStatement.setInt(1, roomId);
                preparedStatement.setString(2, username);

                
                int rowsAffected = preparedStatement.executeUpdate();

                
                if (rowsAffected > 0) {

                    out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
                    out.println("<h1 style='color:black;'>Done!</h1>");

                } else {

                    out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
                    out.println("<h1 style='color:black;'>Failed to Delete Reservation or Reservation Not Found!</h1>");

                }
            } catch (Exception e) {
                out.println("Exception caught: " + e.getMessage());
            } finally {
                if (con != null) {
                    con.close();
                }
            }
        %>
    </body>
</html>
