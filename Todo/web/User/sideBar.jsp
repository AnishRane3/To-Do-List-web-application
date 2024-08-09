<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 	<style>
	h5.text-center {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        }
        .active-logout {
            color: red !important; 
        }
	</style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col s2">
                    
                
        <ul class="sidenav sidenav-fixed"  id="mySidenav">
            <li class="center-align">
                <img class="img-fluid rounded-circle" src="../img/person2.png" alt="userimg" style="padding:10px;margin-top: 20px;border-radius: 100%;border: 2px solid #07423f;">
                <h5 class="text-center" style="color:#07423f">Welcome</h5>
                
                <% String email = (String) session.getAttribute("userEmail"); %>
                
                <h5 class="text-center" style="margin-left: 10px; padding-bottom:10px;color:#07423f"><%= email %></h5>
            </li>
            <li class="bold <% if(request.getRequestURI().endsWith("dashboard.jsp")){ %> active<%}%>" ><a  href="dashboard.jsp"  style="color:#07423f"><i class="material-icons"  style="color:#07423f">dashboard</i>Dashboard</a></li>
            <li class="bold <% if(request.getRequestURI().endsWith("addtask.jsp")){ %> active<%}%>"><a href="addtask.jsp"  style="color:#07423f"><i class="material-icons"  style="color:#07423f">playlist_add</i>Add Tasks</a></li>
            <li class="bold <% if(request.getRequestURI().endsWith("managetask.jsp")){ %> active<%}%>"><a href="managetask.jsp"  style="color:#07423f"><i class="material-icons"  style="color:#07423f">reorder</i>Manage Tasks</a></li>
            <li class="bold <% if(request.getRequestURI().endsWith("givereview.jsp")){ %> active<%}%>"><a href="givereview.jsp"  style="color:#07423f"><i class="material-icons"  style="color:#07423f">rate_review</i>Give Review</a></li>
<!--            <li class="bold <% if(request.getRequestURI().endsWith("myaccount.jsp")){ %> active<%}%>"><a href="myaccount.jsp"  style="color:#07423f"><i class="material-icons"  style="color:#07423f">account_box</i>My Account</a></li>-->
            <li><a href="../login.jsp" class="btn" style="background-color:#07423f;color:#fff;">Logout</a></li>
        </ul>
                <script>
                </script>
                </div>
                <div class="col s10">

