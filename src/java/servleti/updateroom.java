/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author andri
 */
public class updateroom extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            // Dobijanje parametara iz zahteva
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            int adultsNum = Integer.parseInt(request.getParameter("adultsNum"));
            int childrenNum = Integer.parseInt(request.getParameter("childrenNum"));
            float price = Float.parseFloat(request.getParameter("price"));

            // Konfiguracija za MySQL bazu podataka
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";

            
            con = DriverManager.getConnection(url, user, password);

            // Dobijanje slike iz zahteva
            Part filePart = request.getPart("photo");
            String fileName = extractFileName(filePart);
            InputStream imageInputStream = filePart.getInputStream();

            
            String sql = "UPDATE room SET adultsNum=?, childrenNum=?, price=?, image=? WHERE roomId=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, adultsNum);
            pstmt.setInt(2, childrenNum);
            pstmt.setFloat(3, price);
            pstmt.setBinaryStream(4, imageInputStream);
            pstmt.setInt(5, roomId);

            
            int count = pstmt.executeUpdate();

            if (count > 0) {
                out.println("<meta http-equiv='refresh' content='3;URL=admin.html'>");
                out.println("<h1 style='color:black;'>Uspješno ažurirano!</h1>");
            } else {
                out.println("<h1 style='color:red;'>Ažuriranje nije uspelo.</h1>");
            }

        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(updateroom.class.getName()).log(Level.SEVERE, null, ex);
            out.println("<h1 style='color:red;'>Došlo je do greške prilikom ažuriranja.</h1>");
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(updateroom.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }


private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
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
