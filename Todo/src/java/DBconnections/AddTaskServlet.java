package DBconnections;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        int user_Id = (int) session.getAttribute("userId");

        String taskName = request.getParameter("taskName");
        String taskDescription = request.getParameter("taskDescription");
        String dueDate = request.getParameter("dueDate");
        String priority = request.getParameter("priority");

        try {
           
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/todolist";
            String username = "root";
            String dbPassword = "";

           
            Connection conn = DriverManager.getConnection(url, username, dbPassword);

            
            String query = "INSERT INTO todolist_tbl (user_id, task_name, task_description, due_date, task_priority, status, creation_time) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pstmt = conn.prepareStatement(query);

            
            pstmt.setInt(1, user_Id);
            pstmt.setString(2, taskName);
            pstmt.setString(3, taskDescription);
            pstmt.setString(4, dueDate);
            pstmt.setString(5, priority);
            pstmt.setInt(6, 0); 
            pstmt.setTime(7, new java.sql.Time(System.currentTimeMillis()));
            
            int rowsAffected = pstmt.executeUpdate();

            
            pstmt.close();
            conn.close();

            if (rowsAffected > 0) {
                String errorMessage = "Task added Successfully";
                request.setAttribute("error", false);
                request.setAttribute("errorMessage", errorMessage);
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("alert('" + errorMessage + "');");
                response.getWriter().println("window.location.href='User/addtask.jsp';");
                response.getWriter().println("</script>");
            } else {
                String errorMessage = "Sorry, Failed to add task";
                request.setAttribute("error", true);
                request.setAttribute("errorMessage", errorMessage); 
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("alert('" + errorMessage + "');");
                response.getWriter().println("window.location.href='';");
                response.getWriter().println("</script>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error: " + e.getMessage());
        }
    }
}
