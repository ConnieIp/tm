<%-- 
    Document   : note
    Created on : 2016年4月24日, 下午10:53:06
    Author     : samsung-pc
--%>

<%@page import="allClass.Reply"%>
<%@page import="allClass.CommentLookup"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="allClass.Comment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Note</title>
        <link rel="stylesheet" href="../css/general.css" type="text/css" />
        <style type="text/css">
            #note{
                text-align: center;
                border: 1px solid;
                border-color: #000000;
                background-color: #FFFFFF;
                float:left;
                width:100%;
            }
            </style>
    </head>
    <body>
        <div id='note'>
        <p style='background-color: #FFFFFF;'>This web site exists to fulfill the coursework requirement of CS4280</p>
        <p style='background-color: #FFFFFF;'>Do not use your real personal data as input</p>    
        </div>
    </body>
</html>
