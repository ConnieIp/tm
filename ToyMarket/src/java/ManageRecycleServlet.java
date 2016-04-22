/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import allClass.Toy;
import allClass.ToyMarketLookup;
import allClass.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class ManageRecycleServlet extends HttpServlet {

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
        String dispatchPath = "controller?action=browse&amp;category=all";
        try {
            String action = request.getParameter("action");
            if (aUser.getUserRole().equals("admin")) {
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
                PreparedStatement pstmt_select = con.prepareStatement("SELECT * FROM [TOYMARKET] WHERE [RECYCLE] IS NULL");
                ResultSet rs = pstmt_select.executeQuery();
                ArrayList<Toy> toysAppliedRecycle = new ArrayList<Toy>();
                while (rs !=null && rs.next() != false) {
                    int toyid = rs.getInt("toyid");
                    Toy aToy = ToyMarketLookup.getToy(toyid);
                    toysAppliedRecycle.add(aToy);
                }
                if ("browse".equals(action)) {
                    request.setAttribute("toysAppliedRecycle", toysAppliedRecycle);
                    dispatchPath = "/jsp/manageToyRecycle.jsp";
                } else {
                    PreparedStatement pstmt_update_application = con.prepareStatement("UPDATE [TOYRECYCLEAPPLICATION] SET [APPROVAL] = ?,"+
                                                                                        " [ApprovedBy] = ? WHERE [TOYID] = ?");
                    PreparedStatement pstmt_update_toymart = con.prepareStatement("UPDATE [TOYMARKET] SET [RECYCLE] = ? WHERE [TOYID] = ?");
                    for (Toy aToy: toysAppliedRecycle) {
                        String recycle_status = request.getParameter(""+aToy.getToyid());
                        if ("".equals(recycle_status)) {
                            recycle_status = "NULL";
                        }
                        //update [TOYRECYCLEAPPLICATION] for toy recycle record
                        pstmt_update_application.setString(1, recycle_status);
                        pstmt_update_application.setString(2, aUser.getUserId());
                        pstmt_update_application.setInt(3, aToy.getToyid());
                        pstmt_update_application.executeUpdate();
                        pstmt_update_toymart.setString(1, recycle_status);
                        pstmt_update_toymart.setInt(2, aToy.getToyid());
                        pstmt_update_toymart.executeUpdate();
                    }
                    if (pstmt_update_application != null) {
                        pstmt_update_application.close();
                    }
                    if (pstmt_update_toymart != null) {
                        pstmt_update_toymart.close();
                    }
                }
                if (pstmt_select != null) {
                    pstmt_select.close();
                }
                if (con != null) {
                    con.close();
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher(dispatchPath);
            rd.forward(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(ManageRecycleServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ManageRecycleServlet.class.getName()).log(Level.SEVERE, null, ex);
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
