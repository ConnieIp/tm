<%-- 
    Document   : delCommentFail
    Created on : 2016年4月12日, 上午12:15:01
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comment</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body><jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Delete Comment</h2>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="Comment" type="allClass.Comment" scope="request" />
        
            <legend style='color: red'>ERROR:The Comment is fail to delete.</legend>
            <p>ToyID: <jsp:getProperty name="Comment" property="toyid" /></p>
            <p>CommentID: <jsp:getProperty name="Comment" property="commentID" /></p>
            <p>Comment: <jsp:getProperty name="Comment" property="comment" /></p>   
                        <p><a href='controller?action=toyInfo&amp;toyid=<jsp:getProperty name="Comment" property="toyid" />' >Back to Toy Info Page</a></p>
        </fieldset>
        </div>
        <br/>
        <jsp:include page="include/note.jsp" />
    </body>
</html>

