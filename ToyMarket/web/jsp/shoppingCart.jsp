<%-- 
    Document   : shoppingCart.jsp
    Created on : 2016年4月9日, 下午07:11:54
    Author     : PuiWa
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Shopping Cart</h1>
        <jsp:useBean id="cart" type="allClass.ShoppingCart" scope="session" />
        <jsp:useBean id="newToy" type="allClass.Toy" scope="request" />
        <p>${newToy.toyname} is added to shopping cart sucessfully.</p>
        <form action="" method="post">
            <fieldset>
                <legend>Shopping Cart</legend>
                <table>
                    <tr>
                        <td>Name</td>
                        <td>Quantity</td>
                        <td>Price</td>
                    </tr>
                    <c:forEach var="entry" items="${cart.toys}" varStatus="iter">
                        <tr>
                            <td>${entry.key.toyname}</td>
                            <td>${entry.value}</td>
                            <td>${entry.key.price}</td>
                        </tr>
                    </c:forEach>
                </table>
                <hr/>
                <table>
                    <td>Total</td><td>$${cart.total}</td>
                </table>
            </fieldset>
        </form>
        <br/><a href='shoppingCart?action=clear'>Clear Cart</a>
        <br/><a href='checkout'>Checkout!</a>
        <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
    </body>
</html>
