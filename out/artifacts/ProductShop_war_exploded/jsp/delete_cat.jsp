<%@ page import="com.mypackage.CategoryJspGui" %>
<%@ page import="com.mypackage.Category" %>
<%@ page import="com.mypackage.CategoryDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/22/2015
  Time: 8:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete category</title>
</head>
<body>
<form action="delete_cat.jsp" method="post">
  <p>Enter category ID: <input type="number" name="catId"/></p>

  <p><input type="submit" value="DELETE FROM DATABASE"/></p>
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

    String rs = (cd.delete(catId)) ? "Delete successfully." : "Delete failed.";
    out.println(rs);
    out.println("<br/>");

    response.setIntHeader("Refresh", 2);
  }
%>

</body>
</html>
