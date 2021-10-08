<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Log in with your account</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/item.css">
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

    <div class="wrap_block">
            <div class="block_forimg">
                <img src="<c:url value="${product.src_image}"/>" class="card-img-top" alt="image">
            </div>

            <div class="block_forDescr">
                <br>
                <p>Наименование: ${product.name}</p>

                <br>
                <p>Бренд: ${product.brand}</p>

                <br>
                <p>Описание: ${product.description}</p>

                <br>
                <p>Рублей: ${product.price}</p>
                <sec:authorize access="isAuthenticated()">
                    <a href="/cabinet"></a>
                </sec:authorize>

                <sec:authorize access="isAuthenticated()">
                    <form action="/" method="POST">
                        <input type="hidden" name="productId" value="${product.id}"/>
                        <button type="submit" class="btn btn-primary">В корзину</button>
                    </form>
                </sec:authorize>

                <sec:authorize access="!isAuthenticated()">
                    <form action="/login" method="get">
                        <button type="submit" class="btn btn-primary">В корзину</button>
                    </form>
                </sec:authorize>
            </div>
        </div>

        <div class="createComments">
            <form enctype="multipart/form-data" action="/createComment" method="post">
                <input type="hidden" name="productId" value="${product.id}"/>
                <textarea id="com" name="textComment" required></textarea>
                <br>
                <input type="file" name="file" accept="image/jpeg,image/png">
                <sec:authorize access="!isAuthenticated()">
                    <button class="btn btn-primary" disabled>Комментировать</button>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <button class="btn btn-primary" >Комментировать</button>
                </sec:authorize>

            </form>
        </div>
        <div class="blockComments">
            <c:forEach items="${productComments}" var="commentNew">
                <div class="comments">
                    <div style="justify-content: center">${commentNew.date}</div>
                    <div>Пользователь: ${commentNew.username}</div>
                    <c:if test="${commentNew.src_img_user!='no_img'}">
                        <img src="<c:url value="${commentNew.src_img_user}"/>" alt="image" style="width:200px ">
                    </c:if>

                    <div>${commentNew.comment}</div>
                    <sec:authorize access="hasRole('ADMIN')">
                        <form action="/deleteComment" method="get">
                            <input type="hidden" name="commentId" value="${commentNew.id}">
                            <input type="hidden" name="productId" value="${commentNew.product.id}"/>
                            <button class="btn btn-primary" >Удалить</button>
                        </form>
                    </sec:authorize>
                </div>
            </c:forEach>
        </div>
    </div>
<footer style="height: 50px; background-color: #9da3b0;margin-top: 100px"></footer>
</body>
</html>
