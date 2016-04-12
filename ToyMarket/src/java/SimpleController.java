import allClass.*;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author samsung-pc
 */
public class SimpleController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String action = request.getParameter("action");
		String jspPage = "/index.jspx";
		//browse
                if ("browse".equals(action)){
			String category=request.getParameter("category");
                        //default category
                        if (category == null || category.equalsIgnoreCase("") ) {
                            category="all";
                        } 
			request.setAttribute("Category", category);
                        //get all the toys in the selected category in ToyMarket
			ArrayList<Toy> toys = ToyMarketLookup.getToys(category);        
			
			request.setAttribute("ToyMarket", toys);
			
			jspPage="/jsp/browse.jsp";
		}
                //toyinfo
		else if ("toyInfo".equals(action)) {
			int toyid=Integer.parseInt(request.getParameter("toyid"));
			Toy toy=ToyMarketLookup.getToy(toyid);
                        ArrayList<Comment> comments = CommentLookup.getComments(toyid);
			request.setAttribute("Toy", toy);
                        request.setAttribute("comments", comments);
			jspPage = "/jsp/toyInfo.jsp";
		}
                //update toy
		else if ("updateToy".equals(action)) {
			int toyid=Integer.parseInt(request.getParameter("toyid"));
			Toy toy=ToyMarketLookup.getToy(toyid);
			request.setAttribute("Toy", toy);
			jspPage = "/jsp/updateToy.jsp";
		}
                //delete toy
		else if ("deleteToy".equals(action)) {
			int toyid=Integer.parseInt(request.getParameter("toyid"));
			Toy toy=ToyMarketLookup.getToy(toyid);
			request.setAttribute("Toy", toy);
			jspPage = "/jsp/deleteToy.jsp";
		}
                //add toy
		else if ("addToy".equals(action)) {
			jspPage = "/jsp/addToy.jsp";
		} //recycle toy
		else if ("recycleToy".equals(action)) {
			jspPage = "/jsp/recycleToy.jsp";
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(jspPage);
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
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(SimpleController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SimpleController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SimpleController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SimpleController.class.getName()).log(Level.SEVERE, null, ex);
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
