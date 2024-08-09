package DBconnections;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("loginEmail");
        String password = request.getParameter("loginPassword");

        try (PrintWriter out = response.getWriter()) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/todolist";
            String username = "root";
            String dbPassword = "";

            try (Connection connection = DriverManager.getConnection(url, username, dbPassword)) {

                String query = "SELECT * FROM user_tbl WHERE email=? AND password=?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, email);
                    preparedStatement.setString(2, password);

                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        if (resultSet.next()) {
                          
                            int userId = resultSet.getInt("id");
                            String userName = resultSet.getString("name");

                            HttpSession session = request.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("userName", userName);
                            session.setAttribute("userEmail", email);


                            response.sendRedirect("User/dashboard.jsp");
                        } else {

                            String errorMessage = "Invalid Login Credentials.";
                            request.setAttribute("error", true);
                            request.setAttribute("errorMessage", errorMessage);
                            response.setContentType("text/html");
                            response.getWriter().println("<script>");
                            response.getWriter().println("alert('" + errorMessage + "');");
                            response.getWriter().println("window.location.href='login.jsp';");
                            response.getWriter().println("</script>");
                        }
                    }
                }
            } catch (SQLException e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
