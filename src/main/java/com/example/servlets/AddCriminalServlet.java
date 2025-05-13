package com.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.example.controllers.AddCriminalController;

@WebServlet("/AddCriminalServlet")
public class AddCriminalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String charges = req.getParameter("charges");
        String lastSeen = req.getParameter("lastSeen");
        String description = req.getParameter("description");

        boolean success = AddCriminalController.addWanted(name, charges, lastSeen, description);

        if (success) {
            resp.sendRedirect("home.jsp");
        } else {
            resp.sendRedirect("error.jsp");
        }
    }
}
