<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Log in with your account</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/item.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/menu.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
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

<div>
    <form method="get" action="/mycomments">
        <button type="submit" class="btn btn-primary" style="width: 100%;margin-top: 40px">Отзывы</button>
    </form>

</div>
    <div>
        <form method="get" action="/alllike">
            <button type="submit" class="btn btn-primary" style="width: 100%;margin-top: 40px">Понравившиеся товары</button>
        </form>

    </div>

    <c:forEach items="${orders}" var="obj">
        <div class="wrap_block_order">

            <div class="orderContent">
                    <div class="info">
                        <div style="display: flex;width: 400px; justify-content: space-between">
                            <p>Заказ: №: ${obj.id}    </p>
                            <p>Дата: ${obj.date}</p>
                            <p>Статус: </p>
                        </div>
                    <div class="mini_order">
                        <p>Имя: ${obj.name}</p>
                        <p>Фамилия: ${obj.surname}</p>
                        <p>Телефон: +${obj.phone}</p>
                        <p>Город: ${obj.town}</p>
                        <p>Сумма: ${obj.price}</p>
                        <c:if test="${obj.step=='Создано'}">
                            <p style="background-color: crimson">Статус заказа: ${obj.step}</p>
                        </c:if>
                        <c:if test="${obj.step=='Принято в работу'}">
                            <p style="background-color: orange">Статус заказа: ${obj.step}</p>
                        </c:if>
                        <c:if test="${obj.step=='Передано в доставку'}">
                            <p style="background-color: yellow">Статус заказа: ${obj.step}</p>
                        </c:if>
                        <c:if test="${obj.step=='Ожидает в пункте выдачи'}">
                            <p style="background-color: lightgreen">Статус заказа: ${obj.step}</p>
                        </c:if>
                        <c:if test="${obj.step=='Получено'}">
                            <p style="background-color: #337AB7">Статус заказа: ${obj.step}</p>
                        </c:if>
                    </div>

                    <div class="gallery" style="display: flex;margin-top: 50px">
                        <c:forEach var="orders" items="${obj.neworders}">
                            <div class="paint" style="display: table-column;margin: 20px;">
                                <form action="/item" method="get">
                                    <input type="hidden" name="productId" value="${orders.product.id}">
                                    <button type="submit" class="button_order">
                                        <p>Название: ${orders.product.name}</p>
                                        <img src="<c:url value="${orders.product.src_image}"/>" style="width: 150px; height: 150px" alt="image">
                                    </button>
                                </form>

                            </div>

                        </c:forEach>
                    </div>





                 </div>
            </div>
        </div>
    </c:forEach>
</div>
<footer style="height: 50px; background-color: #9da3b0;margin-top: 100px"></footer>
</body>
</html>
