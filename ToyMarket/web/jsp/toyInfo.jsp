<%-- 
    Document   : toyInfo
    Created on : 2016年4月9日, 下午03:11:01
    Author     : PuiWa
--%>
<%@page import="allClass.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <jsp:useBean id="User" type="allClass.User" scope="session" />
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
                        <c:if test="${User.userRole eq 'user'}">
                <br/><a href='shoppingCart?action=add&amp;toyid=<jsp:getProperty name="Toy" property="toyid" />'>Add to Cart</a>
                        </c:if>
                <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
            </fieldset>
        </form>
        <div>
            <jsp:include page="include/comment.jsp" />
            <form method='POST' action='comment' >
			<input name='action' type='hidden' value='addcomment' />
                        <input name='toyid' type='hidden' value='<jsp:getProperty name="Toy" property="toyid" />' />
			<p><input name='newComment' type='text' size='100' maxlength='255' value='Add comment here...' /></p>
			<input type='submit' value='Submit' />
            </form>
        </div>
    </body>
</html>
