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
public class CommentController extends HttpServlet {

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
        String jspPage="/jsp/toyinfo.jsp";
        RequestDispatcher rd = null;
        try {
            int userID=Integer.parseInt((String) session.getAttribute("userid"));
            String userType=(String) session.getAttribute("role");
            
            String action=request.getParameter("action");
            int toyid=Integer.parseInt(request.getParameter("toyid"));       
		
            if("addComment".equalsIgnoreCase(action)){
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
		
			
			String newComment=request.getParameter("newComment");
			if (newComment != null && !newComment.equalsIgnoreCase("Add comment here...") && !newComment.equalsIgnoreCase("") ){
				
				PreparedStatement pstmt_chkRow = con.prepareStatement("SELECT COUNT([CommentID]) AS [CommentCount] FROM [ToyComment] WHERE [ToyID] = ?");
				pstmt_chkRow.setInt(1, toyid);
				ResultSet rs_chkRow = pstmt_chkRow.executeQuery();
				int commentCount=0;
				if (rs_chkRow != null && rs_chkRow.next() != false){
					commentCount = rs_chkRow.getInt("CommentCount");
				}
				
				if(newComment != null && !newComment.equalsIgnoreCase("")){
					PreparedStatement pstmt_add = con.prepareStatement("insert into [ToyComment] ([ToyID] , [CommentID], [UserID], [Comment], [CommentDate]) values ( ? , ? , ?, ?, current_timestamp)");
					pstmt_add.setInt(1, toyid);
					pstmt_add.setString(2, String.valueOf(commentCount+1));
					pstmt_add.setString(3, String.valueOf(userID));
					pstmt_add.setString(4, newComment);
					int rows = pstmt_add.executeUpdate();
					if (rows > 0) {
                                            request.setAttribute("Comment", CommentLookup.getAComment(toyid,String.valueOf(commentCount+1)));
                                            jspPage="/jsp/addCommentSuccess.jsp";
                                        }
                                        else{
                                            request.setAttribute("Comment", CommentLookup.getAComment(toyid, String.valueOf(commentCount+1)));
                                            jspPage="/jsp/addCommentFail.jsp";
                                        }
                                    if (pstmt_add !=null){
                                        pstmt_add.close();
                                    }
                                    if (con != null) {
                                        con.close();
                                    }
                                }
                                
                        }
            }
            else if ("addReply".equalsIgnoreCase(action)){
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
		
			String reCommentID=request.getParameter("reCommentID");
			String newReply=request.getParameter("newReply");
			if (newReply != null && !newReply.equalsIgnoreCase("Add reply here...") && !newReply.equalsIgnoreCase("") &&
					reCommentID != null && !reCommentID.equalsIgnoreCase("")){
			
				PreparedStatement pstmt_chkRow = con.prepareStatement("SELECT COUNT([ReplyID]) AS [ReplyCount] FROM [ToyReply] WHERE [ToyID] = ? and [CommentID] = ?");
				pstmt_chkRow.setInt(1, toyid);
				pstmt_chkRow.setString(2, reCommentID);
				ResultSet rs_chkRow = pstmt_chkRow.executeQuery();
				int replyCount=0;
				if (rs_chkRow != null && rs_chkRow.next() != false){
					replyCount = rs_chkRow.getInt("ReplyCount");
				}
				
				if(newReply != null && !newReply.equalsIgnoreCase("")){
					PreparedStatement pstmt_add = con.prepareStatement("insert into [ToyReply] ([ToyID] , [CommentID], [ReplyID], [Reply], [MgrID]) values ( ? , ? , ?, ?, ?)");
					pstmt_add.setInt(1, toyid);
					pstmt_add.setString(2, reCommentID);
					pstmt_add.setString(3, String.valueOf(replyCount+1));
					pstmt_add.setString(4, newReply);
					pstmt_add.setInt(5, userID);
					int rows = pstmt_add.executeUpdate();
					if (rows > 0) {
                                            request.setAttribute("Reply", CommentLookup.getAReply(toyid, reCommentID, String.valueOf(replyCount+1)));
                                            jspPage="/jsp/addReplySuccess.jsp";
                                        }
                                        else{
                                            request.setAttribute("Reply", CommentLookup.getAReply(toyid, reCommentID, String.valueOf(replyCount+1)));
                                            jspPage="/jsp/addReplyFail.jsp";
                                        }
                                        if (pstmt_add !=null){
                                        pstmt_add.close();
                                        }
                                        if (con != null) {
                                            con.close();
                                        }
                                }
                        }
            }else if ("delComment".equalsIgnoreCase(action)){
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
		
			String commentID=request.getParameter("CommentID");
                        
                        Comment comment=CommentLookup.getAComment(toyid, commentID);
                        PreparedStatement pstmt_delreply;
                        pstmt_delreply = con.prepareStatement("DELETE FROM [ToyReply] WHERE [ToyID] =? AND [CommentID] = ?");
                        pstmt_delreply.setInt(1,toyid);
                        pstmt_delreply.setString(2,commentID);
                        int rows_delreply = pstmt_delreply.executeUpdate();
                        
                        PreparedStatement pstmt;
                        pstmt = con.prepareStatement("DELETE FROM [ToyComment] WHERE [ToyID] = ? AND [CommentID] = ?");
                        pstmt.setInt(1,toyid);
                        pstmt.setString(2,commentID);
                        int rows = pstmt.executeUpdate();

                        if (rows > 0) {
                            
                            request.setAttribute("Comment",comment);
                            jspPage="/jsp/delCommentSuccess.jsp";
                        }
                        else{
                            request.setAttribute("Comment",comment);                      
                            jspPage="/jsp/delCommentFail.jsp";
                        }
                        if (pstmt_delreply !=null){
                           pstmt_delreply.close();
                        }
                        if (pstmt !=null){
                           pstmt.close();
                        }
                        if (con != null) {
                            con.close();
                        }
            }else if ("delReply".equalsIgnoreCase(action)){
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
                Connection con = ds.getConnection();
		
			String commentID=request.getParameter("CommentID");
			String replyID=request.getParameter("ReplyID");
                        
                        Reply reply=CommentLookup.getAReply(toyid, commentID, replyID);
                        PreparedStatement pstmt;
                        pstmt = con.prepareStatement("DELETE FROM [ToyReply] WHERE [ToyID] =? AND [CommentID] = ? AND [ReplyID] = ?");
                        pstmt.setInt(1,toyid);
                        pstmt.setString(2,commentID);
                        pstmt.setString(3,replyID);
                        int rows = pstmt.executeUpdate();

                        if (rows > 0) {
                            request.setAttribute("Reply",reply);
                            jspPage="/jsp/delReplySuccess.jsp";
                        }
                        else{
                            request.setAttribute("Reply",reply);
                            jspPage="/jsp/delReplyFail.jsp";
                        }
                        if (pstmt !=null){
                           pstmt.close();
                        }
                        if (con != null) {
                            con.close();
                        }
            }
            rd = request.getRequestDispatcher(jspPage);
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
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
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
