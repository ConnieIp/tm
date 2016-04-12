<%-- 
    Document   : browse
    Created on : 2016年4月8日, 下午08:16:30
    Author     : samsung-pc
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="allClass.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Browse toy</title>
    </head>
    <body>
        <h1>Browse Toy</h1>
        <div style='width:600px'>
            <!-- create bean for getting user information -->
            <jsp:useBean id="User" type="allClass.User" scope="session" />
            <p>Hi, <jsp:getProperty name="User"  property="userName" />!</p>
        <fieldset>
        <legend>Toy Directoy</legend>
        <!-- selecting category, link to SimpleControllerServlet (with parameter: action, category) -->
        <table>
            <tr>
                <td><a href='controller?action=browse&amp;category=all'>All</a></td>
                <td><a href='controller?action=browse&amp;category=girl'>girl</a></td>
                <td><a href='controller?action=browse&amp;category=boy'>boy</a></td>
                <td><a href='controller?action=browse&amp;category=baby'>baby</a></td>
                <td><a href='controller?action=browse&amp;category=child'>child</a></td>
            </tr>
	</table>
            <%
                //get ArrayList of all toys in the selected category in ToyMarket
                ArrayList<Toy> toys = (ArrayList<Toy>)request.getAttribute("ToyMarket");
            %>  
        <p>Category: <%= (String) request.getAttribute("Category") %> </p>
        <p>Total <%= toys.size() %> entries.</p>
        <div><table style='width:100%'>
        <thead>
        <th align='left'>ToyID</th><th align='left'>Name</th><th align='left'>Type</th><th align='left'>Qty</th><th align='left'>Toy Price</th>
		<%
			if(((String) session.getAttribute("role")).equalsIgnoreCase("admin")){
		%>
		<th align='left'>Action</th>
        <%
			}
		%>
		</thead>
        <tbody>
        <%
			for (Toy toy: toys) {
		%>
			<tr>
                                <td>
				<%= toy.getToyid() %>				
				</td>
                                <td>
				<a href="controller?action=toyInfo&amp;toyid=<%= toy.getToyid() %>">
				<%= toy.getToyname() %>
				</a>
				</td>
				<td><%= toy.getToytype() %></td>
				<td><%= toy.getQty() %></td>
				<td><%= toy.getPrice() %></td>
		<%
				if(((String) session.getAttribute("role")).equalsIgnoreCase("admin")){
		%>
                <td>
                    <a href='controller?action=updateToy&amp;toyid=<%= toy.getToyid() %>'>Update</a>
                    <a href='controller?action=deleteToy&amp;toyid=<%= toy.getToyid() %>'>Delete</a>
                </td>
        <%
				}
			}
            
        %>
			</tr>
        </tbody>
        </table></div>
        <br/>
        <c:choose>
            <c:when test='${User.userRole == "admin"}'>
                <a href='controller?action=addToy'>Add a New Toy</a>
            </c:when>
            <c:otherwise>
                <a href='controller?action=recycleToy'>Recycle your Toy!</a>
            </c:otherwise>
        </c:choose>
        <br/>
        <p><a href='logout.do'>Logout</a></p>
        </fieldset>
        </div>
    </body>
</html>
