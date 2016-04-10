/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package allClass;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author PuiWa
 */
public class CommentLookup {
    public static ArrayList<Comment> getComments(int toyid) {
        ArrayList<Comment> comments = new ArrayList<Comment>();
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
            Connection con = ds.getConnection();
            PreparedStatement pstmt_select = con.prepareStatement("SELECT * FROM [TOYCOMMENT] WHERE [TOYID] = ?");
            pstmt_select.setInt(1, toyid);
            ResultSet rs = pstmt_select.executeQuery();
            if (rs != null && rs.next() != false) {
                String userID = rs.getString("userID");
                String commentID = rs.getString("CommentID");
                String comment = rs.getString("Comment");
                Date date = rs.getDate("CommentDate");
                //create a comment
                Comment aComment = new Comment();
                aComment.setToyid(toyid);
                aComment.setUserID(userID);
                aComment.setCommentID(commentID);
                aComment.setComment(comment);
                aComment.setDate(date);
                comments.add(aComment); //add the coment to list
            }
            if (rs != null) {
                rs.close();
            }
            if (pstmt_select != null) {
                pstmt_select.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (NamingException ex) {
            Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
        }
        return comments;
    }
    
    public static Comment getAComment(String commentid) {
        Comment aComment = new Comment();
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
            Connection con = ds.getConnection();
            PreparedStatement pstmt_select = con.prepareStatement("SELECT * FROM [TOYCOMMENT] WHERE [CommentID] = ?");
            pstmt_select.setString(1, commentid);
            ResultSet rs = pstmt_select.executeQuery();
            if (rs != null && rs.next() != false) {
                int toyid = Integer.parseInt(rs.getString("ToyID"));
                String userID = rs.getString("UserID");
                String comment = rs.getString("Comment");
                Date date = rs.getDate("CommentDate");
                //set comment's attributes
                aComment.setToyid(toyid);
                aComment.setUserID(userID);
                aComment.setCommentID(commentid);
                aComment.setComment(comment);
                aComment.setDate(date);
            }
        } catch (NamingException ex) {
            Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
        }
        return aComment;
    }
}
