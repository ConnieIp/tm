<%-- 
    Document   : depositSuccess
    Created on : 2016年4月23日, 上午01:20:14
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deposit Successfully</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <jsp:include page="include/note.jsp" />
        <jsp:useBean id="User" type="allClass.User" scope="session" />
        <h1>Toy Market</h1>
        <h2>Deposit</h2>
        <div style='width:600px'>
        <fieldset>
            <legend>The ${amount} is sucessfully added.</legend>
            <p>UserID: <jsp:getProperty name="User" property="userId" /></p>
            <p>Name: <jsp:getProperty name="User" property="userName" /></p> 
            <p>Amount: ${amount}</p> 
            <p>Balance: ${balance}</p> 
                        <p><a href='controller?action=browse&amp;category=all' >Back to Toy directory</a></p>
        </fieldset>
        </div>
                        <br/>
                        <jsp:include page="include/note.jsp" />
    </body>
</html>

