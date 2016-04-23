<%-- 
    Document   : registerSuccess
    Created on : 2016年4月24日, 上午02:31:44
    Author     : samsung-pc
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <h1>Toy Market</h1>
        <h1>Register</h1>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="User" type="allClass.User" scope="request" />
        
            <legend>The account is sucessfully created.</legend>
            <p>User ID: ${User.userId}</p>
            <p>Name: ${User.userName}</p>
            <p>Role: ${User.userRole}</p>
            <br/><a href='<%= request.getContextPath() %>/userLogin.do'>Back to Login Page</a>
        </fieldset>
        </div>
    </body>
</html>
