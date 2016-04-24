<%-- 
    Document   : depositFail
    Created on : 2016年4月23日, 上午01:37:50
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deposit</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body><jsp:include page="include/note.jsp" />
        <jsp:useBean id="User" type="allClass.User" scope="session" />
        <h1>Toy Market</h1>
        <h2>Deposit Fail</h2>
        <div style='width:600px'>
        <fieldset>
            <legend>The ${amount} is fail to add.</legend>
            <p>UserID: <jsp:getProperty name="User" property="userId" /></p>
            <p>Name: <jsp:getProperty name="User" property="userName" /></p> 
                        <p><a href='controller?action=browse&amp;category=all' >Back to Toy directory</a></p>
        </fieldset>
        </div>
                        <br/>
                        <jsp:include page="include/note.jsp" />
    </body>
</html>
