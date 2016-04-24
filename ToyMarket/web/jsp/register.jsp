<%-- 
    Document   : register
    Created on : 2016年4月24日, 上午01:42:43
    Author     : samsung-pc
--%>

<%@page import="allClass.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Register</h2>
        <div style='width:100%'>
        <fieldset>
            <legend>Please fill in account information</legend>
            <form method='POST' action='../accountController'>
                <input name='action' type='hidden' value='create' />
                <p>User Name:
                <input name='name' type='text' size='50' maxlength='100' value='' /></p>
                <p>Password:
                <input name='password' type='text' size='50' maxlength='100' value='' /></p>
                <p>Confirm Password:
                <input name='confirmpw' type='text' size='50' maxlength='100' value='' /></p>
                <input type='submit' value='Create Account!' />
                <input type='reset' value='Reset!' />
            </form>
            
            <br/><a href='<%= request.getContextPath() %>/userLogin.do'>Back to Login Page</a>
        </fieldset>
        <br/>
        <jsp:include page="include/note.jsp" />
        </div>
    </body>
</html>
