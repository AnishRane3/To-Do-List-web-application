package DBconnections;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendTaskMailServlet")
public class SendTaskMailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail != null && !userEmail.isEmpty()) {
            try {
            
                Class.forName("com.mysql.cj.jdbc.Driver");

              
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "");
                String user_Id = session.getAttribute("userId").toString();

              
                String sqlQuery = "SELECT * FROM todolist_tbl WHERE user_id = ? ORDER BY creation_time DESC";
                PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, user_Id);
                ResultSet resultSet = preparedStatement.executeQuery();

                
                StringBuilder emailContent = new StringBuilder();
                emailContent.append("<h2>Your Task List</h2>");

                while (resultSet != null && resultSet.next()) {
                    
                    String taskName = resultSet.getString("task_name");
                    String taskDescription = resultSet.getString("task_description");
                    String dueDate = resultSet.getString("due_date");
                    String status = resultSet.getString("status");
                    String statusLabel = "Incomplete";

                    if ("1".equals(status)) {
                        statusLabel = "Complete";
                    }

                   
                    emailContent.append("<p><strong>Task Name:</strong> ").append(taskName).append("</p>");
                    emailContent.append("<p><strong>Description:</strong> ").append(taskDescription).append("</p>");
                    emailContent.append("<p><strong>Due Date:</strong> ").append(dueDate).append("</p>");
                    emailContent.append("<p><strong>Status:</strong> ").append(statusLabel).append("</p><br>");
                   
                }

                
                resultSet.close();
                preparedStatement.close();
                connection.close();

                
                sendEmail(userEmail, "Your Task List", emailContent.toString());

                out.println("Task data sent to your email.");

            } catch (Exception e) {
                e.printStackTrace();
//                out.println("Error sending email. Please try again.");
            }
        } else {
//            out.println("User email not found.");
        }
    }

    private void sendEmail(String to, String subject, String body) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.port", "465");

        javax.mail.Session session = javax.mail.Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication("nmitdfriendsdrive@gmail.com", "bwgcbejszrtyhmpz");
            }
        });
        String senderName = "tododev";
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress("nmitdfriendsdrive@gmail.com",senderName));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setContent(body, "text/html");

        Transport.send(message);
    }
}
