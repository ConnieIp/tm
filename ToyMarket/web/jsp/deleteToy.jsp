<%-- 
    Document   : deleteToy
    Created on : 2016年4月9日, 上午12:34:23
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Update Toy</h1>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="Toy" type="allClass.Toy" scope="request" />
        <legend>Delete the following toy?</legend>
        <form method='POST' action='manageToy'>
                <input name='action' type='hidden' value='delete' />
                <input name='toyid' type='hidden' value='<jsp:getProperty name="Toy" property="toyid" />' />
                <p>Name: <jsp:getProperty name="Toy" property="toyname" /></p>
                <p>Type: <jsp:getProperty name="Toy" property="toytype" /></p>
		<p>Age: <jsp:getProperty name="Toy" property="age" /></p>
		<p>Gender: <jsp:getProperty name="Toy" property="gender" /></p>
		<p>Description: <jsp:getProperty name="Toy" property="description" /></p>
		<p>Qty: <jsp:getProperty name="Toy" property="qty" /></p>
		<p>Price: <jsp:getProperty name="Toy" property="price" /></p>
                <p>Image Path: <jsp:getProperty name="Toy" property="imgPath" /></p>
		<p>Owner: <jsp:getProperty name="Toy" property="owner" /></p>
		<p>Recycle (Y/N): <jsp:getProperty name="Toy" property="recycle" /></p>
                <input type='submit' value='Delete!' />
            </form>
        <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
        </fieldset>
        </div>
    </body>
</html>
