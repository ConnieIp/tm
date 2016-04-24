<%-- 
    Document   : addToy
    Created on : 2016年4月9日, 上午12:43:02
    Author     : samsung-pc
--%>

<%@page import="allClass.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Toy</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <h1>Add Toy</h1>
        <div style='width:600px'>
        <fieldset>
		<jsp:useBean id="User" type="allClass.User" scope="session" />
			
            <legend>Please fill in the form</legend>
            <form method='POST' action='manageToy'>
                <input name='action' type='hidden' value='add' />
                <p>Name:
                <input name='name' type='text' size='50' maxlength='100' value='' /></p>
                <p>Type(Soft Toy,...):
                <input name='type' type='text' size='50' maxlength='50' value='' /></p>
				<p>Age(all: 0):
                <input name='age' type='text' size='2' maxlength='2' value='' /></p>
				<p>Gender(Female: F, Male: M, Both: B)
                <input name='gender' type='text' size='1' maxlength='1' value='' /></p>
				<p>Description:
                <input name='desc' type='text' size='100' maxlength='100' value='' /></p>
				<p>Qty:
                <input name='qty' type='text' size='10' maxlength='10' value='' /></p>
				<p>Price:
                <input name='price' type='text' size='10' maxlength='100' value='' /></p>
                <p>Image Path:
                <input name='img' type='text' size='100' maxlength='100' value='' /></p>
                <%
                if (((User)session.getAttribute("User")).getUserRole().equalsIgnoreCase("admin")){
                %>    
                <p><p>Owner: ToyMarket </p>
                <%
                }else{
                %>
                    <p><p>Owner: <jsp:getProperty name="User" property="userName" /></p>
                <%
                }
                %>
				<p>Recycle (Y/N):
                <input name='recycle' type='text' size='1' maxlength='1' value='' /></p>
                <input type='submit' value='Add!' />
            </form>
            
            <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
        </fieldset>
        </div>
    </body>
</html>

