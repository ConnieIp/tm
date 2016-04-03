<%-- 
    Document   : shoppingcart
    Created on : 2016年4月3日, 下午10:25:44
    Author     : samsung-pc
--%>

<%@page import="java.awt.event.ActionEvent"%>
<%@page import="java.awt.event.ActionListener"%>
<%@page import="javax.swing.JButton"%>
<%@page import="java.sql.Connection, javax.sql.DataSource, java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet, java.sql.Statement" %>
<%@page import="java.sql.SQLException, javax.naming.NamingException" %>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/default.css" rel="stylesheet" type="text/css">
        <title>Shopping Cart</title>
    </head>
    <body>
        <h1>Shopping Cart</h1>
        <%
            int userID=Integer.parseInt((String) session.getAttribute("userid"));
            int toyid=Integer.parseInt(request.getParameter("toyid"));
            
            ArrayList<Integer> previousItems=(ArrayList<Integer>)session.getAttribute("previousItems");
            if(previousItems==null){
                previousItems=new ArrayList<Integer>();
                session.setAttribute("previosItems", previousItems);
            }
            if(toyid!=0){
            previousItems.add(toyid);
            session.setAttribute("previousItems",previousItems);
            }
            if (request.getParameter("action")!=null && request.getParameter("action").equals("clearCart")){
                session.setAttribute("previousItems",null);
                previousItems=new ArrayList<Integer>();
                session.setAttribute("previosItems", previousItems);
            }
            
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
            Connection con = ds.getConnection();
            %>
            <table style='width:100%'>
                <thead>
                <th align='left'>ToyID</th>
                <th align='left'>Name</th>
                <th align='left'>Type</th>
                <th align='left'>Age</th>
                <th align='left'>Gender</th>
                <th align='left'>Price</th>
                <th align='left'>Owner</th>
                <th align='left'>Recycle</th>
                </thead>
                <tbody>
            <%
                int totalPrice=0;
            for(int p:previousItems){
                PreparedStatement pstmt_get = con.prepareStatement("SELECT * FROM [ToyMarket] WHERE [ToyID] = ?");
		pstmt_get.setInt(1,p);
		ResultSet rs_get = pstmt_get.executeQuery();
		if (rs_get != null && rs_get.next() != false){
                    String name = rs_get.getString("Name");
                    String type = rs_get.getString("Type");
                    String age = String.valueOf(rs_get.getInt("Age"));
                    String gender = rs_get.getString("Gender");
                    String desc = rs_get.getString("Description");
                    String qty = String.valueOf(rs_get.getInt("Qty"));
                    String cost = rs_get.getString("Cost");
                    float price = rs_get.getFloat("Price");
                    String owner = rs_get.getString("Owner");
                    String recycle = rs_get.getString("Recycle");
                    
                    totalPrice+=price;
                %>
                <tr>
                    <td><%= p %></td>
                    <td><%= name %></td>
                    <td><%= type %></td>
                    <td><%= age %></td>
                    <td><%= gender %></td>
                    <td><%= price %></td>
                    <td><%= owner %></td>
                    <td><%= recycle %></td>
                </tr>
                <%
            }
            }
            %>
            </tbody>
            </table>      
            <p>Total: <%= totalPrice %>
            <form method='POST' action='<%= request.getContextPath() %>/pay.jsp' >
            <input name='action' type='hidden' value='pay' />
            <input name='withdrawal' type='hidden' value='<%= totalPrice %>' />
            <input type='submit' value='Submit' />
            </form>
            <br />
            <form method='POST' action='<%= request.getRequestURI() %>?toyid=<%= toyid %>' >
            <input name='action' type='hidden' value='clearCart' />
            <input type='submit' value='Reset' />
            </form>
            <br/>
            <a href="<%= request.getContextPath() %>/toyinfo.jsp?toyid=<%= toyid %>">Back to Toy Information page</a>
            <%
            
            %>
    </body>
</html>
