<%-- 
    Document   : addToy
    Created on : 2016年4月9日, 上午12:43:02
    Author     : samsung-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Toy</title>
    </head>
    <body>
        <h1>Update Toy</h1>
        <div style='width:600px'>
        <fieldset>
		<jsp:useBean id="Toy" type="allClass.Toy" scope="request" />
			
            <legend>Please fill in the form</legend>
            <form method='POST' action='manageToy'>
                <input name='action' type='hidden' value='update' />
				<input name='toyid' type='hidden' value='<jsp:getProperty name="Toy" property="toyid" />' />
                <p>Name:
                <input name='name' type='text' size='50' maxlength='100' value='<jsp:getProperty name="Toy" property="toyname" />' /></p>
                <p>Type(Soft Toy,...):
                <input name='type' type='text' size='50' maxlength='50' value='<jsp:getProperty name="Toy" property="toytype" />' /></p>
				<p>Age(all: 0):
                <input name='age' type='text' size='2' maxlength='2' value='<jsp:getProperty name="Toy" property="age" />' /></p>
				<p>Gender(Female: F, Male: M, Both: B)
                <input name='gender' type='text' size='1' maxlength='1' value='<jsp:getProperty name="Toy" property="gender" />' /></p>
				<p>Description:
                <input name='desc' type='text' size='100' maxlength='100' value='<jsp:getProperty name="Toy" property="description" />' /></p>
				<p>Qty:
                <input name='qty' type='text' size='10' maxlength='10' value='<jsp:getProperty name="Toy" property="qty" />' /></p>
				<p>Price:
                <input name='price' type='text' size='10' maxlength='100' value='<jsp:getProperty name="Toy" property="price" />' /></p>
                <p>Image Path:
                <input name='img' type='text' size='100' maxlength='100' value='<jsp:getProperty name="Toy" property="imgPath" />' /></p>
				<input name='owner' type='hidden' value='<jsp:getProperty name="Toy" property="owner" />' />
				<p><p>Owner: <jsp:getProperty name="Toy" property="owner" /></p>
				<p>Recycle (Y/N):
                <input name='recycle' type='text' size='1' maxlength='1' value='<jsp:getProperty name="Toy" property="recycle" />' /></p>
                <input type='submit' value='Update!' />
            </form>
            
            <br/><a href='controller?action=browse&amp;category=all'>Back to Toy Directory</a>
        </fieldset>
        </div>
    </body>
</html>

