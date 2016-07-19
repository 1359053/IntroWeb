<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/15/2015
  Time: 9:59 PM
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
    Product p = null;
    try {
        p = pd.getBySku(productSku);
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (NamingException e) {
        e.printStackTrace();
    }
    if (p != null) {
        out.println("ID = " + p.getSku());
        out.println("Name = " + p.getName());
    }
    else{
        out.println("Unsuccessful!");
    }
%>
</body>
</html>
