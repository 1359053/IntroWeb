package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ServletAddMan extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String manName = request.getParameter("manName");
        System.out.println(manName);

        String result = "";

        if (manName.equals("")) {
            result = "Brand name can't be blank! <i class='fa fa-times'></i>";
        } else {
            try {
                if (ManufacturerDao.isExisted(manName)) {
                    result = "This brand exist! <i class='fa fa-times'></i>";
                } else {
                    result = ManufacturerDao.insert(manName) ? "true" : "Failed! <i class='fa fa-times'></i>";
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (NamingException e) {
                e.printStackTrace();
            }
        }

        String json = new Gson().toJson(result);
        response.getWriter().write(json);
    }
}
