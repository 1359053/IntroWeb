<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.ProductJspGui" %>
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
<%
    int productSku = Integer.parseInt(request.getParameter("productSku"));
    ProductDao pd = new ProductDao();

    String rs = (pd.deleteBySku(productSku)) ? "Delete successfully." : "Delete failed.";
    out.println(rs);
    out.println("<br/>");

    List<Product> products = pd.getAll();
    out.println(ProductJspGui.ToString(products));

%>
</body>
</html>
