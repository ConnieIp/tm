<%-- 
    Document   : addToy
    Created on : 2016年3月30日, 上午12:15:46
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
        <title>Add Toy</title>
    </head>
    <body>
        <h1>Add Toy</h1>
        <div style='width:600px'>
        <fieldset>
        <%
        try {
            int userID=Integer.parseInt((String) session.getAttribute("userid"));
            String userType=(String) session.getAttribute("role");
            //int userID=1; //development later
            //String userType="M"; //develop later
		
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

                PreparedStatement pstmt_chkRow = con.prepareStatement("SELECT COUNT([ToyID]) AS [ToyCount] FROM [ToyMarket]");
				ResultSet rs_chkRow = pstmt_chkRow.executeQuery();
				int toyCount=0;
				if (rs_chkRow != null && rs_chkRow.next() != false){
					toyCount = Integer.parseInt(rs_chkRow.getString("ToyCount"));
				}
				
                PreparedStatement pstmt_insert = con.prepareStatement("INSERT INTO [ToyMarket] ([Name], [Type], [Age], [Gender], [Description], [Qty], [Cost], [Price], [ImagePath], [Owner], [RecordDate], [Recycle]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, current_timestamp, ?)");
                //pstmt_insert.setInt(1, toyCount+1);
                pstmt_insert.setString(1, name);
		pstmt_insert.setString(2, type);
                pstmt_insert.setInt(3, Integer.parseInt(age));
		pstmt_insert.setString(4, gender);
                pstmt_insert.setString(5, desc);
                pstmt_insert.setInt(6, Integer.parseInt(qty));
                pstmt_insert.setString(7, cost);
		pstmt_insert.setString(8, price);
		pstmt_insert.setString(9, img);
                pstmt_insert.setString(10, owner);
		pstmt_insert.setString(11, recycle);

                int rows = pstmt_insert.executeUpdate();
                int toyid=0;
                if (rows > 0) {
        %>
            <legend>New toy is sucessfully added.</legend>
        <%
                    PreparedStatement pstmt_chkAdd = con.prepareStatement("SELECT * from [ToyMarket] WHERE [ToyID] = ?");
                    pstmt_chkAdd.setInt(1, toyCount+1);
                    ResultSet rs_chkAdd = pstmt_chkAdd.executeQuery();
                    if (rs_chkAdd != null && rs_chkAdd.next() != false) {
                        toyid=rs_chkAdd.getInt("ToyID");
        %>
            <p>ToyID: <%= toyid %></p>
        <%
                       rs_chkAdd.close();
                    }
        %>
            <p>Name: <%= name %></p>
        <%
                    if (pstmt_chkAdd != null) {
                        pstmt_chkAdd.close();
                    }
                    if (recycle.equalsIgnoreCase("Y")){
                    PreparedStatement pstmt_approved = con.prepareStatement("INSERT INTO [ToyRecycle] ([ToyID],[Approved]) VALUES (?, ?)");
                    pstmt_approved.setInt(1, toyid);
                    pstmt_approved.setString(2, "N");
                    int rows1 = pstmt_approved.executeUpdate();
                    }
                }
                else {
        %>
            <legend>ERROR: New toy is failed to add.</legend>
        <%
                }
                if (con != null) {
                    con.close();
                }
            }
            else {
                if (name == null) {
                    name = "";
                }
                if (type == null) {
                    type = "";
                }
		if (age == null) {
                    age = "";
                }
                if (gender == null) {
                    gender = "";
                }
		if (desc == null) {
                    desc = "";
                }
                if (qty == null) {
                    qty = "";
                }
		if (cost == null) {
                    cost = "";
                }
                if (price == null) {
                    price = "";
                }
		if (img == null) {
                    img = "";
                }
		if (recycle == null) {
                    recycle = "";
                }

            %>
            <legend>Please fill in the form</legend>
            <form method='POST' action='<%= request.getRequestURI() %>'>
                <input name='action' type='hidden' value='create' />
                <p>Name:
                <input name='name' type='text' size='50' maxlength='100' value='<%= name %>' /></p>
                <p>Type(Soft Toy,...):
                <input name='type' type='text' size='50' maxlength='50' value='<%= type %>' /></p>
		<p>Age(all: 0):
                <input name='age' type='text' size='2' maxlength='2' value='<%= age %>' /></p>
		<p>Gender(Female: F, Male: M, Both: B)
                <input name='gender' type='text' size='1' maxlength='1' value='<%= gender %>' /></p>
		<p>Description:
                <input name='desc' type='text' size='100' maxlength='100' value='<%= desc %>' /></p>
		<p>Qty:
                <input name='qty' type='text' size='10' maxlength='10' value='<%= qty %>' /></p>
		<p>Cost:
                <input name='cost' type='text' size='10' maxlength='100' value='<%= cost %>' /></p>
		<p>Price:
                <input name='price' type='text' size='10' maxlength='100' value='<%= price %>' /></p>
                <p>Image Path:
                <input name='img' type='text' size='100' maxlength='100' value='<%= img %>' /></p>
		<%
		if (userType.equalsIgnoreCase("admin")){
		%>
                <input name='owner' type='hidden' value='0' />
		<p>Owner: Toy Market</p>
		<%
		}
		else {
		%>
		<input name='owner' type='hidden' value='<%= userID %>' />
		<p>Owner: (<%= userID %>) <%=username%></p>
		<%
		}
		%>
		<p>Recycle (Y/N):
                <input name='recycle' type='text' size='1' maxlength='1' value='<%= recycle %>' /></p>
                <input type='submit' value='Create!' />
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



                
           