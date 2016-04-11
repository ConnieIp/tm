<%-- 
    Document   : delCommentSuccess
    Created on : 2016年4月12日, 上午12:11:51
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
        <h1>Delete Comment</h1>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="Comment" type="allClass.Comment" scope="request" />
        
            <legend>The Comment is sucessfully deleted.</legend>
            <p>ToyID: <jsp:getProperty name="Comment" property="toyid" /></p>
            <p>CommentID: <jsp:getProperty name="Comment" property="commentID" /></p>
            <p>Comment: <jsp:getProperty name="Comment" property="comment" /></p>   
                        <p><a href='controller?action=toyinfo&amp;toyid=<jsp:getProperty name="Comment" property="toyid" />' >Back to Toy Info Page</a></p>
        </fieldset>
        </div>
    </body>
</html>

