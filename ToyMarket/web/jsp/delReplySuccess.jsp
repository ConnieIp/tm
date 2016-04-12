<%-- 
    Document   : delReplySuccess
    Created on : 2016年4月12日, 上午12:17:43
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comment</title>
    </head>
    <body>
        <h1>Delete Reply</h1>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="Reply" type="allClass.Reply" scope="request" />
        
            <legend>The Reply is sucessfully deleted.</legend>
            <p>ToyID: <jsp:getProperty name="Reply" property="toyid" /></p>
            <p>CommentID: <jsp:getProperty name="Reply" property="commentID" /></p>
            <p>Reply ID: <jsp:getProperty name="Reply" property="replyID" /></p>
            <p>Comment: <jsp:getProperty name="Reply" property="reply" /></p>   
                        <p><a href='controller?action=toyinfo&amp;toyid=<jsp:getProperty name="Reply" property="toyid" />' >Back to Toy Info Page</a></p>
        </fieldset>
        </div>
    </body>
</html>
