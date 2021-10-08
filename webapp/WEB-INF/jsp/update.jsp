<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Log in with your account</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/createUpdateAdmin.css">

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

<form enctype="multipart/form-data" action="/update" method="POST" modelAttribute="product">
    <input type="hidden" name="id" value="${product.id}"/>

    <br>
    <label for="productN">Название</label>
    <input type="text" name="name" id="productN" value="${product.name}" required>

    <br>
    <label for="productB">Бренд</label>
    <input type="text" name="brand" id="productB" value="${product.brand}" required>

    <br>
    <br>
    <c:if test="${product.category=='softToys'}">
        <p>Категория: Мягкие игрушки </p>
    </c:if>
    <c:if test="${product.category=='constructor'}">
        <p>Категория: Конструкторы </p>
    </c:if>
    <c:if test="${product.category=='doll'}">
        <p>Категория: Куклы </p>
    </c:if>
    <div style="flex-wrap:wrap ;width: 20%;border: solid;border-width: 2px;border-color: #cccccc;padding: 20px">

        <p>
            <label for="create">Мягкие игрушки</label>
            <input type="checkbox" name="category" id="create" value="softToys">
        </p>
        <p>
            <label for="take">Конструкторы</label>
            <input type="checkbox" name="category" path="category" id="take" value="constructor">
        </p>
        <p>
            <label for="give">Куклы</label>
            <input type="checkbox" name="category" path="category"id="give" value="doll">
        </p>
    </div>

    <br>
    <br>
    <img src="<c:url value="${product.src_image}"/>" alt="image">
    <br>
    <br>
    <input type="file" name="file" accept="image/jpeg,image/png" >
    <input type="hidden" name="src_image" value="${product.src_image}"/>
    <br>
    <br>
    <br>
    <label for="productD">Описание</label>
    <input type="text" name="description" id="productD" value="${product.description}" required>

    <br>
    <label for="productCo">Количество</label>
    <input type="text" name="count" id="productCo" value="${product.count}" required>

    <br>
    <label for="productP">Цена руб.</label>
    <input type="text" name="price" id="productP" value="${product.price}" required>
    <br>
    <button type="submit">Обновить</button>
</form>

</div>
<footer style="height: 50px; background-color: #9da3b0;margin-top: 100px"></footer>
</body>
</html>
