<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductJspGui" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/15/2015
  Time: 11:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    int productsPerPage = Integer.parseInt(request.getParameter("productsPerPage"));
    ProductDao pd = new ProductDao();
    List<Product> products = null;
    products = pd.getAllPaging(pageNumber, productsPerPage);
    out.print(ProductJspGui.ToString(products));
%>
</body>
</html>
