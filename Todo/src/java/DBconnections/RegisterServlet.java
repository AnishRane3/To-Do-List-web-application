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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/todolist";
            String username = "root";
            String dbPassword = "";

            try (Connection connection = DriverManager.getConnection(url, username, dbPassword)) {
                if (isEmailExists(connection, email)) {
                    String errorMessage = "Email " + email + " already registered. Choose a different email.";
                    request.setAttribute("error", true);
                    request.setAttribute("errorMessage", errorMessage);
                    response.setContentType("text/html");
                    response.getWriter().println("<script>");
                    response.getWriter().println("alert('" + errorMessage + "');");
                    response.getWriter().println("window.location.href='login.jsp';");
                    response.getWriter().println("</script>");
                } else{
                String query = "INSERT INTO user_tbl (name, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, name);
                    preparedStatement.setString(2, email);
                    preparedStatement.setString(3, password);

                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
                        String errorMessage = "Registration Successful !";
                        request.setAttribute("error", false);
                        request.setAttribute("errorMessage", errorMessage);
                        response.setContentType("text/html");
                        response.getWriter().println("<script>");
                        response.getWriter().println("alert('" + errorMessage + "');");
                        response.getWriter().println("window.location.href='login.jsp';");
                        response.getWriter().println("</script>");
                    } else {
                        String errorMessage = "Registration Failed ";
                        request.setAttribute("error", false);
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
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    private boolean isEmailExists(Connection connection, String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM user_tbl WHERE email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        }
        return false;
    }
}
