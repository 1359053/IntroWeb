<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/15/2015
  Time: 10:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<form action="show_products_by_page_result.jsp" method="post">
    <p>Enter page number: <input type="number" name="pageNumber"/></p>
    <p>Enter number of products per page: <input type="number" name="productsPerPage"/></p>

    <p><input type="submit" value="SHOW PAGE OF PRODUCTS"/></p>
</form>
</body>
</html>
