<%-- 
    Document   : comment
    Created on : 2016年4月10日, 下午03:22:55
    Author     : PuiWa
--%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="allClass.Comment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comment</title>
    </head>
    <body>
        <h1>Comment</h1>
        <%--<jsp:useBean id="comments" type="java.util.ArrayList" scope="request" />--%>
        <%
            ArrayList<Comment> tempComments = (ArrayList<Comment>)request.getAttribute("comments");
            if (tempComments.size()==0) 
                out.println("null comments");
            else
                out.println("not null comments");
        %>
        <table>
            <tr>
                <td>Comment ID</td>
                <td>User ID</td>
                <td>Date</td>
                <td>Comment</td>
            </tr>
            <c:forEach var="entry" items="${comments}" varStatus="iter">
                <tr>
                    <td>${entry.commentID}</td>
                    <td>${entry.userID}</td>
                    <td>${entry.date}</td>
                    <td>${entry.comment}</td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
