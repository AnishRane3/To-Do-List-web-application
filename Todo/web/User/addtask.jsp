<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="sideBar.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
    <title>Todo-List | Add Task</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    
    <style>
        .form-container {
            max-width: 850px;
            margin: 20px auto;
            margin-top: 100px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h4 style="color:#07423f">Add Task</h4>
        <form action="../AddTaskServlet" method="post">
            <div class="input-field">
                <input type="text" id="taskName" name="taskName" required>
                <label for="taskName">Task Name</label>
            </div>

            <div class="input-field">
                <textarea id="taskDescription" name="taskDescription" class="materialize-textarea" required></textarea>
                <label for="taskDescription">Task Description</label>
            </div>
            <div class="input-field">
                <input type="date" id="dueDate" name="dueDate" min="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" required>
                <label for="dueDate">Due Date</label>
            </div>

            <div class="input-field">
                <select id="priority" name="priority" required>
                    <option value="" disabled selected>Select Priority</option>
                    <option value="high">High</option>
                    <option value="medium">Medium</option>
                    <option value="low">Low</option>
                </select>
                <label for="priority">Priority</label>
            </div>

            <br>
            <button class="btn waves-effect" style="background-color:#a1e1el;color:#fff ;" type="submit" name="action">Add Task
                
            </button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

<script>
    $(document).ready(function(){
        $('select').formSelect();
        $('.datepicker').datepicker();
        
    });
    </script>
</body>
</html>
