/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException{
        // invalidate the session
        HttpSession session=request.getSession();
        session.invalidate();
		
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println("<html>");
            out.println("<head>");
            out.println("  <title>Logout Page</title>");
            out.println(" <link rel=\"stylesheet\" href=\"css/general.css\" type=\"text/css\" />");
            out.println("</head>");
            out.println("<body>");
            String pagename="/jsp/include/note.jsp";
            request.getRequestDispatcher(pagename).include(request, response);
            out.println("<h1>Toy Market</h1>");
            out.println("<h2>Logout Page</h2>");
            out.println("<p>You have successfully logged out!</p>");
            out.println("<p>Return to <a href='userLogin.do'>index page</a> (re-login required)</p>");
            request.getRequestDispatcher(pagename).include(request, response);
            out.println("</form>");
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
