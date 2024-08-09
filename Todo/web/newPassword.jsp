<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Todo-List | Reset Password</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/newpass.css">
</head>

<body>
    <div class="container mt-5" class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card" class="card">
                    <div class="card-body">
                        <h2 class="card-title text-center" style="color: #07423f;">Reset Password</h2>
                        <form action="NewPasswordServlet" method="post">
                            <div class="form-group">
                                <label for="password" style="color: #07423f;"   >New Password</label>
                                <input type="password" placeholder="New Password" class="form-control" id="password" name="password" id="password" required>
                                <div class="input-group-append">
                                     <span id="eyeToggle" class="eye-toggle fa fa-eye" style="margin-left: 460px;font-size: 19px;margin-top: -30px;color:#454444"></span>
                                </div>
                            </div>
                            <button type="submit" value="Reset" class="btn btn-block">Reset Password</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
        const eyeToggle = document.getElementById('eyeToggle');
        const Npassword = document.getElementById('password');

        eyeToggle.addEventListener('click', () => {
            togglePasswordVisibility(Npassword, eyeToggle);
        });
        function togglePasswordVisibility(passwordField, eyeToggle) {
            // Toggle password visibility
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeToggle.classList.remove('fa-eye');
                eyeToggle.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeToggle.classList.remove('fa-eye-slash');
                eyeToggle.classList.add('fa-eye');
            }

        }
    });


    </script>
</body>

</html>