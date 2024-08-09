<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todo-List | Manage Task</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>
        body {
            padding-top: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="sideBar.jsp"></jsp:include>

<div class="container" style="margin-top:50px;width:110%;">
    <h4 style="color:#07423f">Manage Task</h4>

    <table class="striped" style="color:#07423f">
        <thead>
            <tr>
                <th>Task</th>
                <th>Description</th>
                <th>Due Date</th>
                <th>Priority</th>
                <th>Status</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <% 
                Connection connection = null;
                PreparedStatement preparedStatement = null;
                PreparedStatement delpreparedStatement = null;
                PreparedStatement Fin_updatepreparedStatement = null;
                ResultSet resultSet = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "");

                    String user_Id = session.getAttribute("userId").toString();

                    String sqlQuery = "SELECT * FROM todolist_tbl WHERE user_id = ? ORDER BY creation_time DESC";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setString(1, user_Id);

                    resultSet = preparedStatement.executeQuery();

		   int delQuery;

                    if (request.getParameter("taskId") != null) {
                        String deleteSqlQuery = "DELETE FROM todolist_tbl WHERE task_id=? AND user_id=?";
                        delpreparedStatement = connection.prepareStatement(deleteSqlQuery);
                        delpreparedStatement.setString(1, request.getParameter("taskId"));
                        delpreparedStatement.setString(2, user_Id); 
                        delQuery = delpreparedStatement.executeUpdate();

                        if (delQuery > 0) {
                            String errorMessage = "Task deleted successfully";
                            request.setAttribute("error", true);
                            request.setAttribute("errorMessage", errorMessage);
                            response.setContentType("text/html");
                            response.getWriter().println("<script>");
                            response.getWriter().println("alert('" + errorMessage + "');");
                            response.getWriter().println("window.location.href='managetask.jsp';");
                            response.getWriter().println("</script>");
                        } else {
                           
                            String errorMessage = "Task not found or something went wrong.";
                            request.setAttribute("error", true);
                            request.setAttribute("errorMessage", errorMessage);
                            response.setContentType("text/html");
                            response.getWriter().println("<script>");
                            response.getWriter().println("alert('" + errorMessage + "');");
                            response.getWriter().println("</script>");
                        }
                    }
                    
                     int Finsh_update_Query;

                    if (request.getParameter("FtaskId") != null) { 
                        String Finish_SqlQuery = "UPDATE todolist_tbl SET status=1 WHERE task_id=? AND user_id=?";
                        Fin_updatepreparedStatement = connection.prepareStatement(Finish_SqlQuery);
                        Fin_updatepreparedStatement.setString(1, request.getParameter("FtaskId"));
                        Fin_updatepreparedStatement.setString(2, user_Id); 
                        Finsh_update_Query = Fin_updatepreparedStatement.executeUpdate();

                        if (Finsh_update_Query > 0) {
                            String errorMessage = "Task Marked as completed";
                            request.setAttribute("error", true);
                            request.setAttribute("errorMessage", errorMessage);
                            response.setContentType("text/html");
                            response.getWriter().println("<script>");
                            response.getWriter().println("alert('" + errorMessage + "');");
                            response.getWriter().println("window.location.href='managetask.jsp';");
                            response.getWriter().println("</script>");
                        } else {
                           
                            String errorMessage = "Task not found or something went wrong.";
                            request.setAttribute("error", true);
                            request.setAttribute("errorMessage", errorMessage);
                            response.setContentType("text/html");
                            response.getWriter().println("<script>");
                            response.getWriter().println("alert('" + errorMessage + "');");
                            response.getWriter().println("</script>");
                        }
                    }
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date currentDate = new Date();


                    while (resultSet != null && resultSet.next()) {
                       
                        String status = resultSet.getString("status");
                        Date dueDate = dateFormat.parse(resultSet.getString("due_date"));
                        boolean isDueDatePassed = LocalDate.now().isAfter(dueDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate());

                        
            %>          
                        <tr>
                            <td><%= resultSet.getString("task_name") %></td>
                            <td><%= resultSet.getString("task_description") %></td>
                            <td><%= resultSet.getString("due_date") %></td>
                            <td style="color:
                                <%= "high".equals(resultSet.getString("task_priority")) ? "red" :
                                   ("medium".equals(resultSet.getString("task_priority")) ? "blue" :
                                   ("low".equals(resultSet.getString("task_priority")) ? "green" : "")) %>;">
                                <%= resultSet.getString("task_priority") %>
                            </td>
                            <td>
                                <% if ("0".equals(resultSet.getString("status"))) { %>
                                    Incomplete
                                <% } else { %>
                                    Completed
                                <% } %>
                            </td>
                            <td>
                                <% if (isDueDatePassed && "0".equals(status)) { %>
                                    <a class="btn waves-effect waves-light red" style="cursor:not-allowed">Failed</a>
                                <% } else if ("0".equals(status)) { %>
                                    <a class="btn waves-effect waves-light teal" href="?FtaskId=<%=resultSet.getString("task_id")%>">Finish</a>
                                <% } else { %>
                                    <button class="btn grey" style="cursor:not-allowed">Finished</button>
                                <% } %>

                            </td>
                            <td>
                                <a class="btn-floating waves-effect waves-light red" href="?taskId=<%=resultSet.getString("task_id")%>">
                                    <i class="material-icons">delete</i>
                                </a>
                            </td>
                        </tr>
                        
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) {
                            resultSet.close();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    try {
                        if (preparedStatement != null) {
                            preparedStatement.close();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    try {
                        if (delpreparedStatement != null) {
                            delpreparedStatement.close();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    try {
                        if (connection != null) {
                            connection.close();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
        
    </table>
        <form action="../SendTaskMailServlet" method="post" target="hiddenFrame">
            <input type="submit" class="btn blue" style="margin-top: 50px;" value="Email Tasks List to Myself">
        </form>
        <iframe id="hiddenFrame" name="hiddenFrame" style="display: none;"></iframe>
        
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>
