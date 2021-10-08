<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Введите данные</title>

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

    <form method="POST" action="/order" modelAttribute="sporder">
        <h2>Введите данные</h2>
        <div class="wrap_2">
            <label for="name">Имя заказчика: </label>
            <input path="name" name="name" type="text" placeholder="Имя" id="name" required/>

            <br>
            <label for="surname">Фамилия заказчика:</label>
            <input path="surname" name="surname" type="text" placeholder="Фамилия" id="surname" required/>

            <br>
            <label for="Town">Город:</label>
            <input path="town" name="town" type="text" placeholder="Город" id="Town" required/>
            <br>
            <label for="house">Дом заказчика: </label>
            <input path="house" name="house" type="text" placeholder="Дом" id="house" autofocus="true" required/>
            <br>
            <label for="flat">Квартира заказчика: </label>
            <input path="flat" name="flat" type="text" placeholder="Квартира" id="flat" autofocus="true" required/>
            <br>
            <label for="index">Индекс заказчика: </label>
            <input path="index" name="index" type="text" placeholder="Индекс" id="index" autofocus="true" required pattern="[0-9]{6}"/>
            <br>
            <label for="ph">Телефон:</label>
            <input path="phone" name="phone" type="text" placeholder="+8-xxx-xxx-xxxx" id="ph" required pattern="8[0-9]{10}"/>
            <button type="submit" class="btn btn-primary">Заказать</button>
            <br>

        </div>
    </form>
</div>
<footer style="height: 50px; background-color: #9da3b0;margin-top: 100px"></footer>
</body>
</html>
