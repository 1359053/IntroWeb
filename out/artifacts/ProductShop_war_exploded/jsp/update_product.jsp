<%@ page import="com.mypackage.ProductJspGui" %>
<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/16/2015
  Time: 10:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<form action="update_product_result.jsp" method="post">
    <p>Enter product SKU: <input type="number" name="productSku"/></p>

    <p>Enter product name: <input type="text" name="productName"/></p>

    <p><input type="submit" value="UPDATE PRODUCT"/></p>

    <%
        ProductDao pd = new ProductDao();
        List<Product> products = pd.getAll();
        out.println("Before update:<br/>");
        out.println(ProductJspGui.ToString(products));
    %>
</form>
</body>
</html>
