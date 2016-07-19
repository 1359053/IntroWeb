<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.ProductJspGui" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>

<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/11/2015
  Time: 2:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    ProductDao pd = new ProductDao();
    List<Product> products;

    try {
        products = pd.getAll();
        out.print(ProductJspGui.ToString(products));

    } catch (SQLException e) {
        e.printStackTrace();
    } catch (NamingException e) {
        e.printStackTrace();
    }
%>

</body>
</html>
