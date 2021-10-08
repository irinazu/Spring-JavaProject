<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE HTML>
<html>
<head>
  <title>Главная</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
  <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/menu.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


</head>
<body>
<div class="wrap">

  <ul class="main-menu">

    <sec:authorize access="!isAuthenticated()">
      <li><a href="/login">Войти</a></li>
      <li><a href="/registration">Зарегистрироваться</a></li>
    </sec:authorize>

    <li class="active"><a href="/">Toys</a></li>

    <sec:authorize access="isAuthenticated()">
      <li><a href="/logout">Выйти</a></li>

    </sec:authorize>

    <sec:authorize access="hasRole('ADMIN')">
      <li><a href="/orderStatus">Заказы</a></li>
      <li><a href="/create">Добавить продукт</a></li>
      <li><a href="/admin">Пользователи</a></li>
    </sec:authorize>

    <sec:authorize access="hasRole('USER')&&!hasRole('ADMIN')">
      <li><a href="/cart">Корзина</a></li>
      <li><a href="/cabinet">Личный кабинет</a></li>

    </sec:authorize>

    <li class="menu-children">
      <a href="#url">Категории</a>
      <ul>
        <li><a href="/category/softToys">Мягкие игрушки</a></li>
        <li><a href="/category/constructor">Конструкторы</a></li>
        <li><a href="/category/doll">Куклы</a></li>
      </ul>
    </li>

    <li>
      <form action="/search" method="get">
        <input type="text" name="currentKey">
        <button type="submit" class="btn btn-primary">Искать</button>
      </form>
    </li>

    <li>${pageContext.request.userPrincipal.name}</li>
  </ul>

  <div style="margin-top: 50px">
    <table>
      <thead>
      <th>ID</th>
      <th>Имя</th>

      <th>Права</th>
      </thead>
      <c:forEach items="${allUsers}" var="user">
        <tr>
          <td>${user.id}</td>
          <td>${user.username}</td>

          <td>
            <c:forEach items="${user.roles}" var="role">${role.name}; </c:forEach>
          </td>
          <td>
            <form action="${pageContext.request.contextPath}/admin" method="post">
              <input type="hidden" name="userId" value="${user.id}"/>
              <input type="hidden" name="action" value="delete"/>
              <button type="submit" class="btn btn-primary">Удалить</button>
            </form>

          </td>

        </tr>
      </c:forEach>
    </table>
  </div>


</div>




</body>
</html>