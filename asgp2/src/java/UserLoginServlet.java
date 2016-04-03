/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author samsung-pc
 */
public class UserLoginServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Login Page</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Login</h1>");
            
            String name=request.getParameter("name");
            String password=request.getParameter("password");
            String role=request.getParameter("role");
out.println("<p>"+name+password+role+"</p>");
                        String userid = "";
			String userpw = "";
			String usergp = "";
			String gppw ="";
			if (name != null && !name.equalsIgnoreCase("") &&
                password != null && !password.equalsIgnoreCase("") && 
                role != null && !role.equalsIgnoreCase("")){
                                                
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad036_db", "aiad036", "aiad036");
                PreparedStatement pstmt1 = con.prepareStatement("SELECT * FROM [UserIDMap] WHERE [Username] = ? ");
                pstmt1.setString(1, name);
                ResultSet rs1 = pstmt1.executeQuery();
                                if (rs1 != null  && rs1.next() != false){
					userid = rs1.getString("UserID");
                                }
out.println("<p>"+userid+"</p>");                                
                                PreparedStatement pstmt = con.prepareStatement("SELECT * FROM [UserLogin] WHERE [Username] = ? ");
                                pstmt.setString(1, name);
                                ResultSet rs = pstmt.executeQuery();
				if (rs != null  && rs.next() != false){
					userpw = rs.getString("Password");
					usergp = rs.getString("UserGp");
					gppw = rs.getString("GpPassword"); //add a column
                                        
                                        if (role.equalsIgnoreCase("user"))
                                            role="user";
                                        else
                                            role="admin";
					if(userpw.equals(password) && usergp.equals(role)){
                                            HttpSession session=request.getSession();
                                            session.setAttribute("name", name);
                                            session.setAttribute("userid",userid); //
                                            session.setAttribute("role", role);
                                            response.sendRedirect("index.do");                                            
                                        }else{
                                                out.println("<p>Wrong Password/Role!</p>");
                                                out.println("<p><a href='userLogin.do'>Retry</a></p>");
					}       
                                }else{
                                        out.println("<p>Wrong Username!</p>");
                                        out.println("<p><a href='userLogin.do'>Retry</a></p>");
                                            }
                }else{
//        <!--<p><%= name %> <%= password %></p>-->
	out.println("<form action='"+request.getRequestURI()+"' method='POST'> ");
            if(name == null)
                name="";
            if(password==null)
                password="";
//            <!--<form action='index.do' method='POST'>-->
	out.println("<p>User name: <input type='text' name='name' value='"+ name+"'/></p>");
        out.println("<p>Password: <input type='password'  name='password' value='"+password+"'/></p>");
        out.print("<p>Role: <input type='radio' name='role' value='user' checked='checked'/> User ");
        out.println("<input type='radio' name='role' value='manager'/> Manager </p>"); 
        out.println("<p><input type='submit' value='Login' /></p>");
        
        out.println("</form>");
        }
	
            
            out.println("</body>");
            out.println("</html>");
        }catch (ClassNotFoundException ex) {
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally {
            out.close();
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
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
