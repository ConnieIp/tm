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
            while (rs != null && rs.next() != false) {
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
    
    public static Comment getAComment(int toyid,String commentid) {
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
    
    public static ArrayList<Reply> getReplies(int toyid,String commentid) {
            ArrayList<Reply> replies = new ArrayList<Reply>();
        try{
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
            Connection con = ds.getConnection();
            PreparedStatement pstmt3 = con.prepareStatement("SELECT * FROM [ToyReply] WHERE [ToyID] = ? AND [CommentID] = ?");
            pstmt3.setInt(1, toyid);
            pstmt3.setString(2, commentid);
            ResultSet rs3 = pstmt3.executeQuery();
             while (rs3 != null && rs3.next() != false) {
                String replyid = rs3.getString("ReplyID");
                String mgrid = rs3.getString("MgrID");
                String reply = rs3.getString("Reply");
                
                PreparedStatement pstmt4 = con.prepareStatement("SELECT * FROM [UserIDMap] WHERE [UserID] = ?");
                pstmt4.setString(1, mgrid);
                ResultSet rs4 = pstmt4.executeQuery();
                String mgrname="";
                if (rs4 != null && rs4.next() != false){
                   mgrname = rs4.getString("Username");
                }
                Reply aReply=new Reply();
                aReply.setToyid(toyid);
                aReply.setCommentID(commentid);
                aReply.setReplyID(replyid);
                aReply.setMgrID(mgrid);
                aReply.setMgrname(mgrname);
                aReply.setReply(reply);
                replies.add(aReply);
                if (pstmt4 != null) {
                pstmt4.close();
                }
                if (rs4 != null) {
                rs4.close();
                }
            }
             if (rs3 != null) {
                rs3.close();
            }
             if (pstmt3 != null) {
                pstmt3.close();
            }
            
            if (con != null) {
                con.close();
            }
            } catch (NamingException ex) {
                Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
            }
        return replies;
    }
    public static ArrayList<Reply> getAllReplies(int toyid) {
            ArrayList<Reply> replies = new ArrayList<Reply>();
        try{
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
            Connection con = ds.getConnection();
            PreparedStatement pstmt3 = con.prepareStatement("SELECT * FROM [ToyReply] WHERE [ToyID] = ?");
            pstmt3.setInt(1, toyid);
            ResultSet rs3 = pstmt3.executeQuery();
             while (rs3 != null && rs3.next() != false) {
                String replyid = rs3.getString("ReplyID");
                String mgrid = rs3.getString("MgrID");
                String reply = rs3.getString("Reply");
                String commentid = rs3.getString("CommentID");
                
                PreparedStatement pstmt4 = con.prepareStatement("SELECT * FROM [UserIDMap] WHERE [UserID] = ?");
                pstmt4.setString(1, mgrid);
                ResultSet rs4 = pstmt4.executeQuery();
                String mgrname="";
                if (rs4 != null && rs4.next() != false){
                   mgrname = rs4.getString("Username");
                }
                Reply aReply=new Reply();
                aReply.setToyid(toyid);
                aReply.setCommentID(commentid);
                aReply.setReplyID(replyid);
                aReply.setMgrID(mgrid);
                aReply.setMgrname(mgrname);
                aReply.setReply(reply);
                replies.add(aReply);
                if (pstmt4 != null) {
                pstmt4.close();
                }
                if (rs4 != null) {
                rs4.close();
                }
            }
             if (rs3 != null) {
                rs3.close();
            }
             if (pstmt3 != null) {
                pstmt3.close();
            }
            
            if (con != null) {
                con.close();
            }
            } catch (NamingException ex) {
                Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(CommentLookup.class.getName()).log(Level.SEVERE, null, ex);
            }
        return replies;
    }
    
    public static Reply getAReply(int toyid,String commentid,String replyid){
        Reply aReply=new Reply();;
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
            Connection con = ds.getConnection();
            PreparedStatement pstmt_select = con.prepareStatement("SELECT * FROM [ToyReply] WHERE [ToyID]= ? AND [CommentID] = ? AND [ReplyID] = ? ");
            pstmt_select.setInt(1, toyid);
            pstmt_select.setString(1, commentid);
            pstmt_select.setString(3, replyid);
            ResultSet rs = pstmt_select.executeQuery();
            if (rs != null && rs.next() != false) {
                String mgrid = rs.getString("MgrID");
                String reply = rs.getString("Reply");
                
                PreparedStatement pstmt4 = con.prepareStatement("SELECT * FROM [UserIDMap] WHERE [UserID] = ?");
                pstmt4.setString(1, mgrid);
                ResultSet rs4 = pstmt4.executeQuery();
                String mgrname="";
                if (rs4 != null && rs4.next() != false){
                   mgrname = rs4.getString("Username");
                }
                
                //set reply's attributes
                aReply.setToyid(toyid);
                aReply.setCommentID(commentid);
                aReply.setReplyID(replyid);
                aReply.setMgrID(mgrid);
                aReply.setMgrname(mgrname);
                aReply.setReply(reply);
                if (pstmt4 != null) {
                pstmt4.close();
                }
                if (rs4 != null) {
                rs4.close();
                }
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
        return aReply;
    }
    
}
