<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Reset Password | Todo-List</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/forgotpass.css">
</head>
<body>

<div class="container mt-5" id="container">
    <div class="row justify-content-center" >
        <div class="col-md-6">
            <div class="card" class="card">
                <div class="card-header" style="background-image: url('https://img.freepik.com/premium-photo/list-icon-notebook-with-completed-todo-list-3d-render_471402-428.jpg?size=626&ext=jpg&ga=GA1.1.1826414947.1699401600&semt=ais');">
                    <h4 style="color: #07423f;">Forgot Password</h4>
                </div>
                <div class="card-body">
                    <form action="ForgotPasswordServlet" method="post">
                        <div class="form-group">
                            
                            <input type="email" placeholder="Email" style="border-color:#07423f;"class="form-control" id="email" name="email" required><br>
                            <span style="color: #07423f;font-weight: 500">We'll send a verification code to this email if it's linked to Todo-List.</span>
                        </div>
                        <button type="submit">Next</button>
                        <a href="/Todo/login.jsp" class="backbtn">Back</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>

