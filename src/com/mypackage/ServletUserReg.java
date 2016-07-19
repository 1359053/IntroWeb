package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ServletUserReg extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String id =  request.getParameter("id");
        String name =  request.getParameter("name");
        String password =  request.getParameter("password");
        String address =  request.getParameter("address");
        String phone =  request.getParameter("phone");

        User u = new User();
        u.setId(id);
        u.setAddress(address);
        u.setPassword(password);
        u.setName(name);
        u.setRole("user");
        u.setPhone(phone);

        boolean inserted = false;
        try {
            inserted =  UserDao.insert(u);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }

        String json = new Gson().toJson( inserted);
        //response.setContentType("text/plain");
        response.getWriter().write(json);
    }
}
