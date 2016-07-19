<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/16/2015
  Time: 10:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete product</title>
</head>
<body>
<form action="delete_product_by_sku_result.jsp" method="post">
  <p>Enter product sku: <input type="number" name="productSku"/></p>

  <p><input type="submit" value="DELETE FROM DATABASE"/></p>
</form>
</body>
</html>
