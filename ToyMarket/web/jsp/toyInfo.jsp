<%-- 
    Document   : toyInfo
    Created on : 2016年4月9日, 下午03:11:01
    Author     : PuiWa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Toy Info</title>
    </head>
    <body>
        <h1>Toy Info</h1>
        <form>
            <fieldset>
                <jsp:useBean id="Toy" type="allClass.Toy" scope="request" />
                <legend>Toy Info</legend>
                <table>
                    <tr>
                        <td>Name:</td><td><jsp:getProperty name="Toy" property="toyname" /></td>
                    </tr>
                    <tr>
                        <td>Type:</td><td><jsp:getProperty name="Toy" property="toytype" /></td>
                    </tr>
                    <tr>
                        <td>Age:</td><td><jsp:getProperty name="Toy" property="age" /></td>
                    </tr>
                    <tr>
                        <td>Gender:</td><td><jsp:getProperty name="Toy" property="gender" /></td>
                    </tr>
                    <tr>
                        <td>Description:</td><td><jsp:getProperty name="Toy" property="description" /></td>
                    </tr>
                    <tr>
                        <td>Quantity:</td><td><jsp:getProperty name="Toy" property="qty" /></td>
                    </tr>
                    <tr>
                        <td>Price:</td><td><jsp:getProperty name="Toy" property="price" /></td>
                    </tr>
                    <tr>
                        <td>Img:</td><td><jsp:getProperty name="Toy" property="imgPath" /></td>
                    </tr>
                </table>
            </fieldset>
        </form>
    </body>
</html>
