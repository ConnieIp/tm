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
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/general.css" type="text/css" />
    <style type="text/css">
        h2{
            float:left;
        }
        #name{
            font-size: 1.2em;
            text-align: right;
            margin-right:10px;
        }
        #action p{
            text-align: right;
        }
        #browse{
            width:100%;
            float:left;
        }
        .action{
            font: 1em Verdana, Arial, Helvetica, sans-serif;
            text-align: center;
            letter-spacing: .1em;
            padding:0px 10px 0px 10px;
            border: 2px solid;
            border-color: #B0C4DE;
            border-radius: 24px 24px 24px 24px;
            background-color: #B0C4DE;
        }
        .action:hover{
            background-color: #A9E2F3;
            border-color: #A9E2F3;
        }
        .category{
            font-size:1.1em;
            padding:0px 10px 0px 10px;
            text-align: center;
            letter-spacing: .1em;
            border: 2px solid;
            border-color: #A9E2F3;
            border-radius: 10px 10px 0px 0px;
            background-color: #A9E2F3;
        }
        .category:hover{
            background-color: #B0C4DE;
            border-color: #B0C4DE;
            transform: scale(1.2,1.2);
            -webkit-transform: scale(1.2, 1.2);
        }
        #list th{
            background-color: #A9E2F3;
            
        }        
    </style>
    </head>
    <body>
        <jsp:include page="include/note.jsp" />
        <h1>Toy Market</h1>
        <h2>Browse Toy</h2>
        <jsp:useBean id="User" type="allClass.User" scope="session" />
        <p id='name'>Hi, <jsp:getProperty name="User"  property="userName" />!<p>    
        <div id='action'>
            <p>    
            <c:choose>
            <c:when test='${User.userRole == "admin"}'>
                <a class='action' href='controller?action=addToy'>Add a New Toy</a>
                <a class='action' href='manageRecycle?action=browse'>Manage Toy Recycle Applications</a>
            </c:when>
            <c:otherwise>
                <a class='action' href='controller?action=recycleToy'>Recycle your Toy!</a>
                <a class='action' href='shoppingCart?action=lookup'>Cart</a>
                <a class='action' href='accountController?action=check'>Account Information</a>
                <a class='action' href='controller?action=deposit'>Deposit</a>
            </c:otherwise>
        </c:choose>
                <a class='action' href='logout.do'>Logout</a>
            </p>
        </div>
            
        <div id='browse'>
        <fieldset>
        <legend>Toy Directoy</legend>
        <%
                //get ArrayList of all toys in the selected category in ToyMarket
                ArrayList<Toy> toys = (ArrayList<Toy>)request.getAttribute("ToyMarket");
            %> 
        <p style='float:left'>Category: <%= (String) request.getAttribute("Category") %> </p>
        <p style='text-align:right'>Total <%= toys.size() %> entries.</p>
        <!-- selecting category, link to SimpleControllerServlet (with parameter: action, category) -->
        <table>
            <tr>
                <td><a class='category' href='controller?action=browse&amp;category=all'>All</a></td>
                <td><a class='category' href='controller?action=browse&amp;category=girl'>Girl</a></td>
                <td><a class='category' href='controller?action=browse&amp;category=boy'>Boy</a></td>
                <td><a class='category' href='controller?action=browse&amp;category=baby'>Baby</a></td>
                <td><a class='category' href='controller?action=browse&amp;category=child'>Child</a></td>
            </tr>
	</table>
             
        
        <div id='list'><table style='width:100%'>
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
        
        
        
        </fieldset>
                        <br/>
        </div>
        <jsp:include page="include/note.jsp" />
    </body>
</html>
