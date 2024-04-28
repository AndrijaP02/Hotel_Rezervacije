/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author andri
 */
public class addhotel extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       try {
            int hotelId = generateNextHotelId();
            String hotelName = request.getParameter("hotelname");
            String hotelLocation = request.getParameter("hotellocation");
            String hotelEmail = request.getParameter("hotelemail");
            String hotelPhone = request.getParameter("hotelphone");
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(addhotel.class.getName()).log(Level.SEVERE, null, ex);
            }
            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";
            Connection con = DriverManager.getConnection(url, user, password);
                    PreparedStatement pstmt = null;

             pstmt = con.prepareStatement("INSERT INTO hotel (hotelID, hotelName, email, phone, location) VALUES (?, ?, ?, ?, ?);");
        pstmt.setInt(1, hotelId);
        pstmt.setString(2, hotelName);
        pstmt.setString(3, hotelEmail);
        pstmt.setString(4, hotelPhone);
        pstmt.setString(5, hotelLocation);
        
        int count = pstmt.executeUpdate();

        if (count > 0) {
           PrintWriter out = response.getWriter();

String successMessage = "Vaš hotel je uspešno dodat! Bićete preusmereni na admin stranicu za 3 sekunde.";

out.println("<html>");
out.println("<head>");
out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
out.println("<title>Uspešno dodat hotel</title>");
out.println("</head>");
out.println("<body>");
out.println("<h1>Uspešno dodat hotel</h1>");
out.println("<p>" + successMessage + "</p>");
out.println("</body>");
out.println("</html>");

        }
    } catch (SQLException ex) {
    out.println("SQL greška: " + ex.getMessage());
    ex.printStackTrace(); // Ispisivanje tragova steka
} catch (Exception e) {
    out.println("Opšta greška: " + e.getMessage());
    e.printStackTrace(); // Ispisivanje tragova steka
}
    }
    public static int generateNextHotelId() {
    int nextHotelId = 1; 

    String url = "jdbc:mysql://localhost:3306/hotel2";
    String user = "root";
    String password = "";

    try (Connection connection = DriverManager.getConnection(url, user, password)) {
        String query = "SELECT hotelID FROM hotel;";
        PreparedStatement preparedStatement = connection.prepareStatement(query);

        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            int currentId = resultSet.getInt("hotelID");
            if (currentId >= nextHotelId) {
                
                nextHotelId = currentId + 1;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return nextHotelId;
}


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
