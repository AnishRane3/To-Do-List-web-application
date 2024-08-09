package DBconnections;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/NewPasswordServlet")
public class NewPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        String newPassword = request.getParameter("password");
        RequestDispatcher dispatcher = null;
        if (newPassword != null) {

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = "jdbc:mysql://localhost:3306/todolist";
                String username = "root";
                String dbPassword = "";

                try (Connection connection = DriverManager.getConnection(url, username, dbPassword)) {
                    String query = "UPDATE user_tbl SET password = ? WHERE email = ?";
                    try (PreparedStatement pst = connection.prepareStatement(query)) {
                        pst.setString(1, newPassword);
                        pst.setString(2, (String) session.getAttribute("email"));
                        int rowCount = pst.executeUpdate();
                        if (rowCount > 0) {
                            String errorMessage = "Password reset Successfully.";
                            request.setAttribute("error", false);
                            request.setAttribute("errorMessage", errorMessage);
                            response.setContentType("text/html");
                            response.getWriter().println("<script>");
                            response.getWriter().println("alert('" + errorMessage + "');");
                            response.getWriter().println("window.location.href='login.jsp';");
                            response.getWriter().println("</script>");
                        } 
                        else 
                        {        
                            String errorMessage = "Password reset failed.";
                            request.setAttribute("error", true);
                            request.setAttribute("errorMessage", errorMessage);
                            response.setContentType("text/html");
                            response.getWriter().println("<script>");
                            response.getWriter().println("alert('" + errorMessage + "');");
                            response.getWriter().println("window.location.href='login.jsp';");
                            response.getWriter().println("</script>");
                        }
                        dispatcher.forward(request, response);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}
