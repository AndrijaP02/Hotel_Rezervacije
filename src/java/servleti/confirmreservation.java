/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author andri
 */
public class confirmreservation extends HttpServlet {

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
        throws ServletException, IOException, ClassNotFoundException, AddressException, MessagingException {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    try {
        int days;
        boolean flag = false;
        String userName = request.getParameter("username");
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/hotel2";
        String user = "root";
        String password = "";
        Connection con = DriverManager.getConnection(url, user, password);
        Statement stat = con.createStatement();

        ResultSet result = stat.executeQuery("SELECT roomId, DATEDIFF(checkout, checkIn) AS days FROM reservation WHERE username = '" + userName + "' AND confirm != 1;");

        while (result.next()) {
            int roomId = result.getInt("roomId");
            days = Integer.parseInt(result.getString("days"));
            Statement stat2 = con.createStatement();
            ResultSet result2 = stat2.executeQuery("SELECT * FROM client WHERE userName = '" + userName + "';");
            result2.next();
            Float clientBalance = result2.getFloat("balance");

            Statement stat3 = con.createStatement();
            ResultSet result3 = stat3.executeQuery("SELECT * FROM room WHERE roomId = '" + roomId + "'");
            result3.next();
            int roomPrice = result3.getInt("price");

            clientBalance = clientBalance - (days * roomPrice);
            if (clientBalance >= 0) {
                flag = true;
                Statement stat4 = con.createStatement();
                stat4.executeUpdate("UPDATE client SET balance = '" + clientBalance + "' WHERE userName = '" + userName + "'");
                stat4.executeUpdate("UPDATE reservation SET confirm = '1' WHERE username = '" + userName + "' AND roomId = '" + roomId + "'");
                // Ostatak koda za slanje emaila i redirekciju
                // ...
                out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
                out.println("<h1 style='color:black;'>Reservation Confirmed!</h1>");
            } else {
                flag = true;
                out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
                out.println("<h1 style='color:black;'>Client Balance Not Enough!</h1>");
            }
        }
        if (flag == false) {
            out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
            out.println("<h1 style='color:black;'>Reservation Already Confirmed Or Not Existed!</h1>");
        }
    } catch (SQLException ex) {
        out.println(ex);
    }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(confirmreservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(confirmreservation.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(confirmreservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(confirmreservation.class.getName()).log(Level.SEVERE, null, ex);
        }
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
