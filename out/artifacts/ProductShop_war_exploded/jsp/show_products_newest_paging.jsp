<%@ page import="com.mypackage.Import" %>
<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/22/2015
  Time: 9:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Newest Product with Paging</title>
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

        String pagination = pd.paginate("show_products_newest_paging.jsp", currentPage, totalPages);
        out.println(pagination);
        out.println("<br/><br/>");

    %>
</div>
<div id="product_grid">
    <%
        Map<Import, Product> map = pd.getNewestPaging(currentPage, numberOfProductsPerPage);

        StringBuilder sb = new StringBuilder();

        for (Map.Entry<Import, Product> entry : map.entrySet()) {
            Product p = entry.getValue();
            Import i = entry.getKey();

            sb.append("SKU=" + p.getSku() + "\tCatID=" + p.getCatId() +
                    "\tManID=" + p.getManId() + "\tName=" + p.getName() +/*
                    "\tProcessor=" + product.getProcessor() + "\tRAM=" + product.getRam() +
                    "\tScreen=" + product.getScreen() + "\tHDD=" + product.getHdd() +
                    "\tPicture=" + product.getPicture() + */
                    "\tImport Time=" + i.getImportDateTime() + "\tQuantity=" + i.getQuantity() + "\tUnit Price=" + String.format("%.2f", i.getUnitPrice()) +
                    "<br/>");
        }

        out.println(sb);
    %>
</div>
</body>
</html>
