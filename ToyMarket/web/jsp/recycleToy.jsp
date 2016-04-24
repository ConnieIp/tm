<%-- 
    Document   : recycleToy
    Created on : 2016年4月11日, 上午01:59:20
    Author     : PuiWa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recycle Toy</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <h1>Recycle Toy</h1>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="User" type="allClass.User" scope="session" />
            <legend>Please fill in the form</legend>
            <form method='POST' action='recycle'>
                <p>Name:
                <input name='name' type='text' size='50' maxlength='100' value='' /></p>
                <p>Type(Soft Toy,...):
                <input name='type' type='text' size='50' maxlength='50' value='' /></p>
                <p>Age(all: 0):
                <input name='age' type='text' size='2' maxlength='2' value='' /></p>
                <p>Gender(Female: F, Male: M, Both: B)
                <input name='gender' type='text' size='1' maxlength='1' value='' /></p>
                <p>Description:
                <input name='desc' type='text' size='100' maxlength='100' value='' /></p>
                <p>Qty:
                <input name='qty' type='number' size='10' maxlength='10' value='' min='1'/></p>
                <p>Price (HKD):
                <input name='price' type='number' size='10' maxlength='100' value='' min='0'/></p>
                <p>Image Path:
                <input name='img' type='text' size='100' maxlength='100' value='' /></p>
                <p>Owner: <jsp:getProperty name="User" property="userName" /></p>
                <input type='submit' value='Apply!' />
            </form>
            <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
        </fieldset>
    </body>
</html>
