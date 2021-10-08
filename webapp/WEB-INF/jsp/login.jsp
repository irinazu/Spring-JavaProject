<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Log in with your account</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Nunito:600,700,900" rel="stylesheet">

</head>

<body id="body">
<sec:authorize access="isAuthenticated()">
  <% response.sendRedirect("/"); %>
</sec:authorize>



<div id="login-card" class="card">
    <div class="card-body">
        <h2 class="text-center">Login form</h2>
        <br>
        <form method="POST" action="/login">
            <div class="form-group">
                <input name="username" type="text" placeholder="Имя" autofocus="true" class="form-control"/>
            </div>
            <div class="form-group">
                <input name="password" type="password" placeholder="Пароль" class="form-control"/>
            </div>
            <button type="submit" id="button" class="btn btn-primary deep-purple btn-block ">Submit</button>
            <br>
            <br>
            <a href="/registration">Зарегистрироваться</a>
        </form>
    </div>
</div>

</body>
</html>
