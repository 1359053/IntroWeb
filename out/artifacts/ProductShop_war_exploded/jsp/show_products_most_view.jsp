<%@ page import="com.mypackage.ProductDao" %>
<%@ page import="com.mypackage.Product" %>
<%@ page import="com.mypackage.ViewTracking" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/23/2015
  Time: 10:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Show most viewed products</title>
</head>
<body>
<div id="product_grid">
  <%
    ProductDao pd = new ProductDao();
    Map<ViewTracking, Product> map = pd.getMostView();

    StringBuilder sb = new StringBuilder();

    for (Map.Entry<ViewTracking, Product> entry : map.entrySet()) {
      Product p = entry.getValue();
      ViewTracking v = entry.getKey();

      sb.append("SKU=" + p.getSku() + "\tCatID=" + p.getCatId() +
              "\tManID=" + p.getManId() + "\tName=" + p.getName() +/*
                    "\tProcessor=" + product.getProcessor() + "\tRAM=" + product.getRam() +
                    "\tScreen=" + product.getScreen() + "\tHDD=" + product.getHdd() +
                    "\tPicture=" + product.getPicture() + */
              "\tTotal Views=" + v.getTotalViews() + "\tLast View=" + v.getLastView() + "\tLast User ID=" + v.getLastUserId() +
              "<br/>");
    }

    out.println(sb);
  %>
</div>
</body>
</html>
