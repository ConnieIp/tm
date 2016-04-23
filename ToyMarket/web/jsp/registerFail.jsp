<%-- 
    Document   : registerFail
    Created on : 2016年4月24日, 上午02:37:30
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
            <jsp:useBean id="errormsg" type="java.lang.String" scope="request" />
        
            <legend>The account is fail to creat.</legend>
            <p style='color: red'>Error: ${errormsg}</p>
          
            <br/><a href='<%= request.getContextPath() %>/jsp/register.jsp'>Register Again</a>
        </fieldset>
        </div>
    </body>
</html>

