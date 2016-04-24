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
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <h1>Toy Market</h1>
        <h2>Toy Information</h2>
        
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
                        <td>Img:</td><td><img id="img" src="<jsp:getProperty name="Toy" property="imgPath" />" /></td>
                    </tr>
                </table>
                    
                    <c:if test="${User.userRole eq 'user'}">
                        <form method='POST' action='shoppingCart'>
                <input name='action' type='hidden' value='add' />
                <input name='toyid' type='hidden' value='<jsp:getProperty name="Toy" property="toyid" />' />
                <p>Qty: <input name='buyqty' type='number' value='' min='1'/></p>
                <input type='submit' value='Add to Cart' />
                        </form>
                        </c:if>
                <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
            </fieldset>
        
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
