/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException, SQLException, ClassNotFoundException{
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<head>");
        out.println("  <title>Login Page</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Login Page</h1>");
		String usergp="";
                String gppw="";
		HttpSession session=request.getSession();
                if (session.getAttribute("role").equals("user")){
                    usergp="user";
                    gppw="user";
                }
                else
                {
                    usergp="admin";
                    gppw="admin";
                }
                    
                        out.println("<script type='text/javascript'>");
					out.println("function formSubmit(){");
					out.println("document.getElementById('login').submit();");
					out.println("}");
					out.println("</script>");
					out.println("<form id='login' action='j_security_check' method='POST' >");
                                        //out.println("  <input type='hidden' name='name' value='"+name+"'/>");
					//out.println("  <input type='hidden' name='userid' value='"+userid+"'/>");
					//out.println("  <input type='hidden' name='password' value='"+userpw+"'/>");
                                        out.println("  <input type='hidden' name='j_username' value='"+usergp+"'/>");
                                        out.println("  <p>User Group: "+usergp+"</p>");
                                        out.println("  <input type='hidden' name='j_password' value='"+gppw+"'/>");
					//out.println("  <p>User name: <input type='text' name='j_username' id='j_username' value='"+usergp+"'/></p>");
					//out.println("  <p>Password: <input type='password'  name='j_password' id='j_password' value='"+gppw+"'/></p>");
					out.println("  <p><input type='submit' value='Login' /></p>");
					out.println("</form>");
                                        out.println("<script>formSubmit();</script>");
			out.println("</body>");
			out.println("</html>");
            out.close();
        }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
