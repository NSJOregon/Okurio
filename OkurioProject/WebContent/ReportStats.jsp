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
		<script type="text/javascript">
			var counter = <%=elapsedTime %>;
			var timer;
			function countUP () {
				counter = counter + 1;//increment the counter by 1
				$("#Stat_A_Val").text((counter*0.0010664).toFixed(0));
				$("#Stat_B_Val").text((counter*0.0003171).toFixed(3));
				$("#Stat_C_Val").text((counter*0.00008102).toFixed(0));
				$("#Stat_D_Val").text(((counter*0.00048727*318900000)/31536000).toFixed(3));
				$("#Stat_E_Val").text(formatNumber(counter*146.499));
				$("#Stat_F_Val").text((counter*.00000073).toFixed(2));
				$("#Stat_G_Val").text((counter*11).toFixed(0));
				$("#Stat_H_Val").text((counter*.00000155).toFixed(0));
				$("#Stat_I_Val").text((counter*.00000060).toFixed(0));
			}
		


			function formatNumber(number)
			{
			    var number = number.toFixed(2) + '';
			    var x = number.split('.');
			    var x1 = x[0];
			    var x2 = x.length > 1 ? '.' + x[1] : '';
			    var rgx = /(\d+)(\d{3})/;
			    while (rgx.test(x1)) {
			        x1 = x1.replace(rgx, '$1' + ',' + '$2');
			    }
			    return x1 + x2;
			}


			
			</script>

	</head>

	<body onload='timer=setInterval("countUP()", 1000 );'>
	
		<!-- 	Hide timer control buttons for debugging 
			<div>
			<button onclick='clearInterval(timer);'>Stop Timer</button>
			<button onclick='timer=setInterval("countUP()", 1000 );'>Continue Timer</button>
			</div>
		-->
		
		<%
				
		Boolean previousVisit=false;
		String pastVisit=(String)request.getAttribute("lastVisit");
		String welcomeMessage="";
		Cookie[] cookies = request.getCookies();
		
		if(pastVisit==null){
			pastVisit="";
		}
				
		if(cookies!=null){
			for(Cookie c: cookies)
			{
			%>
			
			<%
				if(c.getName().equals("OKURIONAME"))
				{
    				previousVisit=true;
					welcomeMessage="Welcome back "  + c.getValue();

					%><script>
					
					$(function(){
					$('#complete_page').css({"visibility":"visible"});
					});
					
					</script><%
				}
			}
		}
		%>
    
    	<span><div id="header">OKURIO</div></span>		
		<button type="button" id="startOver" onclick="deleteAllCookies()">START OVER</button><br>

        <!-- 
	        <form action="StatsServlet" method="post" onsubmit="deleteAllCookies()">
		    <input type="hidden" id="startOver" size = "12" name="newSession" value="startOver">
		    <input type="submit" id="startOverButton" value="START OVER">
			</form>
        -->		
	
		<div id="complete_page">
		<!--  
			<br>You last visited on <%=pastVisit %><br>
		    <%=elapsedTime %>
		-->

		<div id="welcome_message"><%= welcomeMessage %><div id="nameTag"></div>Since your visit <%=pastVisit %>

	<div id="All_statistics">

     <% 
			Cookie[] preferenceCookies = request.getCookies();
					
			if(preferenceCookies!=null){
			for(Cookie c: preferenceCookies)
			{
     			if(c.getName().equals("OKURIOPREF"))
				{
					String preferenceString=new StringBuffer(c.getValue()).toString();
					for(char preference:preferenceString.toCharArray()){
						%>
							<div id ="Stat_<%=preference%>" class="image_stat">
			    			<div class="interesting_flag" style="color: orange; padding:10px; position: absolute; right:10%; top:10%; font-size: 25px; font-weight: bold; font-family: Arial;">IS THIS INTERESTING?</div>
							<img src="images/Stat-<%=preference%>.jpg" alt="Stat-<%=preference%>" height="75%" width="75%">
							<span>
							<% 
							String message="";
					        switch (preference) {
					            case 'A' :  message = "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "<div> Elephants have been poached for ivory.</div>";
					                     break;
					            case 'B':  message = "<div class=\"text_stat\">Earth has lost </div>" + "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "<div class=\"text_stat\"> tonnes of mass have been lost to space.</div>";
					                     break;
					            case 'C':  message = "<div class=\"text_stat\">You have peed </div>"+"<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "<div class=\"text_stat\"> times.</div>";
					                     break;
					            case 'D':  message = "<div class=\"text_stat\">Americans have spent </div>"+  "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\">f </div>"+ "<div class=\"text_stat\"> years on social media.</div>";
					                     break;
					            case 'E':  message = "<div class=\"text_stat\">Fans have spent $</div>" + "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "<div class=\"text_stat\"> on college licensed merchandise.</div>";
			                     		break;
					            case 'F':  message = "<div class=\"text_stat\">The North American plate has moved </div>" + "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "<div class=\"text_stat\"> millimeters in a southwest direction. </div>";
			                     		break;
					            case 'G':  message = "<div class=\"text_stat\">Voyager has travelled</div>" + "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "<div class=\"text_stat\">miles.</div>";
			                     		break;
					            case 'H':  message = "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "<div> Americans have been hit by lightning.</div>";
			                     		break;
					            case 'I':  message = "<div id = \"Stat_" + preference + "_Val\" class=\"text_stat\"> </div>" + "Americans have been attacked by sharks.";
			                     		break;
					           }
     						%>
							<div id="stat_message"><%=message%></div><div id = "Stat_<%=preference%>_Val" class="text_stat"></div>
				
							</span> 
							</div>
					
						<%
				
					}
     			}
						
			 }
		     }
      		%>

		</div>
		
		</div>
	</body>
</html>