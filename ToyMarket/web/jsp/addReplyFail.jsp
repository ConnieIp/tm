<%-- 
    Document   : addReplyFail
    Created on : 2016年4月11日, 上午12:09:09
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
    <body>
        <jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Add Reply</h2>
        <div style='width:600px'>
        <fieldset>
            <jsp:useBean id="Reply" type="allClass.Reply" scope="request" />
        
            <legend style='color: red'>ERROR:The Reply is fail to add.</legend>
            <p>ToyID: <jsp:getProperty name="Reply" property="toyid" /></p>
            <p>CommentID: <jsp:getProperty name="Reply" property="commentID" /></p>
            <p>Reply ID: <jsp:getProperty name="Reply" property="replyID" /></p>
            <p>Comment: <jsp:getProperty name="Reply" property="reply" /></p>   
                        <p><a href='controller?action=toyInfo&amp;toyid=<jsp:getProperty name="Reply" property="toyid" />' >Back to Toy Info Page</a></p>
        </fieldset>
        </div>
        <br/>
        <jsp:include page="include/note.jsp" />
    </body>
</html>

