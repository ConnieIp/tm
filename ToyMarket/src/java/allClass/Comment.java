/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package allClass;

import java.sql.Date;

/**
 *
 * @author PuiWa
 */
public class Comment {
    private int toyid;
    private String commentID;
    private String userID;
    private String comment;
    private Date date;

    public Comment() {
        toyid = 0;
        comment = null;
        userID = null;
        comment = null;
        date = null;
    }

    public int getToyid() {
        return toyid;
    }

    public void setToyid(int toyid) {
        this.toyid = toyid;
    }

    public String getCommentID() {
        return commentID;
    }

    public void setCommentID(String commentID) {
        this.commentID = commentID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
