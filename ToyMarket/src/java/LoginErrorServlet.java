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

public class LoginErrorServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println("<html>");
            out.println("<head>");
            out.println("  <title>Login Error Page</title>");
            out.println(" <link rel=\"stylesheet\" href=\"css/general.css\" type=\"text/css\" />");
            out.println("</head>");
            out.println("<body>");
            String pagename="/jsp/include/note.jsp";
            request.getRequestDispatcher(pagename).include(request, response);
            out.println("<h1>Toy Market</h1>");
            out.println("<h2 style='color: #FF0000;'>Login Error Page</h2>");
            out.println("<p>Your input was invalid!</p>");
            out.println("<p>User name: " + this.htmlEncode(request.getParameter("name")) + "</p>");
            out.println("<p>Password: " + this.htmlEncode(request.getParameter("password")) + "</p>");
            out.println("<p>gpUser name: " + this.htmlEncode(request.getParameter("j_username")) + "</p>");
            out.println("<p>gpPassword: " + this.htmlEncode(request.getParameter("j_password")) + "</p>");
            out.println("<p><a href='javascript:history.back(1)'>Try again!</a></p>"); //back 2?
            request.getRequestDispatcher(pagename).include(request, response);
            out.println("</body>");
            out.println("</html>");
        } finally { 
            out.close();
        }
    }

    private String htmlEncode(String s) {
        StringBuffer sb = new StringBuffer(s.length() * 2);

        for (int i = 0; i < s.length(); ++i) {
            char ch = s.charAt(i);
            if ((ch >= '?' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || (ch == ' ') || (ch == '\n')) {
                sb.append(ch);
            }
            else {
                switch(ch) {
                    case '>':
                        sb.append("&gt;");
                        break;
                    case '<':
                        sb.append("&lt;");
                        break;
                    case '&':
                        sb.append("&amp;");
                        break;
                    case '\'':
                        sb.append("&#039;");
                        break;
                    case '"':
                        sb.append("&quot;");
                        break;
                    default:
                        sb.append("&#");
                        sb.append(new Integer(ch).toString());
                        sb.append(';');
                }
            }
        }

        return sb.toString();
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
