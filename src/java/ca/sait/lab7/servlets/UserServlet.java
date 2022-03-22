package ca.sait.lab7.servlets;


import ca.sait.lab7.models.Role;
import ca.sait.lab7.services.UserService;
import ca.sait.lab7.models.User;
import ca.sait.lab7.services.RoleService;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Xin Su
 */
public class UserServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserService service = new UserService();
        try {
            List<User> users = service.getAll();
            request.setAttribute("users", users);
  
            this.getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
            
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserService service = new UserService();
        try {
            String email = request.getParameter("email");
            if (request.getParameter("type").equals("delete")) {
                service.delete(email);
            } else {
                String firstName = request.getParameter("first_name");
                String lastName = request.getParameter("last_name");
                String password = request.getParameter("password");
                Role role = new Role(Integer.parseInt(request.getParameter("role")),"");
                if (request.getParameter("type").equals("add")) {
                    service.insert(email, true, firstName, lastName, password, role);
                } else {
                    service.update(email, true, firstName, lastName, password, role);
                }
            }
            List<User> users = service.getAll();
            request.setAttribute("users", users);
            this.getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
            
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
