package data;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Ajax Servlet to handle Javascript calls for user preference of stats
public class AjaxRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	String cookieAction = (String)request.getParameter("cookieAction");
    	String userName=(String)request.getParameter("name");
    	String userStatPreference=(String)request.getParameter("preference");

    	//If the preference AJAX request is not null and has valid data  
    	if(userStatPreference!=null && userStatPreference.contains("Stat_"))
    	{
    	    Boolean preferencesExist=false;
    		String preferenceList="";
    		String unitPreference="";
    		Cookie[] cookies = request.getCookies();
			System.out.println(userStatPreference.substring(userStatPreference.lastIndexOf("_") + 1));    		
			unitPreference=userStatPreference.substring(userStatPreference.lastIndexOf("_") + 1);
			
			if(cookies!=null){
    			
    			for(int i=0; i<cookies.length; i++)
    			{
    				Cookie cookie =cookies[i];
    		    	//Update the preference cookie with the latest desireable stat
    				if(cookie.getName().equals("OKURIOPREF"))
    				{
        				preferencesExist=true;
    					System.out.println(cookie.getName()+" "+cookie.getValue());
        				preferenceList=cookie.getValue();
        	
        				preferenceList = preferenceList.replace(unitPreference, "");
        				preferenceList=unitPreference+preferenceList;
        	
        				cookie.setValue("");
        				cookie.setMaxAge(0);
            			cookie.setPath("/");
            		    System.out.println(cookie.getName()+cookie.getValue());
            			response.addCookie(cookie);
            				
            	    	Cookie newPreferenceCookie = new Cookie("OKURIOPREF", preferenceList);
            	    	newPreferenceCookie.setMaxAge(60*60*24*365);
            	    	newPreferenceCookie.setPath("/");
            		    response.addCookie(newPreferenceCookie);
        					
            	        System.out.println("Prefernce " + unitPreference + "in que" + preferenceList );
        	
    				}

    			}
    			
    		     		
			}
    	}
    	
    	
    	//If the Start Over button is selected then this will delete all the cookies  	
    	if(cookieAction!=null && cookieAction.equals("deleteAll"))
    	{
    		Cookie[] cookies = request.getCookies();
    		
    		if(cookies!=null){
    			
    			for(int i=0; i<cookies.length; i++)
    			{
    				Cookie cookie =cookies[i];
    				System.out.println(cookie.getName()+cookie.getValue());
    				cookie.setMaxAge(0);
    				cookie.setPath("/");
    				response.addCookie(cookie);
    			}
    		
    		}
    	}
    
    	//If there is no username then we want to set a new name cookie and create
    	//a default preference cookie to start with
    	if(userName!=null){
	    	System.out.println("Made it!"+request.getParameter("name"));
	    	Cookie nameCookie = new Cookie("OKURIONAME", request.getParameter("name"));
			nameCookie.setMaxAge(60*60*24*365);
			nameCookie.setPath("/");
			response.addCookie(nameCookie);
			
			Cookie preferencesCookie = new Cookie("OKURIOPREF", "ABCD");
			preferencesCookie.setMaxAge(60*60*24*365);
			preferencesCookie.setPath("/");
			response.addCookie(preferencesCookie);
			
			response.setContentType("text/html");
			response.getWriter().println("Name");
			
    	}
    	
    	
    
	}

}
