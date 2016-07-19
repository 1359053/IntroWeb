<%@ page import="com.mypackage.Category" %>
<%@ page import="com.mypackage.CategoryDao" %>
<%@ page import="com.mypackage.CategoryJspGui" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/22/2015
  Time: 6:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update category</title>
</head>
<body>
<form action="update_cat.jsp" method="post">
    <p>Enter category id: <input type="number" name="catId"/></p>

    <p>Enter category name: <input type="text" name="catName"/></p>

    <p><input type="submit" value="UPDATE CATEGORY"/></p>
    <input type="hidden" name="isSubmit" value="true"/>
</form>

<div id="grid">
    <%
        CategoryDao cd = new CategoryDao();
        List<Category> cats = cd.getAll();
        out.println(CategoryJspGui.ToString(cats));
    %>
</div>

<%
    if ((request.getParameter("isSubmit") != null)) {
        request.setCharacterEncoding("UTF-8");
        int catId = Integer.parseInt(request.getParameter("catId"));
        String catName = request.getParameter("catName");

        Category p = new Category(catId, catName);
        boolean update = cd.update(p);
        String rs = update ? "Update successfully." : "Update failed.";
        out.println(rs);
        out.println("<br/>");

        response.setIntHeader("Refresh", 2);
    }
%>
</body>
</html>
