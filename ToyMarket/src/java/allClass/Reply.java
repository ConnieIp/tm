/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package allClass;


public class Reply {
    private int toyid;
    private String commentID;
    private String replyID;
    private String reply;
    private String mgrID;
    private String mgrname;

    public Reply() {
        toyid = 0;
        commentID = null;
        replyID = null;
        reply = null;
        mgrID = null;
        mgrname = null;
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

    public String getReplyID() {
        return replyID;
    }

    public void setReplyID(String replyID) {
        this.replyID = replyID;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getMgrID() {
        return mgrID;
    }

    public void setMgrID(String mgrID) {
        this.mgrID = mgrID;
    }
    
    public String getMgrname() {
        return mgrID;
    }

    public void setMgrname(String mgrIname) {
        this.mgrname = mgrname;
    }
}
