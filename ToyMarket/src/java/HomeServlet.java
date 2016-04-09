/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import allClass.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HomeServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // increase magic attribute in session by 1
        HttpSession session=request.getSession();
		
		if(session.getAttribute("magic") != null){
        int n=(Integer)session.getAttribute("magic");
        session.setAttribute("magic",n+1);
		}
		else{
			session.setAttribute("magic",1);
		}
		User user=new User((String)session.getAttribute("userid"),(String)session.getAttribute("name"),
                        (String)session.getAttribute("userpw"),(String)session.getAttribute("role"));
                session.setAttribute("User",user);
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
		
        try {
            out.println("<html>");
            out.println("<head>");
            out.println("  <title>Index Page</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Index Page</h1>");
            out.println("<p>Welcome, "+session.getAttribute("name")+"</p>");
            out.println("<p>You login as " + (request.isUserInRole("admin") != false ? "Manager role" : "User role") + "  .</p>");
            out.println("<p>(accessed " + ((session.getAttribute("magic") != null) ? (Integer)session.getAttribute("magic") : "0") + " times)</p>");
			out.println("<p><a href='controller?action=browse&amp;category=all'>Main Page</a></p>");  //set index.jspx as first page?
            out.println("<p><a href='logout.do'>Logout</a></p>");
            out.println("</body>");
            out.println("</html>");
			
			
        } finally { 
            out.close();
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
