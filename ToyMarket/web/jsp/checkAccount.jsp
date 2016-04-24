<%-- 
    Document   : checkAccount
    Created on : 2016年4月23日, 上午01:59:06
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        
        <jsp:useBean id="User" type="allClass.User" scope="session" />
        <h1>Toy Market</h1>
        <h2>Your Account</h2>
        <div style='width:600px'>
        <fieldset>
            <legend>Account Information</legend>
            <p>UserID: <jsp:getProperty name="User" property="userId" /></p>
            <p>Name: <jsp:getProperty name="User" property="userName" /></p>
            <p>Balance: ${balance}</p> 
            <p><a href='controller?action=browse&amp;category=all' >Back to Toy directory</a></p>
        </fieldset>
        </div>
    </body>
</html>
