package com.example.servlets;

import com.example.controllers.RemoveMostWantedController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/RemoveMostWantedServlet")
public class RemoveMostWantedServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");

        boolean success = RemoveMostWantedController.removeByName(name);

        if (success) {
            resp.sendRedirect("success.jsp"); 
        } else {
            resp.sendRedirect("error.jsp");
        }
    }
}
