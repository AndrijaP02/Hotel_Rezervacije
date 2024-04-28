/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

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
public class signup extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/hotel2";
            String user = "root";
            String password = "";
            Connection conn = null;

            conn = (Connection) DriverManager.getConnection(url, user, password);

            String fName = request.getParameter("fName");
            String lName = request.getParameter("lName");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            int balance = 10000;
            String rawPassword = request.getParameter("password");
            String hashedPassword = hashPassword(rawPassword);

            String query = "INSERT INTO client (userName, fname , lname , balance , email , password , phone) VALUES ('"
                    + username + "','" + fName + "','" + lName + "', '" + balance + "','" + email + "','" + hashedPassword
                    + "','" + phone + "')";
            Statement st = (Statement) conn.createStatement();
            st.executeUpdate(query);
            
            String successMessage = "Uspešno ste se registrovali. Bićete preusmereni na stranicu za prijavu za 3 sekunde.";


out.println("<html>");
out.println("<head>");
out.println("<title>Registracija uspešna</title>");
out.println("</head>");
out.println("<body>");
out.println("<h1>Registracija uspešna</h1>");
out.println("<p>" + successMessage + "</p>");
out.println("</body>");
out.println("</html>");


out.println("<script type=\"text/javascript\">");
out.println("setTimeout(function () {");
out.println("    window.location.href = \"Login.html\";"); 
out.println("}, 3000);"); 
out.println("</script>");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(signup.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashInBytes = md.digest(password.getBytes("UTF-8"));

            // Konvertuj bajtove u heksadecimalni format
            StringBuilder sb = new StringBuilder();
            for (byte b : hashInBytes) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
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
