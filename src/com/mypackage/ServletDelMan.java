package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ServletDelMan extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String manIdStr = request.getParameter("manId");

        String result = "";

        if (manIdStr.equals("")) {
            result = "Brand can't be blank! <i class='fa fa-times'></i>";
        } else {
            int manId = Integer.parseInt(manIdStr);
            try {
                if (!ManufacturerDao.isExisted(manId)) {
                    result = "This brand doesn't exist! <i class='fa fa-times'></i>";
                } else {
                    result = ManufacturerDao.delete(manId) ? "true" : "Failed! <i class='fa fa-times'></i>";
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
