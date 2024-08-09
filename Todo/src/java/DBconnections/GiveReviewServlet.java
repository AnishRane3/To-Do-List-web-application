package DBconnections;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/GiveReviewServlet")
public class GiveReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");

        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");

        
        Connection connection = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String jdbcUrl = "jdbc:mysql://localhost:3306/todolist";
            String dbUsername = "root";
            String dbPassword = "";

            connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            String sql = "INSERT INTO feedback_tbl (email_id, subject, description) VALUES (?, ?, ?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, subject);
            pstmt.setString(3, description);
            int rowsAffected = pstmt.executeUpdate();
	    pstmt.close();
            connection.close();
 	    if (rowsAffected > 0) {
                String errorMessage = "Feedback send Successfully";
                request.setAttribute("error", false);
                request.setAttribute("errorMessage", errorMessage);
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("alert('" + errorMessage + "');");
                response.getWriter().println("window.location.href='User/givereview.jsp';");
                response.getWriter().println("</script>");
            } else {
                String errorMessage = "Sorry, Failed to send feedback";
                request.setAttribute("error", true);
                request.setAttribute("errorMessage", errorMessage); 
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("alert('" + errorMessage + "');");
                response.getWriter().println("window.location.href='';");
                response.getWriter().println("</script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();

        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
