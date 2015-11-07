//Javascript page


$(document).ready(function(){

	$("img").hover(
	    function(){$(this).animate({width: "90%", height:"90%"}, 1000);},        
	    function(){$(this).animate({width: "75%", height:"75%"}, 1500);}
	);
	
	
	
	$(".interesting_flag").click(function(){
		var preference = $(this).parent().attr("id");
		$(this).animate({padding: "15px"},500);
		$(this).css("background-color", "orange"); 
		$(this).css("color", "white"); 
		$(this).animate().text("YES, THIS IS INTERESTING!");
		updatePreferences(preference);
	}); 
});




var xmlHttpRequest;

if(window.XMLHttpRequest)
	{
		xmlHttpRequest=new XMLHttpRequest();
	}
else if(window.XMLHttpRequest)
	{
		xmlHttpRequest=new ActiveXObject("MICROSOFT.XMLHTTP");
	
	}

function deleteAllCookies()
{

	xmlHttpRequest.open("POST", "AjaxRequestServlet?cookieAction=deleteAll",true);
    xmlHttpRequest.onreadystatechange=processTutorials;
    xmlHttpRequest.send();
	
}

function updatePreferences(preference)
{
	xmlHttpRequest.open("POST", "AjaxRequestServlet?preference="+ preference,true);
    xmlHttpRequest.onreadystatechange=processTutorials;
    xmlHttpRequest.send();
}


function logName()
{


	$('#complete_page').css({"visibility":"visible"});
	$('#complete_page').hide();
	$('#complete_page').fadeIn(1000);    

	$('#nameButton').hide();
	$('#nameTag').text("Welcome " + document.getElementById("topicTextInput").value);
	xmlHttpRequest.open("POST", "AjaxRequestServlet?name="+ document.getElementById("topicTextInput").value,true);
    xmlHttpRequest.onreadystatechange=processTutorials;
    xmlHttpRequest.send();


}

function processTutorials()
{
	
	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
	{
		if(xmlHttpRequest.responseText.equals('Name'))
			{
				window.alert(xmlHttpRequest.responseText);
			}
	}
}





