<%@ page import="com.mypackage.Category" %>
<%@ page import="com.mypackage.CategoryDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mypackage.CategoryJspGui" %>
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
    <title>Insert category</title>
</head>
<body>
<form action="insert_cat.jsp" method="post">
    <p>Enter category name: <input type="text" name="catName"/></p>

    <p><input type="submit" value="INSERT INTO DATABASE"/></p>
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
        String catName = request.getParameter("catName");
        Category cat = new Category(0, catName);

        try {
            String rs = (cd.insert(cat)) ? "Insert successfully." : "Insert failed.";
            out.println(rs);
            out.println("<br/><br/>");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }

        response.setIntHeader("Refresh", 2);
    }
%>
</body>
</html>
