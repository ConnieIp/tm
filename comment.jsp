<%-- 
    Document   : comment
    Created on : 2016年3月28日, 下午10:42:42
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.String, java.lang.StringBuffer" %>
<%@page import="javax.naming.Context, javax.naming.InitialContext" %>
<%@page import="java.sql.Connection, javax.sql.DataSource, java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet, java.sql.Statement" %>
<%@page import="java.sql.SQLException, javax.naming.NamingException" %>
<br /><br />
<hr style="width: 100%" />
<p>Comment
    <%
        int toyid=Integer.parseInt(request.getParameter("toyid"));        
        Context initCtx = new InitialContext();
        Context envCtx = (Context)initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
        Connection con = ds.getConnection();
        PreparedStatement pstmt = con.prepareStatement("SELECT * FROM [ToyComment] WHERE [ToyID] = ?");
        pstmt.setInt(1, toyid);
        ResultSet rs = pstmt.executeQuery();
        %>
        <div><table style='width:100%'>
        <thead>
        <th align='left'>CommentID</th><th align='left'>Reply ID</th><th align='left'>User name</th><th align='left'>Comment</th><th align='left'>Comment Date</th>
        </thead>
        <tbody>
        
        <%
        while (rs != null && rs.next() != false) {
            String commentid = rs.getString("CommentID");
            String userid = rs.getString("UserID");
            String comment = rs.getString("Comment");
            String commentDate = rs.getString("CommentDate");
            
            PreparedStatement pstmt2 = con.prepareStatement("SELECT * FROM [UserIDMap] WHERE [UserID] = ?");
            pstmt2.setString(1, userid);
            ResultSet rs2 = pstmt2.executeQuery();
            String username="";
            while (rs2 != null && rs2.next() != false)
                username = rs2.getString("Username");
            
        %>
            
            <tr>
                <td><%= commentid%></td>
                <td>/</td>
                <td><%= username %></td>
                <td><%= comment %></td>
                <td><%= commentDate %></td>
            </tr>
        <%
            PreparedStatement pstmt3 = con.prepareStatement("SELECT * FROM [ToyReply] WHERE [CommentID] = ?");
            pstmt3.setString(1, commentid);
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
        %>
            
            <tr>
                <td><%= commentid%></td>
                <td><%= replyid%></td>
                <td><%= mgrname%></td>
                <td><%= reply %></td>
                <td><%= commentDate %></td>
            </tr>
        <%
                }
        }
        
        
    %>
</p>
