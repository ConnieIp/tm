/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import allClass.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author PuiWa
 */
public class ApplyRecycleServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        User aUser = (User) session.getAttribute("User");
        String dispatchPath = "index.jspx";
        try {
            if (aUser.getUserRole().equals("user")) {
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
                //insert new record to [ToyMarket]
                PreparedStatement pstmt_insertToyMkt = con.prepareStatement("INSERT INTO [TOYMARKET]([NAME],[TYPE],[AGE],[GENDER],"+
                                                                            "[DESCRIPTION],[QTY],[PRICE],[OWNER],[RECYCLE])"+
                                                                            " VALUES (?,?,?,?,?,?,?,?,?)");
                String name = request.getParameter("name");
                String type = request.getParameter("type");
                String age = request.getParameter("age");
                String gender = request.getParameter("gender");
                String desc = request.getParameter("desc");
                String qty = request.getParameter("qty");
                String price = request.getParameter("price");
                pstmt_insertToyMkt.setString(1, name);
                pstmt_insertToyMkt.setString(2, type);
                pstmt_insertToyMkt.setString(3, age);
                pstmt_insertToyMkt.setString(4, gender);
                pstmt_insertToyMkt.setString(5, desc);
                pstmt_insertToyMkt.setString(6, qty);
                pstmt_insertToyMkt.setString(7, price);
                pstmt_insertToyMkt.setString(8, aUser.getUserId());
                pstmt_insertToyMkt.setNull(9, java.sql.Types.CHAR); //"Y": for recycle, "N":not for recycle, "NULL":not yet processed, "R": rejected recycle

                pstmt_insertToyMkt.executeUpdate();

                //insert new record to [ToyRecycleApplication]
                PreparedStatement pstmt_insertToyRecycle = con.prepareStatement("INSERT INTO [TOYRECYCLEAPPLICATION]([TOYID]) VALUES (?)");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT @@IDENTITY AS [@@IDENTITY]");
                if (rs != null && rs.next() != false) {
                    pstmt_insertToyRecycle.setInt(1, rs.getInt(1));
                }
                pstmt_insertToyRecycle.executeUpdate();

                if (pstmt_insertToyMkt != null) {
                    pstmt_insertToyMkt.close();
                }
                if (pstmt_insertToyRecycle != null) {
                    pstmt_insertToyRecycle.close();
                }
                if (con != null) {
                    con.close();
                }
                dispatchPath = "/jsp/recycleSuccess.jsp";
                request.setAttribute("recycleToyName", name);
            }
            RequestDispatcher rd = request.getRequestDispatcher(dispatchPath);
            rd.forward(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(ApplyRecycleServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyRecycleServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
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
