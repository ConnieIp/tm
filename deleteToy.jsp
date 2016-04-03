<%-- 
    Document   : deleteToy
    Created on : 2016年4月3日, 上午11:04:42
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
        <title>Manage Toy</title>
    </head>
    <body>
        <h1>Delete Toy</h1>
        <div style='width:600px'>
        <fieldset>
        <%
        try {
            int userID=1; //development later
            String userType="M"; //develop later
		
            int toyid = Integer.parseInt(request.getParameter("toyid"));
			
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
            Connection con = ds.getConnection();
				
			PreparedStatement pstmt = con.prepareStatement("SELECT * FROM [UserIDMap] WHERE [UserID] = ?");
            pstmt.setInt(1, userID);
            ResultSet rs = pstmt.executeQuery();
            String username="";
            while (rs != null && rs.next() != false)
                username = rs.getString("Username");
			
			
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String age = request.getParameter("age");
            String gender = request.getParameter("gender");
            String desc = request.getParameter("desc");
            String qty = request.getParameter("qty");
            String cost = request.getParameter("cost");
            String price = request.getParameter("price");
            String img = request.getParameter("img");
            String owner = request.getParameter("owner");
            String recycle = request.getParameter("recycle");

            if (name != null && !name.equalsIgnoreCase("") &&
                type != null && !type.equalsIgnoreCase("") &&
                qty != null && !qty.equalsIgnoreCase("") &&
                age != null && !age.equalsIgnoreCase("") &&
                gender != null && !gender.equalsIgnoreCase("") &&
                price != null && !price.equalsIgnoreCase("") &&
                recycle != null && !recycle.equalsIgnoreCase("")){
				
                PreparedStatement pstmt_delete = con.prepareStatement("DELETE FROM [ToyMarket] WHERE [ToyID] = ?");
				pstmt_delete.setInt(1, toyid);

                int rows = pstmt_delete.executeUpdate();

                if (rows > 0) {
        %>
            <legend>The toy is sucessfully deleted.</legend>
					<p>ToyID: <%= toyid %></p>
					<p>Name: <%= name %></p>
        <%
                       
                
                }
                else {
        %>
            <legend>ERROR: The toy is failed to delete.</legend>
        <%
                }
                if (con != null) {
                    con.close();
                }
            }
            else {
				PreparedStatement pstmt_get = con.prepareStatement("SELECT * FROM [ToyMarket] WHERE [ToyID] = ? ");
				pstmt_get.setInt(1, toyid);
				ResultSet rs_get = pstmt_get.executeQuery();
				if (rs_get != null && rs_get.next() != false){
					name = rs_get.getString("Name");
                    type = rs_get.getString("Type");
                    age = String.valueOf(rs_get.getInt("Age"));
                    gender = rs_get.getString("Gender");
                    desc = rs_get.getString("Description");
                    qty = String.valueOf(rs_get.getInt("Qty"));
                    cost = rs_get.getString("Cost");
					price = rs_get.getString("Price");
                    img = rs_get.getString("ImagePath");
					owner = rs_get.getString("Owner");
                    recycle = rs_get.getString("Recycle");
                }

            %>
            <legend>Delete the following toy?</legend>
            <form method='POST' action='<%= request.getRequestURI() %>?toyid=<%= toyid %>'>
                <input name='action' type='hidden' value='delete' />
                <p>Name: <%= name %></p>
				<input name='name' type='hidden' value='<%= name %>' />
                <p>Type: <%= type %></p>
				<input name='type' type='hidden' value='<%= type %>' />
				<p>Age: <%= age %></p>
				<input name='age' type='hidden' value='<%= age %>' />
				<p>Gender: <%= gender %></p>
				<input name='gender' type='hidden' value='<%= gender %>' />
				<p>Description: <%= desc %></p>
				<input name='desc' type='hidden' value='<%= desc %>' />
				<p>Qty: <%= qty %></p>
				<input name='qty' type='hidden' value='<%= qty %>' />
				<p>Cost: <%= cost %></p>
				<input name='cost' type='hidden' value='<%= cost %>' />
				<p>Price: <%= price %></p>
				<input name='price' type='hidden' value='<%= price %>' />
                <p>Image Path: <%= img %></p>
				<input name='img' type='hidden' value='<%= img %>' />
				<p><p>Owner: <%=owner%></p>
				<input name='owner' type='hidden' value='<%= owner %>' />
				<p>Recycle (Y/N): <%= recycle %></p>
				<input name='recycle' type='hidden' value='<%= recycle%>' />
                <input type='submit' value='Delete!' />
            </form>
            <%
            }
            %>
            <br/><a href='<%= request.getContextPath() %>'>Back to Toy Directory</a>
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