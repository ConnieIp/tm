<%-- 
    Document   : comment
    Created on : 2016年4月10日, 下午03:22:55
    Author     : PuiWa
--%>
<%@page import="allClass.Reply"%>
<%@page import="allClass.CommentLookup"%>
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
        <link rel="stylesheet" href="../css/general.css" type="text/css" />
    </head>
    <body>
        <h2>Comment</h2>
        <jsp:useBean id="User" type="allClass.User" scope="session" />
        <table>
            <tr>
                <td>Comment ID</td>
                <td>Reply ID</td>
                <td>User ID</td>
                <td>Date</td>
                <td>Comment</td>
            </tr>
            <c:forEach var="entry" items="${comments}" varStatus="iter">
                <tr>
                    <td>${entry.commentID}</td>
                    <td> / </td>
                    <td>${entry.userID}</td>
                    <td>${entry.date}</td>
                    <td>${entry.comment}</td>
                    <c:if test="${User.userRole eq 'admin' or entry.userID eq User.userId}">
                    <td><form method='POST' action='comment' >
                    <input name='action' type='hidden' value='delComment' />
                    <input name='toyid' type='hidden' value='${entry.toyid}' />
                    <input name='CommentID' type='hidden' value='${entry.commentID}' />
                    <input type='submit' value='Delete' />
                        </form></td>
                        </c:if>
                    </tr>
                
                    <c:forEach var="entry2" items="${replies}" varStatus="iter">
                        <c:if test="${entry2.commentID == entry.commentID}">
                        <tr>
                    <td>${entry.commentID}</td>
                    <td>${entry2.replyID}</td>
                    <td>${entry2.mgrID}</td>
                    <td> / </td>
                    <td>${entry2.reply}</td>
                    <c:if test="${User.userRole eq 'admin'}">
                    <td><form method='POST' action='comment' >
                    <input name='action' type='hidden' value='delReply' />
                    <input name='toyid' type='hidden' value='${entry.toyid}' />
                    <input name='CommentID' type='hidden' value='${entry.commentID}' />
                    <input name='ReplyID' type='hidden' value='${entry2.replyID}' />
                    <input type='submit' value='Delete' />
                        </form></td>
                    </c:if>
                    </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${User.userRole eq 'admin'}">
                <tr><td colspan="5"><form method='POST' action='comment' >
			<input name='action' type='hidden' value='addreply' />
                        <input name='toyid' type='hidden' value='${entry.toyid}' />
                        <input name='reCommentID' type='hidden' value='${entry.commentID}' />
			<p><input name='newReply' type='text' size='100' maxlength='255' value='Add reply here...' /></p>
			<input type='submit' value='Submit' />
                    </form></td>
                    
                    
                </tr>
                    </c:if>
                <tr><td colspan="5">----------------------------------------------------------------------------------------------------------------------------------------------------</td></tr>
                    
            </c:forEach>
                
        </table>
    </body>
</html>
