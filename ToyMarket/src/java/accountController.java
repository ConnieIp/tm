/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import allClass.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
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
 * @author samsung-pc
 */
public class accountController extends HttpServlet {

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
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String dispatchPath = "/index.jspx";
        try {
            User user=(User)session.getAttribute("User");
            String action=request.getParameter("action");
            if ("check".equalsIgnoreCase(action)){
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
                
                PreparedStatement pstmt_selectBalance = con.prepareStatement("SELECT * FROM [UserBalance] WHERE [UserID] = ?");
                        float usrBalance=-99999999;
                        pstmt_selectBalance.setString(1, user.getUserId());
                        ResultSet rs_balance = pstmt_selectBalance.executeQuery();
                        if (rs_balance != null && rs_balance.next() != false) {
                            usrBalance = rs_balance.getFloat("Balance");
                        }
                request.setAttribute("balance", usrBalance);
                dispatchPath = "/jsp/checkAccount.jsp";
            }
            else if ("deposit".equalsIgnoreCase(action)){
                String amount=request.getParameter("amount");
                request.setAttribute("amount",amount);
                
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
                
                PreparedStatement pstmt_updateBalance = con.prepareStatement("UPDATE [UserBalance] SET [Balance] = ? WHERE [UserID] = ? ");
                
                PreparedStatement pstmt_selectBalance = con.prepareStatement("SELECT * FROM [UserBalance] WHERE [UserID] = ?");
                
                        pstmt_selectBalance.setString(1, user.getUserId());
                        ResultSet rs_balance = pstmt_selectBalance.executeQuery();
                        if (rs_balance != null && rs_balance.next() != false) {
                            float usrBalance = rs_balance.getFloat("Balance");
                            pstmt_updateBalance.setDouble(1, usrBalance+Float.parseFloat(amount));
                            pstmt_updateBalance.setString(2,user.getUserId());
                            int rows=pstmt_updateBalance.executeUpdate();
                            if (rows > 0){
                                request.setAttribute("balance",usrBalance+Float.parseFloat(amount));
                                dispatchPath = "/jsp/depositSuccess.jsp";
                            }
                            else
                                dispatchPath = "/jsp/depositFail.jsp";
                        }
                        if (rs_balance != null){
                            rs_balance.close();
                        }
                        if  (pstmt_selectBalance !=null){
                            pstmt_selectBalance.close();
                        }
                        if  (pstmt_updateBalance !=null){
                            pstmt_updateBalance.close();
                        }
                        if (con!=null){
                            con.close();
                        }
                
            }
            RequestDispatcher rd = request.getRequestDispatcher(dispatchPath);
            rd.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(accountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(accountController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (NamingException ex) {
            Logger.getLogger(accountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(accountController.class.getName()).log(Level.SEVERE, null, ex);
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
