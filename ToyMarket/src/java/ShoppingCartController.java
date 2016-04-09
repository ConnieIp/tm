/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import allClass.ShoppingCart;
import allClass.Toy;
import allClass.ToyMarketLookup;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PuiWa
 */
public class ShoppingCartController extends HttpServlet {

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
        RequestDispatcher rd = null;
        try {
            String action = request.getParameter("action");
            String dispatchPath = "/index.jspx";
            if ("add".equals(action)) {
                int toyid = Integer.parseInt(request.getParameter("toyid"));
                Toy newToy = ToyMarketLookup.getToy(toyid);
                request.setAttribute("newToy", newToy);
                ShoppingCart cart;
                if (session.getAttribute("cart") != null) {
                    cart = (ShoppingCart)session.getAttribute("cart");
                } else {
                    cart = new ShoppingCart();
                }
                //add toy to cart
                HashMap<Toy,Integer> toys = cart.getToys();
                toys.put(newToy, 1); //the qty selected may be changed later
                cart.setToys(toys);
                //add price to total
                cart.setTotal(cart.getTotal()+newToy.getPrice());
                //add num of Items to numOfItems
                cart.setNumOfItems(cart.getNumberOfItems()+1); //may change num to be flexible later
                session.setAttribute("cart", cart);
                
                dispatchPath = "/jsp/shoppingCart.jsp";
                rd = request.getRequestDispatcher(dispatchPath);
            } else if ("checkout".equals(action)) {
                ServletContext context= getServletContext();
                dispatchPath = "/checkout";
                rd = context.getRequestDispatcher(dispatchPath);
            }
            rd.forward(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(SimpleController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SimpleController.class.getName()).log(Level.SEVERE, null, ex);
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
