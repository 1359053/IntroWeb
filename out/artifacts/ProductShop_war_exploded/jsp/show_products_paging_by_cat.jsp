<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.ProductJspGui" %>
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
    <title>Product by Category & Paging</title>
</head>
<body>

<div id="paging">
    <%
        int catId = 1;
        ProductDao pd = new ProductDao();
        List<Product> products = pd.getAllByCat(catId);

        int totalNumberOfProducts = products.size();
        int numberOfProductsPerPage = 9;
        int totalPages = ((totalNumberOfProducts % numberOfProductsPerPage) == 0) ? (totalNumberOfProducts / numberOfProductsPerPage) : (totalNumberOfProducts / numberOfProductsPerPage) + 1;

        int currentPage = 1;
        if (request.getParameterMap().containsKey("data-page")) {
            currentPage = Integer.parseInt(request.getParameter("data-page"));
        }

        String pagination = pd.paginate("show_products_paging_by_cat.jsp", currentPage, totalPages);
        out.println(pagination);
        out.println("<br/><br/>");

    %>
</div>
<div id="product_grid">
    <%
        products = pd.getByCatPaging(catId, currentPage, numberOfProductsPerPage);
        String rs = ProductJspGui.ToString(products);
        out.println(rs);
    %>
</div>

</body>
</html>
