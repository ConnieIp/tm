<%--
    Document   : pay
    Created on : 2016年4月3日, 下午10:25:44
    Author     : samsung-pc
--%>

<%@page import="java.sql.Connection, javax.sql.DataSource, java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet, java.sql.Statement" %>
<%@page import="java.sql.SQLException, javax.naming.NamingException" %>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="aOrderBean" class="com.shoppingcart.ShoppingCartOrderBean" scope="request" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/default.css" rel="stylesheet" type="text/css">
        <title>Shopping Cart</title>
    </head>
    <body>
        <h1>Pay</h1>
        <%
            int userID=Integer.parseInt((String) session.getAttribute("userid"));
            int toyid=aOrderBean.getToyID();
//            int toyid=Integer.parseInt(request.getParameter("toyid"));    //bug, used beans above to replace this
            int transactionPrice=Integer.parseInt(request.getParameter("withdrawal"));
            if (transactionPrice != 0){
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
                Connection con = ds.getConnection();
                PreparedStatement pstmt_addwithdraw = con.prepareStatement("Insert into [UserBalance] ([UserID] , [Withdrawal], [Deposit], [Date]) values ( ? , ? , ?, current_timestamp)");
		pstmt_addwithdraw.setString(1, String.valueOf(userID));
                pstmt_addwithdraw.setInt(2,transactionPrice);
                pstmt_addwithdraw.setInt(3,0);
                int rows = pstmt_addwithdraw.executeUpdate();
		if (rows > 0) {
		%>
		<p>Transaction is sucessfully completed.</p>
                
		<%
                    for(int p:(ArrayList<Integer>)session.getAttribute("previousItems")){
                        PreparedStatement pstmt_get = con.prepareStatement("SELECT * FROM [ToyMarket] WHERE [ToyID] = ?");
                        pstmt_get.setInt(1,p);
                        ResultSet rs_get = pstmt_get.executeQuery();
                        while (rs_get != null && rs_get.next() != false){
                            String cost = rs_get.getString("Cost");
                            String price = rs_get.getString("Price");
                            String owner = rs_get.getString("Owner");
                            if(owner != null && owner != ""){
//                            if(!owner.equalsIgnoreCase("0") && !owner.equals(null) && !owner.equals("")){ //bug
                                PreparedStatement pstmt_adddep = con.prepareStatement("Insert into [UserBalance] ([UserID] , [Withdrawal], [Deposit], [Date]) values ( ? , ? , ?, current_timestamp)");
                                pstmt_adddep.setString(1, String.valueOf(userID));
                                pstmt_adddep.setInt(2,0);
                                pstmt_adddep.setInt(3,Integer.parseInt(price));
                                int rows_adddep = pstmt_adddep.executeUpdate();
                            }
                        }
                    }
                        session.setAttribute("previousItems",null);
                PreparedStatement pstmt_chkBal = con.prepareStatement("SELECT * FROM [UserBalance] WHERE [UserID] = ?");
		pstmt_chkBal.setString(1, String.valueOf(userID));
		ResultSet rs_chkBal = pstmt_chkBal.executeQuery();
                int balance=0;
                while (rs_chkBal != null && rs_chkBal.next() != false){
                    int withdrawal = rs_chkBal.getInt("Withdrawal");
                    int deposit = rs_chkBal.getInt("Deposit");
                    balance=balance-withdrawal+deposit;
		}
                 
                if (con != null) {
                    con.close();
                }
                %>
                <p>Balance:<%= balance %></p>
                <a href="<%= request.getContextPath() %>/toyinfo.jsp?toyid=<%= toyid %>">Back to Toy Information page</a>
                <%
                }
            }
            %>
    </body>
</html>
