<%-- 
    Document   : checkoutFail
    Created on : 2016年4月10日, 上午04:19:22
    Author     : PuiWa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Fail</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Checkout Fail</h2>
        <h2>Oops! Your shopping cart is empty or you encountered some errors!</h2>
        <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
        <br/><jsp:include page="include/note.jsp" />
    </body>
</html>
