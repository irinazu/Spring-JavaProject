<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Регистрация</title>
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

<body>
<sec:authorize access="isAuthenticated()">
  <% response.sendRedirect("/"); %>
</sec:authorize>




<div id="login-card" class="card">
  <div class="card-body">
    <h2 class="text-center">Регистрация</h2>
    <br>

      <form:form method="POST" modelAttribute="userForm" >
      <div class="form-group">
        <form:input type="text" path="username" placeholder="Имя"
                    autofocus="true" class="form-control"></form:input>
        <form:errors path="username"></form:errors>
          ${usernameError}
      </div>
      <div class="form-group">
        <form:input type="password" path="password" placeholder="Пароль" class="form-control"></form:input>
      </div>
      <div class="form-group">
        <form:input type="password" path="passwordConfirm"
                    placeholder="Подтвердите пароль"  class="form-control"></form:input>
        <form:errors path="password"></form:errors>
          ${passwordError}
      </div>
      <button type="submit" id="button" class="btn btn-primary deep-purple btn-block ">Зарегестрироваться</button>
      <br>
      <br>

      </form:form>
  </div>
</div>
</body>
</html>