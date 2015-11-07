<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		
		<title>OKURIO</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script  src="ReportStatsJavaScript.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css">
        <% Long elapsedTime=(Long)request.getAttribute("elapsedSeconds"); %>	
		
    </head>

	<body>
		<span><div id="header">OKURIO</div></span>		
       
        <div id="okurio_description">Each time you visit, OKURIO will update statistics based on how long it's been since you last visited. If a fact is interesting, select the "Is this interesting?" flag and the fact will be the first on the page the next time you visit. Enter your name or alias to start!</div>    

		<form action="StatsServlet" method="get">
	        <input type="text" id="topicTextInput" size = "12" name="userName">
	        <input type="submit" id="enterName" value="START ACCUMULATION">
		</form>
    
    </body>
</html>