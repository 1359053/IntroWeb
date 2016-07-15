package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

public class ServletAccEditInfo extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String id = request.getParameter("old_email");

        //System.out.println(id+"-"+name+"-"+address+"-"+phone);

        String result = "";

        try {
            if (!UserDao.isExisted(id)) {
                result = "This user id doesn't exist! <i class='fa fa-times'></i>";
            } else {
                User u = new User();

                u.setId(id);
                u.setName(name);
                u.setAddress(address);
                u.setPhone(phone);
                u.setRole("user");
                u.setPassword("");

                result = UserDao.update(u) ? "true" : "Failed! <i class='fa fa-times'></i>";

                if(result.equals("true")){
                    HttpSession session =request.getSession();
                    session.setAttribute("loggedUser",UserDao.getById(id));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }

        String json = new Gson().toJson(result);
        response.getWriter().write(json);
    }
}
