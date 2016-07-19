<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.ProductJspGui" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
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
    <title></title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    List<Product> list = new ArrayList<Product>();

    list.add(new Product(0, 2, 21, request.getParameter("productName1")));
    list.add(new Product(0, 2, 0, request.getParameter("productName2")));
    list.add(new Product(0, 2, 5, request.getParameter("productName3")));

    ProductDao pd = new ProductDao();
    try {
        List<Boolean> res = pd.insert(list);

        for (boolean i : res) {
            String rs = (i) ? "Insert successfully." : "Insert failed.";
            out.println(rs);
        }

        out.println("<br/>");

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
