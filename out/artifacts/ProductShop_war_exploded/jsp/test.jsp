<%@ page import="com.mypackage.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Product> list = ProductDao.getAll();
    request.setAttribute("list",list);
%>
<html>
<head>
    <title>YOUR CODE </title>
</head>
<body>
<c:forEach items="${list}" var="product">
    ${product.sku}<br/>
</c:forEach>
</body>
</html>