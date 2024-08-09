<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Todo-List | Give Review</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</head>
<style>
        body {
            padding-top: 20px;
        }
        .form-container {
            max-width: 850px;
            margin: 20px auto;
            margin-top: 100px;
            padding: 50px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: #fff;
        }
    </style>
<body>
<jsp:include page="sideBar.jsp"></jsp:include>
<div class="form-container">
        <h4 style="color:#07423f">Feedback Form</h4>
        <form action="../GiveReviewServlet" method="post">
            <div class="input-field">
                <input type="text" name="subject" id="subject" required>
                <label for="subject">Feedback Subject</label>
            </div>
            <div class="input-field">
                <textarea name="description" id="description" class="materialize-textarea" required></textarea>
                <label for="description">Feedback Description</label>
            </div>
            <button class="btn waves-effect" style="background-color:#a1e1el;color:#fff ;margin-top:20px" type="submit" name="action">Give Feedback</button>
        </form>
    </div>
</body>
</html>

