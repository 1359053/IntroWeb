package com.mypackage;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ServletSetSession extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String sessionName = request.getParameter("sessionName");
        String sessionValue = request.getParameter("sessionValue");

        HttpSession session = request.getSession();

        boolean set = false;
        if (session != null) {
            session.setAttribute(sessionName, sessionValue);
            set=true;
        }

        String json = new Gson().toJson(set);
        response.getWriter().write(json);
    }
}
