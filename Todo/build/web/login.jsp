<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/sign_in_up.css">
    <title>Todo-List | Let's make your to-dos sparkle!</title>
</head>

<body>

    <div class="container" id="container">
        <div class="form-container sign-up">
            <form action="RegisterServlet" method="post">
                <h1>Create Account</h1>
                <input type="text" placeholder="Name" name="name" required>
                <input type="email" placeholder="Email" name="email" required>
                <input type="password" placeholder="Password" min=6 max=20 name="password" id="password" required>
                <span id="eyeToggleSignUp" class="eye-toggle fa fa-eye" style="margin-left: 250px;font-size: 17px;margin-top: -25px;color:#454444"></span>
                <button type="submit">Sign Up</button>
                
            </form>
        </div>
        <div class="form-container sign-in">
            <form action="LoginServlet" method="post">
                <h1>Sign In</h1>
                <input type="email" placeholder="Email" name="loginEmail" required>
                <input type="password" placeholder="Password" name="loginPassword" id="loginPassword" required>     
                <span id="eyeToggleSignIn" class="eye-toggle fa fa-eye" style="margin-left: 250px;font-size: 17px;margin-top: -25px;color:#454444"></span>
                <a href="forgotPassword.jsp" style="margin-top:20px">Forgot Your Password?</a>
                
                <button type="submit" style="margin-top: 40px !important;">Sign In</button><br>
            </form>
        </div>
        <div class="toggle-container">
            <div class="toggle">
                <div class="toggle-panel toggle-left">
                    <h1>Already have a account?</h1>
                    <p>Log in now, take charge of your to-dos!</p>
                        <button class="hidden" id="login">Sign In</button>
                </div>
                <div class="toggle-panel toggle-right">
                    <h1>Hello, Welcome!</h1>
                    <p>Ready to transform your tasks into triumphs? Join us now!</p>
                    <button class="hidden" id="register">Sign Up</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const container = document.getElementById('container');
        const registerBtn = document.getElementById('register');
        const loginBtn = document.getElementById('login');

        registerBtn.addEventListener('click', () => {
            container.classList.add("active");
        });

        loginBtn.addEventListener('click', () => {
            container.classList.remove("active");
        });

    
    document.addEventListener('DOMContentLoaded', function () {
        const eyeToggleSignUp = document.getElementById('eyeToggleSignUp');
        const passwordFieldSignUp = document.getElementById('password');
        
        const eyeToggleSignIn = document.getElementById('eyeToggleSignIn');
        const loginPasswordField = document.getElementById('loginPassword');

        console.log(eyeToggleSignUp, passwordFieldSignUp, eyeToggleSignIn, loginPasswordField); 

        eyeToggleSignUp.addEventListener('click', () => {
            togglePasswordVisibility(passwordFieldSignUp, eyeToggleSignUp);
        });

        eyeToggleSignIn.addEventListener('click', () => {
            togglePasswordVisibility(loginPasswordField, eyeToggleSignIn);
        });

        function togglePasswordVisibility(passwordField, eyeToggle) {
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeToggle.classList.remove('fa-eye');
                eyeToggle.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeToggle.classList.remove('fa-eye-slash');
                eyeToggle.classList.add('fa-eye');
            }

            console.log('Password field type:', passwordField.type); 
        }
    });
    </script>
</body>
</html>
