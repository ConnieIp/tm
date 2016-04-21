<%-- 
    Document   : recycleSuccess
    Created on : 2016年4月13日, 上午01:46:18
    Author     : PuiWa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recycle Application</title>
    </head>
    <body>
        <h1>Recycle Application Success!</h1>
        <form>
            <fieldset>
                <legend>Recycle Application Success</legend>
                <p>We have received your application for recycling "${recycleToyName}"!</p>
                <p>We will process you application and reply as soon as possible. Thank you!</p>
            </fieldset>
        </form>
        <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
    </body>
</html>
