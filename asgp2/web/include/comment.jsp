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
<%@page import="javax.servlet.http.HttpServlet" %>"
<%@page import="javax.servlet.http.HttpServletRequest" %>"
<%@page import="javax.servlet.http.HttpServletResponse" %>"
<%@page import="javax.servlet.http.HttpSession" %>"
<br /><br />
<hr style="width: 100%" />
<p>Comment
    <%
        int userID=Integer.parseInt((String) session.getAttribute("userid"));
        String userType=(String) session.getAttribute("role");
        //int userID=2; //development later
	//String userType="M"; //develop later
		
        int toyid=Integer.parseInt(request.getParameter("toyid"));       
		
		
	Context initCtx = new InitialContext();
        Context envCtx = (Context)initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
        Connection con = ds.getConnection();
		
		if(userType.equalsIgnoreCase("admin")){
			String reCommentID=request.getParameter("reCommentID");
			String newReply=request.getParameter("newReply");
			if (newReply != null && !newReply.equalsIgnoreCase("Reply here...") && !newReply.equalsIgnoreCase("") &&
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
				%>
					<legend>New reply is sucessfully added. 
                                            <form method='POST' action='<%= request.getContextPath() %>/toyinfo.jsp?toyid=<%= toyid %>' >
                                                <input type='submit' value='Refresh' />
                                            </form>
                                        </legend>
				<%
					}
				}
			}
		}
		else {
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
				%>
					<legend>New comment is sucessfully added.</legend>
				<%
					}
				}
			}
		}
		
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
                <%
                    if(userType.equalsIgnoreCase("admin") || userid.equalsIgnoreCase(String.valueOf(userID))){
                %>
                <td>
                <form method='POST' action='<%= request.getContextPath() %>/deleteComment.jsp?toyid=<%= toyid %>' >
                    <input name='CommentID' type='hidden' value='<%= commentid %>' />
                    <input name='ReplyID' type='hidden' value='/' />
                    <input type='submit' value='Delete' />
                </form>
                </td>
                <%
                    }
                %>
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
                <%
                    if(userType.equalsIgnoreCase("admin")){
                %>
                <td>
                <form method='POST' action='<%= request.getContextPath() %>/deleteComment.jsp?toyid=<%= toyid %>' >
                    <input name='CommentID' type='hidden' value='<%= commentid %>' />
                    <input name='ReplyID' type='hidden' value='<%= replyid %>' />
                    <input type='submit' value='Delete' />
                </form>
                </td>
                <%
                    }
                %>
            </tr>
                <%
                }
			if(userType.equalsIgnoreCase("admin")){
			
        %>
            <tr>
                <td colspan="5">
			<form method='POST' action='<%= request.getContextPath() %>/toyinfo.jsp?toyid=<%= toyid %>' >
			<input name='action' type='hidden' value='newReply' />
			<input name='reCommentID' type='hidden' value=<%= commentid %> />
			<p><input name='newReply' type='text' size='100' maxlength='255' value='Reply here...' /></p>
			<input type='submit' value='Submit' />
			</form>
                </td>
            </tr>
		<%
			}
        }
		
		if (!userType.equalsIgnoreCase("admin")){
		%>
                <tr>
                    <td colspan="5">
			<form method='POST' action='<%= request.getContextPath() %>/toyinfo.jsp?toyid=<%= toyid %>' >
			<input name='action' type='hidden' value='newcomment' />
			<p><input name='newComment' type='text' size='100' maxlength='255' value='Add comment here...' /></p>
			<input type='submit' value='Submit' />
			</form>
                    </td>
                </tr>
		<%
		}
		%>
</p>