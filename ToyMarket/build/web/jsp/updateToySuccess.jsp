<%-- 
    Document   : updaateToySuccess
    Created on : 2016年4月9日, 上午01:13:37
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Toy</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Update Toy</h2>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="Toy" type="allClass.Toy" scope="request" />
        
            <legend>The toy is sucessfully updated.</legend>
            <p>ToyID: <jsp:getProperty name="Toy" property="toyid" /></p>
            <p>Name: <jsp:getProperty name="Toy" property="toyname" /></p>   
                        <p><a href='controller?action=browse&amp;category=all' >Back to Toy directory</a></p>
        </fieldset>
        </div>
                        <br/>
                        <jsp:include page="include/note.jsp" />
    </body>
</html>
