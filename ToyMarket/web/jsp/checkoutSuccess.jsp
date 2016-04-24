<%-- 
    Document   : checkout
    Created on : 2016年4月10日, 上午12:11:32
    Author     : PuiWa
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="allClass.Toy,allClass.ShoppingCart"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Checkout Success</h2>
        <form>
            <fieldset>
                <legend>Details of Transaction</legend>
                <table>
                    <tr>
                        <td>Transaction ID</td><td>${aTransaction.transactID}</td><td></td>
                    </tr>
                    <tr>
                        <td colspan="3">Cart</td>
                    </tr>
                    <c:forEach var="entry" items="${aTransaction.cart.toys}" varStatus="iter">
                        <tr>
                            <td>${entry.key.toyname}</td>
                            <td>${entry.value}</td>
                            <td>${entry.key.price}</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td>Total</td><td>${aTransaction.cart.total}</td><td></td>
                    </tr>
                    <tr>
                        <td>Date</td><td>${aTransaction.date}</td><td></td>
                    </tr>
                    <tr>
                        <td>User Balance</td><td>${balance}</td><td></td>
                    </tr>
                </table>
            </fieldset>
        </form>
        <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
        <br/><jsp:include page="include/note.jsp" />
    </body>
</html>
