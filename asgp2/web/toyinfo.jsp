<%-- 
    Document   : toyinfo
    Created on : 2016年3月28日, 下午10:13:48
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.String, java.lang.StringBuffer" %>
<%@page import="javax.naming.Context, javax.naming.InitialContext" %>
<%@page import="java.sql.Connection, javax.sql.DataSource, java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet, java.sql.Statement" %>
<%@page import="java.sql.SQLException, javax.naming.NamingException" %>
<jsp:useBean id="aOrderBean" class="com.shoppingcart.ShoppingCartOrderBean" scope="request" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/default.css" rel="stylesheet" type="text/css">
        <title>Toy information</title>
    </head>
    <body>
        <h1>Toy Information</h1>
        <div class="formContainer">
        <fieldset>
        <%
            int toyid = 0;
            if (request.getParameter("toyid")==null) {
                toyid=aOrderBean.getToyID();
            } else {
                toyid=Integer.parseInt(request.getParameter("toyid"));
            }
            
        try {
	    
            String name="";
            String type="";
            String age="";
            String gender="";
            String description="";
            String qty="";
            String cost="";
            String price="";
            String owner="";
            String comment="";

                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
                Connection con = ds.getConnection();
                PreparedStatement pstmt = con.prepareStatement("SELECT * FROM [ToyMarket] WHERE [ToyID] = ?");
                pstmt.setInt(1, toyid);
                ResultSet rs = pstmt.executeQuery();
				
		while(rs.next()){
                    name = rs.getString("name");
                    type=rs.getString("Type");
                    age=rs.getString("Age");
                    gender=rs.getString("Gender");
                    description=rs.getString("Description");
                    qty=rs.getString("Qty");
                    cost=rs.getString("cost");
                    price=rs.getString("price");
                    owner=rs.getString("Owner");
                }
                 
                if (con != null) {
                    con.close();
                }
            %>
            <legend><%= name %>'s Information</legend>
                <p>Name: <%= name %></p>
                <p>Type: <%= type %></p>
                <p>Age: <%= age %></p>
                <p>Gender: <%= gender %></p>
                <p>Description: <%= description %></p>
                <p>Qty: <%= qty %></p>
                <p>Price: <%= price %></p>
                <p>Owner: <%= owner %></p>
                <br/><a href='<%= request.getContextPath() %>/shoppingcart.jsp?toyid=<%=toyid %>'>Add to cart</a>
            
                <a href="<%= request.getContextPath() %>/browse.jsp">Back to Toy Information page</a>
                <!--<br/><a href='javascript:history.back(1)'>Back to Toy Directory</a> <!--wrong rediect after add to cart-->
            
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
        <jsp:include page="include/comment.jsp?toyid=<%=toyid%>" />
    </body>
</html>
