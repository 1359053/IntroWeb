<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.ProductJspGui" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/15/2015
  Time: 11:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Insert Product</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String productName = request.getParameter("productName");
    ProductDao pd = new ProductDao();
    Product p = new Product(0, 1, 3, productName);
    try {
        String rs = (pd.insert(p)) ? "Insert successfully." : "Insert failed.";
        out.println(rs);
        out.println("<br/><br/>");

        List<Product> products = pd.getAll();
        out.println(ProductJspGui.ToString(products));
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (NamingException e) {
        e.printStackTrace();
    }
%>
</body>
</html>
