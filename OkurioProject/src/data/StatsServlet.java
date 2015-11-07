/* StatsServlet.java
 * The StatsServlet redirects a new user to the Welcome page
 * and upon revisits directs the user to the main
 * statistics display jsp based on user preferences
 */

package data;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StatsServlet
 */
public class StatsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StatsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        Boolean cookieExists=false;
		Boolean nameCookieExists=false;
        Cookie[] cookies = request.getCookies();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		DateTimeFormatter dateDisplayFormatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy");
		DateTimeFormatter timeDisplayFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		
		if(cookies!=null){
			for(Cookie c: cookies)
			{
				
				if(c.getName().equals("OKURIO"))
				{
					cookieExists=true;
					System.out.println("THE COOKIE EXISTS");
					LocalDateTime previousDate  = LocalDateTime.parse(c.getValue(), formatter);
					Long secondsElapsed=(long) 0;
					secondsElapsed=previousDate.until(LocalDateTime.now(), ChronoUnit.SECONDS);
					System.out.println("Your last visit was on: " + previousDate.format(formatter));
					System.out.println("The date/time now is: " + LocalDateTime.now().format(formatter));
					System.out.println("Since your last visit: " + secondsElapsed);
					request.setAttribute("lastVisit", dateDisplayFormatter.format(previousDate)+" at "+ timeDisplayFormatter.format(previousDate));
					request.setAttribute("elapsedSeconds", secondsElapsed);
					c.setMaxAge(0);
					response.addCookie(c);

				}
			}
		}
		
		
		LocalDateTime date = LocalDateTime.now();
		
		Cookie cookie1 = new Cookie("OKURIO", date.format(formatter));
		cookie1.setMaxAge(60*60*24*365);
		cookie1.setPath("/");
		response.addCookie(cookie1);

        String url="/Welcome.jsp";			
        Boolean nameExists=false;
        Boolean hereBefore=false;
        
        String userName="";
		userName =request.getParameter("userName");
		if(userName!=null)
		request.removeAttribute("userName");
	    System.out.println(userName);
	    
  
               
	    if(cookies!=null){
					
	    	for(int i=0; i<cookies.length; i++)
			{
				Cookie cookie =cookies[i];
		
				if(cookie.getName().equals("OKURIONAME"))
				{
					nameExists=true;
       				url="/ReportStats.jsp";
						
				}
				
				if(cookie.getName().equals("OKURIOPREF"))
				{
					hereBefore=true;
       					
				}
			}
				
		}
	    

	    if(hereBefore && !nameExists && userName!=null && userName!=""){
		    Cookie nameCookie = new Cookie("OKURIONAME", userName);
			nameCookie.setMaxAge(60*60*24*365);
			nameCookie.setPath("/");
			response.addCookie(nameCookie);
			url="/ReportStats.jsp";
	    }

	    if(!nameExists){
	    	Cookie preferencesCookie = new Cookie("OKURIOPREF", "ABCDEFGHI");
			preferencesCookie.setMaxAge(60*60*24*365);
			preferencesCookie.setPath("/");
			response.addCookie(preferencesCookie);   	    	
	    }    
	    
       RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
       dispatcher.forward(request, response);       
			
	}

	
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		 doPost(request, response);
	    //All get requests get forwarded to POST
	 }
	
	
}
