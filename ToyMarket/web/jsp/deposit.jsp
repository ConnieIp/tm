<%-- 
    Document   : deposit
    Created on : 2016年4月23日, 上午01:12:06
    Author     : samsung-pc
--%>


<%@page import="allClass.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deposit</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    </head>
    <body>
        <jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Deposit</h2>
        <div style='width:600px'>
        <fieldset>
			
            <legend>Please fill in the information</legend>
            <form method='POST' action='accountController'>
                <input name='action' type='hidden' value='deposit' />
                <p>Credit Card Type:
                    <select name="type">
                        <option value="Visa">Visa</option>
                        <option value="Master">Master</option>
                    </select>
                <p>Card Number:
                <input name='number' type='text' size='16' maxlength='16' value='' /></p>
		<p>Expire Date(mm/yy):
                <input name='month' type='text' size='2' maxlength='2' value='' />
                /
                <input name='year' type='text' size='2' maxlength='2' value='' /></p>
		<p>Security Code(3-digit):
                <input name='code' type='text' size='3' maxlength='3' value='' /></p>
                <p>Deposit Amount:
                <input name='amount' type='text' size='10' maxlength='10' value='' /></p>
                <input type='submit' value='Deposit!' />
                <input type='reset' value='Reset!' />
            </form>
            
            <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
        </fieldset>
        </div>
        <br/>
        <jsp:include page="include/note.jsp" />
    </body>
</html>
