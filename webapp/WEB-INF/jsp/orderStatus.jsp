<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Новости</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/blockcart.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/menu.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</head>
<body>
<div class="wrap" >

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
</div>



<div class="megaBlock" style="width: 70%;margin-left: auto;margin-right: auto;">
    <form action="/searchOrders" method="get" style="margin-top: 50px;justify-content: center;margin-left: auto;margin-right: auto;width: 30%">
        <input type="text" name="currentKeyOrder">
        <button type="submit" class="btn btn-primary">Искать</button>
    </form>
    <form action="/searchOrdersId" method="get" style="margin-top: 50px;justify-content: center;margin-left: auto;margin-right: auto;width: 30%">
        <input type="text" name="currentKeyOrderId" placeholder="По номеру">
        <button type="submit" class="btn btn-primary">Искать</button>
    </form>
<c:forEach var="order" items="${orders}">
    <div class="statusBlock" style="display: flex;margin-bottom: 50px;margin-top: 50px; padding: 30px;box-shadow: 0px 5px 10px 2px rgba(126,145,255,0.47) inset;">
        <form action="/orderStatus" method="POST">
            <div class="firstStatusBlock" style="display: flex;justify-content: space-between">
                <input type="hidden" name="id" value="${order.id}"/>
                <p style="margin: 20px 20px 20px 0px">№: ${order.id}</p>
                <p style="margin: 20px">Дата заказа: ${order.date}</p>
                <p style="margin: 20px">Имя заказчика: ${order.name}</p>
                <p style="margin: 20px">Фамилия заказчика: ${order.surname}</p>
                <p style="margin: 20px">Телефон заказчика: ${order.phone}</p>
                <p style="margin: 20px">Город заказчика: ${order.town}</p>
                <p style="margin: 20px">Дом заказчика: ${order.house}</p>
                <p style="margin: 20px">Квартира заказчика: ${order.flat}</p>
                <p style="margin: 20px">Индекс: ${order.index}</p>
            </div>
            <div class="firstStatusBlock" style="display: flex;justify-content: space-between">
                <c:if test="${order.step=='Создано'}">
                        <p style="background-color: crimson">Статус заказа: ${order.step}</p>
                </c:if>
                <c:if test="${order.step=='Принято в работу'}">
                    <p style="background-color: orange">Статус заказа: ${order.step}</p>
                </c:if>
                <c:if test="${order.step=='Передано в доставку'}">
                    <p style="background-color: yellow">Статус заказа: ${order.step}</p>
                </c:if>
                <c:if test="${order.step=='Ожидает в пункте выдачи'}">
                    <p style="background-color: lightgreen">Статус заказа: ${order.step}</p>
                </c:if>

            </div>
            <div class="firstStatusBlock">
                <p>
                    <label for="create">Создано</label>
                    <input type="checkbox" name="step" id="create" value="Создано">
                </p>
                <p>
                    <label for="take">Принято в работу</label>
                    <input type="checkbox" name="step" id="take" value="Принято в работу">
                </p>
                <p>
                    <label for="give">Передано в доставку</label>
                    <input type="checkbox" name="step" id="give" value="Передано в доставку">
                </p>
                <p>
                    <label for="wait">Ожидает в пункте выдачи</label>
                    <input type="checkbox" name="step" id="wait" value="Ожидает в пункте выдачи">
                </p>
                <p>
                    <label for="finale">Получено</label>
                    <input type="checkbox" name="step" id="finale" value="Получено">
                </p>
                <button type="submit" class="btn btn-primary">Обновить</button>
            </div>

        </form>
    </div>
</c:forEach>
</div>
<footer style="height: 50px; background-color: #9da3b0;margin-top: 100px; "></footer>
</body>
</html>