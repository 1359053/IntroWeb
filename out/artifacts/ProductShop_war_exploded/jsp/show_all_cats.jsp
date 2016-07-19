<%@ page import="com.mypackage.CategoryDao" %>
<%@ page import="com.mypackage.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mypackage.CategoryJspGui" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
<%--
  Created by IntelliJ IDEA.
  User: Son
  Date: 5/22/2015
  Time: 6:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Show all category</title>
</head>
<body>
<%
  CategoryDao cd = new CategoryDao();
  List<Category> cats;

  try {
    cats = cd.getAll();
    out.print(CategoryJspGui.ToString(cats));
  } catch (SQLException e) {
    e.printStackTrace();
  } catch (NamingException e) {
    e.printStackTrace();
  }
%>
</body>
</html>
