<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.ProductJspGui" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>

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
    <title>Product Pagination</title>
</head>
<body>

<div id="paging">
    <%
        ProductDao pd = new ProductDao();
        List<Product> products = pd.getAll();


        int totalNumberOfProducts = products.size();
        int numberOfProductsPerPage = 9;
        int totalPages = ((totalNumberOfProducts % numberOfProductsPerPage) == 0) ? (totalNumberOfProducts / numberOfProductsPerPage) : (totalNumberOfProducts / numberOfProductsPerPage) + 1;

        int currentPage = 1;
        if (request.getParameterMap().containsKey("data-page")) {
            currentPage = Integer.parseInt(request.getParameter("data-page"));
        }

        String pagination = pd.paginate("show_products_paging.jsp", currentPage, totalPages);
        out.println(pagination);
        out.println("<br/><br/>");

    %>
</div>
<div id="product_grid">
    <%
        products = pd.getAllPaging(currentPage, numberOfProductsPerPage);
        String rs = ProductJspGui.ToString(products);
        out.println(rs);
    %>
</div>

</body>
</html>
