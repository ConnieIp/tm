<%-- 
    Document   : updateToyFail
    Created on : 2016年4月9日, 上午01:24:44
    Author     : samsung-pc
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Toy</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <h1>Update Toy</h1>
        <div style='width:600px'>
        <fieldset>
		<jsp:useBean id="Toy" type="allClass.Toy" scope="request" />
        
            <legend style='color: red'>ERROR: The toy is failed to update.</legend>
			<p>ToyID: <jsp:getProperty name="Toy" property="toyid" /></p>
			<p>Name: <jsp:getProperty name="Toy" property="toyname" /></p>
                        <p><a href='controller?action=browse&amp;category=all' >Back to Toy directory</a></p>
			
        </fieldset>
        </div>
    </body>
</html>

