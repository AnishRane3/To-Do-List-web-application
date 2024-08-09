<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%

    List<String> motivationalQuotes = new ArrayList<String>();
    motivationalQuotes.add("Believe you can. -Theodore Roosevelt");
    motivationalQuotes.add("It always seems impossible until it's done. -Nelson Mandela");
    motivationalQuotes.add("Love what you do. -Steve Jobs");
    motivationalQuotes.add("Courage to continue. -Winston Churchill");

    Random random = new Random();
    int randomIndex = random.nextInt(motivationalQuotes.size());
    String selectedQuote = motivationalQuotes.get(randomIndex);
%>
<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "");

        String user_Id = session.getAttribute("userId").toString();
        String user_name = session.getAttribute("userName").toString();
        String user_email = session.getAttribute("userEmail").toString();
        

        String completedTasksQuery = "SELECT COUNT(*) AS completedTasks FROM todolist_tbl WHERE user_Id = ? AND status = 1";

        String incompleteTasksQuery = "SELECT COUNT(*) AS incompleteTasks FROM todolist_tbl WHERE user_Id = ? AND status = 0";

        preparedStatement = connection.prepareStatement(completedTasksQuery);
        preparedStatement.setString(1, user_Id);
        resultSet = preparedStatement.executeQuery();
        int completedTasksCount = 0;
        if (resultSet.next()) {
            completedTasksCount = resultSet.getInt("completedTasks");
        }

        preparedStatement = connection.prepareStatement(incompleteTasksQuery);
        preparedStatement.setString(1, user_Id);
        resultSet = preparedStatement.executeQuery();
        int incompleteTasksCount = 0;
        if (resultSet.next()) {
            incompleteTasksCount = resultSet.getInt("incompleteTasks");
        }
%>
<jsp:include page="sideBar.jsp"></jsp:include>
<html>
    <head>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <title>Todo-List | Dashboard</title>
    </head>
    <body>
        <div class="row center-align">
           <h4 style="color: #07423f; margin-top: 100px;text"><B><%= selectedQuote %></B></h4>
           <hr style="padding: 0.1px;background-color:#07423f ">
        </div>
        <div class="card" style="background-color: #a1e1e1;border-radius: 10px; margin-top: 50px;padding: 30px">
            <div class="row">
                <div class="col s4">
                    <div class="left-align">
                        <h5 style='margin-top:20px;color: #07423f;margin-left: 15px'>Account ID : <%= user_Id %></h5>
                    </div>
                </div>
                <div class="col s11">
                    <div class="left-align">
                        <h5 style='color:#07423f;margin-left:15px'>Name : <%= user_name %> </h5>
                    </div>
                </div>
            </div>
            <div class="left-align">
                <h5 style='padding-bottom: 30px;color:#07423f;margin-left: 15px;margin-top: -1px'>Email ID : <%= user_email %></h5>
            </div>
        </div>
            <div class="col s6">
                <div class="card"  style="background-color: buttonhighlight;padding:5px;margin-top: 20px;">
                    <h5 class="center-align" style="color: green;">No. of Completed Tasks</h5>
                    <div class="card-content center-align" style="color: green;"><h3><%= completedTasksCount %></h3></div>
                </div>
            </div>
            
            <div class="col s6">
                <div class="card"  style="background-color: buttonhighlight;padding:5px;margin-top: 20px;">
                    <h5 class="center-align" style="color: red;">No. of Incomplete Tasks</h5>
                    <div class="card-content center-align" style="color: red;"><h3><%= incompleteTasksCount %></h3></div>
                </div>
            </div>

        <script>
            $(document).ready(function () {
            });
        </script>
    </body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
