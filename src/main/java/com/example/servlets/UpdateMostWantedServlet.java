package com.example.servlets;

import com.example.controllers.UpdateMostWantedController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/UpdateMostWantedServlet")
public class UpdateMostWantedServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String charges = req.getParameter("charges");
        String lastSeen = req.getParameter("lastSeen");
        String description = req.getParameter("description");

        boolean success = UpdateMostWantedController.updateCriminal(name, charges, lastSeen, description);

        if (success) {
            resp.sendRedirect("success.jsp");
        } else {
            resp.sendRedirect("error.jsp");
        }
    }
}
