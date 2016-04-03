<%-- 
    Document   : deleteComment
    Created on : 2016年3月29日, 下午11:27:53
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.String, java.lang.StringBuffer" %>
<%@page import="javax.naming.Context, javax.naming.InitialContext" %>
<%@page import="java.sql.Connection, javax.sql.DataSource, java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet, java.sql.Statement" %>
<%@page import="java.sql.SQLException, javax.naming.NamingException" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/default.css" rel="stylesheet" type="text/css">
        <title>Toy Information</title>
    </head>
    <body>
        <h1>Delete Comment</h1>
        <div class="formContainer">
        <fieldset>
        <%
        try {
            int toyid=Integer.parseInt(request.getParameter("toyid"));
            String commentID = request.getParameter("CommentID");
            String replyID = request.getParameter("ReplyID");
            String comment = request.getParameter("Comment");
            
            if (comment != null && !comment.equalsIgnoreCase("")) {

                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
                Connection con = ds.getConnection();
                PreparedStatement pstmt;
                if (replyID.equals("/")){
                    pstmt = con.prepareStatement("DELETE FROM [ToyComment] WHERE [ToyID] = ? AND [CommentID] = ?");
                    pstmt.setInt(1,toyid);
                    pstmt.setString(2,commentID);
                }
                else{
                    pstmt = con.prepareStatement("DELETE FROM [ToyReply] WHERE [ToyID] =? AND [CommentID] = ? AND [ReplyID] = ?");
                    pstmt.setInt(1,toyid);
                    pstmt.setString(2,commentID);
                    pstmt.setString(3,replyID);
                }
                    
                int rows = pstmt.executeUpdate();

                if (rows > 0) {
        %>
            <legend>The record is sucessfully deleted.</legend>
            <p>ToyID: <%= toyid %></p>
            <p>CommentID: <%= commentID %></p>
            <p>ReplyID: <%= replyID %></p>
            <p>Comment: <%= comment %></p>
        <%
                }
                else {
        %>
            <legend>ERROR: The record is failed to delete.</legend>
        <%
                }
                if (con != null) {
                    con.close();
                }
            }
            else {
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
                Connection con = ds.getConnection();
                PreparedStatement pstmt;
                if (replyID.equals("/")){
                    pstmt = con.prepareStatement("SELECT * FROM [ToyComment] WHERE [ToyID] = ? AND [CommentID] = ?");
                    pstmt.setInt(1, toyid);
                    pstmt.setString(2, commentID);
                    
                    ResultSet rs = pstmt.executeQuery();
                    while(rs.next()){                    
                    if (toyid < 0) {
                        toyid = rs.getInt("ToyID");
                    }
                    if (commentID == null) {
                        commentID = rs.getString("CommentID");
                    }
                    if (replyID == null) {
                        replyID = "/";
                    }
                    if (comment == null) {
                        comment = rs.getString("Comment");
                    }
                }
                }
                else{
                    pstmt = con.prepareStatement("SELECT * FROM [ToyReply] WHERE [ToyID] = ? AND [CommentID] = ? AND [ReplyID] = ?");
                    pstmt.setInt(1, toyid);
                    pstmt.setString(2, commentID);
                    pstmt.setString(3, replyID);
                    
                    ResultSet rs = pstmt.executeQuery();
                    while(rs.next()){                    
                    if (toyid < 0) {
                        toyid = rs.getInt("ToyID");
                    }
                    if (commentID == null) {
                        commentID = rs.getString("CommentID");
                    }
                    if (replyID == null) {
                        replyID = rs.getString("ReplyID");
                    }
                    if (comment == null) {
                        comment = rs.getString("Reply");
                    }
                }
                    
		
                }

            %>
            <legend>Delete the following comment?</legend>
            <form method='POST' action='<%= request.getRequestURI() %>'>
                <input name='action' type='hidden' value='delete' />
		<input name='toyid' type='hidden' value='<%=toyid %>' />
                <input name='CommentID' type='hidden' value='<%= commentID %>' />
		<input name='ReplyID' type='hidden' value='<%= replyID %>' />
                <input name='Comment' type='hidden' value='<%= comment %>' />
                <p>ToyID: <%= toyid %> </p>
                <p>CommentID: <%= commentID %> </p>
                <p>ReplyID: <%= replyID %></p>
                <p>Comment: <%= comment %></p>
                <input type='submit' value='Delete!' />
            </form>
            <%
            }
            %>
            <br/><a href='<%= request.getContextPath() %>/toyinfo.jsp?toyid=<%= toyid %>'>Back to Toy Information Page</a>
        <%
        }
        catch (NamingException e) {
        %>
            <div style='color: red'><%= e.toString() %></div>
        <%
        } catch (SQLException e) {
        %>
            <div style='color: red'><%= e.toString() %></div>
        <%
        } 
        %>
        </fieldset>
        </div>
    </body>
</html>
