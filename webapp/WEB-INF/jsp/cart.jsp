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
<div class="wrap" style="position: relative;">
    <c:set var="generalCount" scope="session" value="${0}"></c:set>

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

    <div class="wrap_block" style="flex-wrap: wrap; width: 70%;margin-right: auto;margin-left: auto">
        <c:if test="${empty carts}">
            <div style="margin: 0px 50px 50px 0px">Корзина пуста</div>

        </c:if>
    <c:if test="${not empty carts}">

        <c:forEach items="${carts}" var="cart">
            <div class="block_first">
            <div class="card" style="width: 18rem;" id="innerblock">
                <img src="<c:url value="${cart.product.src_image}"/>" class="card-img-top" alt="image">
                <div class="card-body">
                    <h5 class="card-title">${cart.product.name}</h5>
                    <p class="card-text">${cart.product.description}</p>

                    <form action="/cart" method="POST">
                        <input type="hidden" name="id" value="${cart.product.id}"/>
                        <input type="hidden" name="action" value="delete"/>
                        <button type="submit" class="btn btn-primary" id="delete">Удалить</button>
                    </form>

                    <div class="but">
                        <form action="/cart" method="POST">
                            <input type="hidden" name="id" value="${cart.product.id}"/>
                            <input type="hidden" name="action" value="plus"/>
                            <button type="submit" class="btn btn-primary" id="plusBut">+</button>
                        </form>
                        <form action="/cart" method="POST">
                            <input type="hidden" name="id" value="${cart.product.id}"/>
                            <input type="hidden" name="action" value="minus"/>
                            <button type="submit" class="btn btn-primary" id="minusBut">-</button>
                        </form>
                    </div>
                </div>
            </div>
            <div id="innerblock">
                <p>Количество: ${cart.countforcart}</p>
                <p>Сумма за товар: ${cart.priceincart} руб.</p>
            </div>
            <c:set var="generalCount" value="${generalCount+cart.priceincart}"/>
            </div>

            </c:forEach>
        </c:if>

        <c:out value="Сумма: ${generalCount} руб."/>

    <c:if test="${generalCount!=0}">
        <form action="/cart" method="POST">
            <input type="hidden" name="sum" value="${generalCount}">
            <input type="hidden" name="id" value="${product.userid}"/>
            <input type="hidden" name="action" value="buy"/>
            <button type="submit" class="btn btn-primary" style="margin: 0px 50px 0px 50px">Оформить заказ</button>
        </form>
    </c:if>
        
            </div>
         </div>
    </div>
</div>
<footer style="height: 50px; background-color: #9da3b0;margin-top: 100px; "></footer>
</body>
</html>