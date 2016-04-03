<%--
    Document   : browse
    Created on : 2016年3月28日, 下午03:00:49
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
    <title>Browse toy</title>
    </head>
    <body>
        <h1>Browse Toy</h1>
        <div style='width:600px'>
        <fieldset>
        <legend>Toy Directoy</legend>
        <%
		
        try {
			int userid=1; //develop later
			String userType="M";//develop later
			
			//HttpSession session=request.getSession();
		
			//if(session.getAttribute("logined") == null){
			//	userType="O";
			//}
			
			//isUserInRole?
			
            String category=request.getParameter("category");
            if (category == null || category.equalsIgnoreCase("") ) {
                category="all";
            }
         %>
            <tr>
                <td><a href='<%= request.getContextPath() %>/browse.jsp?category=all'>All</a></td>
                <td><a href='<%= request.getContextPath() %>/browse.jsp?category=girl'>girl</a></td>
                <td><a href='<%= request.getContextPath() %>/browse.jsp?category=boy'>boy</a></td>
                <td><a href='<%= request.getContextPath() %>/browse.jsp?category=baby'>baby</a></td>
                <td><a href='<%= request.getContextPath() %>/browse.jsp?category=child'>child</a></td>
            </tr>
            <p>Category: <%= category %></p>
        <%
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
            Connection con = ds.getConnection();
            
            Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs;
            
            if (category.equalsIgnoreCase("girl")){
                rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE [Gender] IN ('F','B') ORDER BY [ToyID] ASC");
            }
            else if (category.equalsIgnoreCase("boy")){
                rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE [Gender] IN ('M','B') ORDER BY [ToyID] ASC");
            }
            else if (category.equalsIgnoreCase("child")){
                rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE [Age] > 3 OR [Age] = 0 ORDER BY [ToyID] ASC");
            }
            else if (category.equalsIgnoreCase("baby")){
                rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE [Age] BETWEEN 0 AND 3 OR [AGE] = 0 ORDER BY [ToyID] ASC");
            }
            else{
                rs = stmt.executeQuery("SELECT * FROM [ToyMarket] ORDER BY [ToyID] ASC");
            }
            if (rs != null && rs.last() != false) {
            
        %>
        <p>Total <%= rs.getRow() %> entries.</p>
        <%
                rs.beforeFirst();
            }
        %>
        <div><table style='width:100%'>
        <thead>
        <th align='left'>ToyID</th><th align='left'>Name</th><th align='left'>Type</th><th align='left'>Qty</th><th align='left'>Toy Price</th><th align='left'>Action</th>
        </thead>
        <tbody>
        <%
            while (rs != null && rs.next() != false) {
                String name = rs.getString("Name");
                String type = rs.getString("Type");
                String qty = rs.getString("Qty");
                String cost = rs.getString("Price");
                String toyid = rs.getString("ToyID");
        %>
            <tr>
                <td><%= toyid %></td>
                <td><a href='<%= request.getContextPath() %>/toyinfo.jsp?toyid=<%= toyid %>'><%= name %></a></td>
                <td><%= type %></td>
                <td><%= qty %></td>
                <td><%= cost %></td>
		<%
				if(userType.equalsIgnoreCase("M")){
		%>
                <td>
                    <a href='<%= request.getContextPath() %>/updateToy.jsp?toyid=<%= toyid %>'>Update</a>
                    <a href='<%= request.getContextPath() %>/deleteToy.jsp?toyid=<%= toyid %>'>Delete</a>
                </td>
        <%
				}
            }
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        %>
			</tr>
        </tbody>
        </table></div>
        <br/><a href='<%= request.getContextPath() %>/addToy.jsp'>Add a New Toy</a>
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
</html></html>