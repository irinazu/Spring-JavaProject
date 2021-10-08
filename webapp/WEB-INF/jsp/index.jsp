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
<body >
<div class="wrap" >

<ul class="main-menu" >

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




<div class="inwrap" >
<c:forEach items="${allProduct}" var="product">
<div class="card" style="width: 18rem;">
  <img src="<c:url value="${product.src_image}"/>" class="card-img-top" alt="image">
  <div class="card-body">
    <h5 class="card-title">${product.name}</h5>
    <p class="card-text">${product.description}</p>

      <form action="/item" method="get">
        <input type="hidden" name="productId" value="${product.id}"/>
        <button type="submit" class="btn btn-primary">О товаре</button>
      </form>

    <form action="/like" method="get">
      <input type="hidden" name="productId" value="${product.id}"/>
      <button type="submit" class="likeButton" style="background: none;border: none;margin-top: 20px; :ho"><img src="/resources/images/heart.png" > </button>

    </form>

    <sec:authorize access="hasRole('ADMIN')">
      <form action="/update" method="GET">
        <input type="hidden" name="productId" value="${product.id}"/>
        <input type="hidden" name="action" value="update"/>
        <button type="submit" class="btn btn-primary" style="margin-top: 10px">Обновить</button>
      </form>


    </sec:authorize>


  </div>
</div>
</c:forEach>
</div>


<br>
  <br>
  <br>
<div class="inwrapPagination">
<div class="paginationPage">Total Item: ${totalItems}-Page ${currentPage} of ${totalPages}</div>
  <br>

  <nav aria-label="Page navigation example">
    <ul class="pagination">
<c:choose>
  <c:when test="${currentPage>1}">
    <li class="page-item"><a class="page-link" href="/page/${currentPage-1}">Назад</a></li>

  </c:when>
  <c:otherwise>
    <li class="page-item disabled">
      <a class="page-link" href="#" tabindex="-1">Назад</a>
    </li>
  </c:otherwise>
</c:choose>


<c:if test="${totalPages<=10}">
<c:forEach end="${totalPages}" begin="1" varStatus="loop">
  <li class="page-item"><a class="page-link" href="/page/${loop.begin+loop.count-1}">${loop.begin+loop.count-1}</a></li>

</c:forEach>
</c:if>

<c:if test="${totalPages>10}">
  <c:if test="${currentPage<=5||currentPage>totalPages-4}">
    <c:forEach end="${5}" begin="1" varStatus="loop">

      <li class="page-item"><a class="page-link" href="/page/${loop.begin+loop.count-1}">${loop.begin+loop.count-1}</a></li>
    </c:forEach>

    <li class="page-item"><a class="page-link" href="/page/6">...</a></li>


    <c:forEach end="${totalPages}" begin="${totalPages-4}" varStatus="loop">
      <li class="page-item"><a class="page-link" href="/page/${loop.begin+loop.count-1}">${loop.begin+loop.count-1}</a></li>

    </c:forEach>
  </c:if>

  <c:if test="${currentPage>5&&currentPage<totalPages-4}">

    <li class="page-item"><a class="page-link" href="/page/${currentPage-5}">...</a></li>
    <c:forEach end="${currentPage+4}" begin="${currentPage-4}" varStatus="loop">
      <li class="page-item"><a class="page-link" href="/page/${loop.begin+loop.count-1}">${loop.begin+loop.count-1}</a></li>

    </c:forEach>
    <li class="page-item"><a class="page-link" href="/page/${currentPage+5}">...</a></li>

  </c:if>

</c:if>

<c:choose>
  <c:when test="${currentPage<totalPages}">
    <li class="page-item"><a class="page-link" href="/page/${currentPage+1}">Вперед</a></li>

  </c:when>
  <c:otherwise>
    <li class="page-item disabled">
      <a class="page-link" href="#" tabindex="-1">Вперед</a>
    </li>
  </c:otherwise>
</c:choose>
    </ul>
  </nav>

</div>
</div>
<footer style="height: 50px; background-color: #9da3b0;margin-top: 100px"></footer>
</body>
</html>