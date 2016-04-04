<%-- 
    Document   : userLogin
    Created on : 2016年4月3日, 下午01:28:04
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.String, java.lang.StringBuffer" %>
<%@page import="javax.naming.Context, javax.naming.InitialContext" %>
<%@page import="java.sql.Connection, javax.sql.DataSource, java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet, java.sql.Statement" %>
<%@page import="java.sql.SQLException, javax.naming.NamingException" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/default.css" rel="stylesheet" type="text/css">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login</h1>
        <%
            String name=request.getParameter("name");
            String password=request.getParameter("password");
            String role=request.getParameter("role");
out.println("<p>"+name+password+role+"</p>");
                        String userid = "";
			String userpw = "";
			String usergp = "";
			String gppw ="";
			if (name != null && !name.equalsIgnoreCase("") &&
                password != null && !password.equalsIgnoreCase("") && 
                role != null && !role.equalsIgnoreCase("")){
                                                
                Context initCtx = new InitialContext();
                Context envCtx = (Context)initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource)envCtx.lookup("jdbc/asgp2");
                Connection con = ds.getConnection();
                PreparedStatement pstmt1 = con.prepareStatement("SELECT * FROM [UserIDMap] WHERE [Username] = ? ");
                pstmt1.setString(1, name);
                ResultSet rs1 = pstmt1.executeQuery();
                                if (rs1 != null  && rs1.next() != false){
					userid = rs1.getString("UserID");
                                }
out.println("<p>"+userid+"</p>");                                
                                PreparedStatement pstmt = con.prepareStatement("SELECT * FROM [UserLogin] WHERE [Username] = ? ");
                                pstmt.setString(1, name);
                                ResultSet rs = pstmt.executeQuery();
				if (rs != null  && rs.next() != false){
					userpw = rs.getString("Password");
					usergp = rs.getString("UserGp");
					gppw = rs.getString("GpPassword"); //add a column
                                        
                                        if (role.equalsIgnoreCase("user"))
                                            role="user";
                                        else
                                            role="admin";
					if(userpw.equals(password) && usergp.equals(role)){
                                            HttpSession session=request.getSession();
                                            request.setAttribute("name", name);
                                            response.sendRedirect("index.do");                                            
                                        }else{
						%>
                                                <p>Wrong Password/Role!</p>
                                                <p><a href="userLogin.jsp">Retry</a></p>
                                                <%
					}       
                                }else{
                                        %>
                                        <p>Wrong Username!</p>
                                        <p><a href="userLogin.jsp">Retry</a></p>
                                        <%
                                            }
                                             
                if (con != null) {
                    con.close();
                }
                }else{
        %>
        <!--<p><%= name %> <%= password %></p>-->
	<form action='<%= request.getRequestURI() %>' method='POST'> 
        <%
            if(name == null)
                name="";
            if(password==null)
                password="";
            %>
            <!--<form action='index.do' method='POST'>-->
	<p>User name: <input type='text' name='name' value='<%= name %>'</p>
	<p>Password: <input type='password'  name='password' value='<%= password %>'</p>
        <p>Role: <input type="radio" name="role" value="user" checked="checked"/> User
        <input type="radio" name="role" value="manager"/> Manager
        </p>
        <p><input type='submit' value='Login' /></p>
	</form>
        <%
            }
            %>
        
    </body>
</html>
