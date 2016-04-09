/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import allClass.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.sql.DataSource;
import java.sql.Statement;
import javax.naming.InitialContext;
import javax.naming.Context;
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
public class ManageToy extends HttpServlet {

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
        try {
            HttpSession session=request.getSession();
            String action = request.getParameter("action");
		String jspPage = "/index.jspx";
		if ("create".equals(action)){
			//User user=(User) session.getAttribute("User");
                        //String userName=user.getUserName();
			
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String age = request.getParameter("age");
            String gender = request.getParameter("gender");
            String desc = request.getParameter("desc");
            String qty = request.getParameter("qty");
            String price = request.getParameter("price");
            String img = request.getParameter("img");
            String owner = request.getParameter("owner");
            String recycle = request.getParameter("recycle");
			
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
            Connection con = ds.getConnection();

		PreparedStatement pstmt_insert = con.prepareStatement("INSERT INTO [ToyMarket] ([Name], [Type], [Age], [Gender], "
                        + "[Description], [Qty], [Price], [ImagePath], [Owner], [RecordDate], "
                        + "[Recycle]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, current_timestamp, ?)");
                pstmt_insert.setString(1, name);
		pstmt_insert.setString(2, type);
                pstmt_insert.setInt(3, Integer.parseInt(age));
		pstmt_insert.setString(4, gender);
                pstmt_insert.setString(5, desc);
                pstmt_insert.setInt(6, Integer.parseInt(qty));
		pstmt_insert.setString(7, price);
		pstmt_insert.setString(8, img);
                pstmt_insert.setString(9, owner);
		pstmt_insert.setString(10, recycle);

                int rows = pstmt_insert.executeUpdate();
				Toy toy=null;
                if (rows > 0) {
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT @@IDENTITY AS [@@IDENTITY]");
                    if (rs != null && rs.next() != false) {
			int toyid=rs.getInt("ToyID");
			String recorddate=rs.getString("RecordDate");
                            toy=new Toy(toyid,name,type,Integer.parseInt(age),gender,desc,Integer.parseInt(qty),Float.parseFloat(price),img,
                                    owner,recorddate,recycle);
                    }
			request.setAttribute("Toy", toy);
			jspPage = "/jsp/addToySuccess.jsp";
                        if (stmt != null) {
                            stmt.close();
                        }
                        if (rs != null) {
                            rs.close();
			}
                }
		else{
			request.setAttribute("Toy", toy);
			jspPage = "/jsp/addToyFail.jsp";
		}
		if (pstmt_insert != null) {
			pstmt_insert.close();
		}
		if (con != null) {
			con.close();
		}
		
				
		}
		else if ("update".equals(action)){
			int toyid=Integer.parseInt(request.getParameter("toyid"));
			
			Context initCtx = new InitialContext();
                        Context envCtx = (Context)initCtx.lookup("java:comp/env");
                        DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                        Connection con = ds.getConnection();
			
			Toy toy=ToyMarketLookup.getToy(toyid);
                        
                        String name = request.getParameter("name");
                        String type = request.getParameter("type");
                        String age = request.getParameter("age");
                        String gender = request.getParameter("gender");
                        String desc = request.getParameter("desc");
                        String qty = request.getParameter("qty");
                        String price = request.getParameter("price");
                        String img = request.getParameter("img");
                        String owner = request.getParameter("owner");
                        String recycle = request.getParameter("recycle");
			
                        PreparedStatement pstmt_update = con.prepareStatement("UPDATE [ToyMarket] SET [Name] = ? , [Type] = ? , [Age] = ? ,"
                                + " [Gender] = ? , [Description] = ? , [Qty] = ? , [Price] = ? , [ImagePath] = ? , [Owner] = ? ,"
                                + " [RecordDate] = current_timestamp , [Recycle] = ? WHERE [ToyID] = ? ");
                        pstmt_update.setString(1, name);
                        pstmt_update.setString(2, type);
                        pstmt_update.setInt(3, Integer.parseInt(age));
                        pstmt_update.setString(4, gender);
                        pstmt_update.setString(5, desc);
                        pstmt_update.setInt(6, Integer.parseInt(qty));
                        pstmt_update.setString(7, price);
                        pstmt_update.setString(8, img);
                        pstmt_update.setString(9, owner);
                        pstmt_update.setString(10, recycle);
                        pstmt_update.setInt(11,toyid);
				
			int rows = pstmt_update.executeUpdate();
			if (rows > 0) {
                            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM [ToyMarket] WHERE [ToyID] = ?");
                            pstmt.setInt(1,toyid);
                            ResultSet rs = pstmt.executeQuery();
                            if (rs != null && rs.next() != false) {
                                    toy=new Toy(toyid,name,type,Integer.parseInt(age),gender,desc,Integer.parseInt(qty),Float.parseFloat(price),img,
                                            owner,rs.getString("RecordDate"),recycle);
                            }
                                request.setAttribute("Toy", toy);
                                jspPage = "/jsp/updateToySuccess.jsp";
                                if (pstmt != null) {
                                    pstmt.close();
                                }
                                if (rs != null) {
                                    rs.close();
                                }
				
			}
			else{
				request.setAttribute("Toy", toy);
				jspPage = "/jsp/updateToyFail.jsp";
			}
			
			if (pstmt_update != null) {
				pstmt_update.close();
			}
			if (con != null) {
				con.close();
			}
		}
		else if ("delete".equals(action)){
		
		}
		RequestDispatcher rd = request.getRequestDispatcher(jspPage);
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
            Logger.getLogger(ManageToy.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ManageToy.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ManageToy.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ManageToy.class.getName()).log(Level.SEVERE, null, ex);
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
