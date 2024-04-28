/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.ByteArrayOutputStream;
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
public class addroom extends HttpServlet {

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
        throws ServletException, IOException, ClassNotFoundException, SQLException {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    try {
        int hotelId = Integer.parseInt(request.getParameter("hotelId"));
        int adultsNum = Integer.parseInt(request.getParameter("adultsNum"));
        int childrenNum = Integer.parseInt(request.getParameter("childrenNum"));
        float price = Float.parseFloat(request.getParameter("price"));
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/hotel2";
        String user = "root";
        String password = "";
        Connection con = DriverManager.getConnection(url, user, password);
        PreparedStatement pstmt = null;

        
        Part filePart = request.getPart("photo");

        
        InputStream fileContent = filePart.getInputStream();
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[8192];
        int bytesRead;
        while ((bytesRead = fileContent.read(buffer)) != -1) {
            byteArrayOutputStream.write(buffer, 0, bytesRead);
        }

       
        byte[] imageBytes = byteArrayOutputStream.toByteArray();

        
        pstmt = con.prepareStatement("INSERT INTO room (adultsNum, childrenNum, hotelId, price, image) VALUES (?, ?, ?, ?, ?);");
        pstmt.setInt(1, adultsNum);
        pstmt.setInt(2, childrenNum);
        pstmt.setInt(3, hotelId);
        pstmt.setFloat(4, price);
        pstmt.setBytes(5, imageBytes);
        
        int count = pstmt.executeUpdate();

        if (count > 0) {
            out.println("<meta http-equiv='refresh' content='3;URL=index.jsp'>");
            out.println("<h1 style='color:black;'>Done!</h1>");
        }
    } catch (SQLException ex) {
    out.println("SQL greška: " + ex.getMessage());
    ex.printStackTrace(); // Ispisivanje tragova steka
} catch (IOException ioex) {
    out.println("I/O greška: " + ioex.getMessage());
    ioex.printStackTrace(); // Ispisivanje tragova steka
} catch (Exception e) {
    out.println("Opšta greška: " + e.getMessage());
    e.printStackTrace(); // Ispisivanje tragova steka
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
            Logger.getLogger(addroom.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(addroom.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(addroom.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(addroom.class.getName()).log(Level.SEVERE, null, ex);
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
