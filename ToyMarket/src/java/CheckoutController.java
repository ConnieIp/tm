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
 * @author PuiWa
 */
public class CheckoutController extends HttpServlet {

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
        String jspPage = "/index.jspx";
        try {
            if (session.getAttribute("cart") != null) {
                //database processing: update toys' qty and add user transaction records
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
                User user = (User)session.getAttribute("User");
                PreparedStatement pstmt_update = con.prepareStatement("UPDATE [ToyMarket] SET [Qty] = ? WHERE [ToyID] = ? ");
                PreparedStatement pstmt_insertTransact = con.prepareStatement("INSERT INTO [UserTransactRecord]([USERID], [CART], [TOTAL]) " + 
                                                                    "VALUES (?, ?, ?)");
                PreparedStatement pstmt_insertRecycle = con.prepareStatement("INSERT INTO [UserRecycleBalance]([USERID], [Balance]) " + 
                                                                    "VALUES (?, ?)");
                PreparedStatement pstmt_updateBalance = con.prepareStatement("UPDATE [UserBalance] SET [Balance] = ? WHERE [UserID] = ? ");
                pstmt_insertRecycle.setString(1, user.getUserId());
                pstmt_insertTransact.setString(1, user.getUserId());
                ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
                String toysID = "";
                HashMap<Toy,Integer> toys = cart.getToys();
                //use toys' ID to store the cart of toys
                Iterator toyIt = toys.entrySet().iterator();
                int i = 0;
                while (toyIt.hasNext()) {
                    //concat Toys' ID
                    Map.Entry pair = (Map.Entry)toyIt.next();
                    Toy aToy = (Toy) pair.getKey();
                    toysID = toysID + aToy.getToyid();
                    if (i+1 < cart.getToys().size()) {
                        toysID = toysID + ",";
                    }

                    //deduct qty in [ToyMarket]
                    int totalQty = ToyMarketLookup.getToy(aToy.getToyid()).getQty();
                    pstmt_update.setInt(1, totalQty-(Integer) pair.getValue());
                    pstmt_update.setInt(2, aToy.getToyid());
                    pstmt_update.executeUpdate();

                    //update owner's balance if the toy is recycled
                    if (aToy.getRecycle().equals("Y")) {
                        float toyRecyclePrice = aToy.getPrice();
                        pstmt_insertRecycle.setString(2, ""+toyRecyclePrice);
                        pstmt_insertRecycle.executeUpdate();
                        //add to owner's balance
                        PreparedStatement pstmt_selectBalance = con.prepareStatement("SELECT * FROM [UserBalance] WHERE [UserID] = ?");
                        String owner=aToy.getOwner();
                        pstmt_selectBalance.setString(1, owner);
                        ResultSet rs_balance = pstmt_selectBalance.executeQuery();
                        if (rs_balance != null && rs_balance.next() != false) {
                            float ownerBalance = rs_balance.getFloat("Balance");
                            pstmt_updateBalance.setFloat(1, ownerBalance+aToy.getPrice());
                            pstmt_updateBalance.setString(2,owner);
                            pstmt_updateBalance.executeUpdate();
                        }
                        if (rs_balance != null){
                            rs_balance.close();
                        }
                        if  (pstmt_selectBalance !=null){
                            pstmt_selectBalance.close();
                        }
                    }
                    
                    i++;
                }
                pstmt_insertTransact.setString(2, toysID);
                pstmt_insertTransact.setDouble(3, cart.getTotal());
                pstmt_insertTransact.executeUpdate(); //insert new record to [UserTransactRecord]

                //get info required for beans printing result
                PreparedStatement pstmt_select = con.prepareStatement("SELECT * FROM [UserTransactRecord] WHERE [USERID] = ?");
                pstmt_select.setString(1, user.getUserId());
                ResultSet rs = pstmt_select.executeQuery();
                String transactID = null, userID = null, recordDate = null;
                while (rs != null && rs.next() != false) {
                    transactID = rs.getString("TransactID");
                    userID = rs.getString("UserID");
                    recordDate = rs.getString("Date");
                }
                if (rs != null) {
                    rs.close();
                }
                Transaction aTransaction = new Transaction();
                aTransaction.setTransactID(transactID);
                aTransaction.setCart(cart);
                aTransaction.setDate(recordDate);
                
                //decrease balance of user
                PreparedStatement pstmt_selectBalance = con.prepareStatement("SELECT * FROM [UserBalance] WHERE [UserID] = ?");
                float usrBalance = -9999999;
                        pstmt_selectBalance.setString(1, user.getUserId());
                        ResultSet rs_balance = pstmt_selectBalance.executeQuery();
                        if (rs_balance != null && rs_balance.next() != false) {
                            usrBalance = rs_balance.getFloat("Balance");
                            pstmt_updateBalance.setDouble(1, usrBalance-cart.getTotal());
                            pstmt_updateBalance.setString(2,user.getUserId());
                            pstmt_updateBalance.executeUpdate();
                        }
                        if (rs_balance != null){
                            rs_balance.close();
                        }
                        if  (pstmt_selectBalance !=null){
                            pstmt_selectBalance.close();
                        }
                request.setAttribute("balance", usrBalance-cart.getTotal());         
                request.setAttribute("aTransaction", aTransaction);

                session.removeAttribute("cart"); //remove cart  after checkout

                if (pstmt_insertTransact != null) {
                    pstmt_insertTransact.close();
                }
                if (pstmt_select != null) {
                    pstmt_select.close();
                }
                if (pstmt_insertRecycle != null) {
                    pstmt_insertTransact.close();
                }
                if (pstmt_updateBalance !=null){
                    pstmt_updateBalance.close();
                }
                if  (pstmt_selectBalance !=null){
                    pstmt_selectBalance.close();
                }
                if (con != null) {
                    con.close();
                }

                jspPage = "/jsp/checkoutSuccess.jsp";
            } else {
                jspPage = "/jsp/checkoutFail.jsp";
            }
            
            RequestDispatcher rd = request.getRequestDispatcher(jspPage);
            rd.forward(request, response);
            
        } catch (NamingException ex) {
            Logger.getLogger(CheckoutController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CheckoutController.class.getName()).log(Level.SEVERE, null, ex);
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
