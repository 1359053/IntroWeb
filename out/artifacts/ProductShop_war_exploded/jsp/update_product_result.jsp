<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.ProductJspGui" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/16/2015
  Time: 10:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    int productSku = Integer.parseInt(request.getParameter("productSku"));
    String productName = request.getParameter("productName");
    Product p = new Product(productSku, 0, 0, productName);

    ProductDao pd = new ProductDao();

    String rs = (pd.update(p)) ? "Update successfully." : "Update failed.";
    out.println(rs);
    out.println("<br/>");
    out.println("After update:<br/>");

    List<Product> products = pd.getAll();
    out.println(ProductJspGui.ToString(products));
%>
</body>
</html>
