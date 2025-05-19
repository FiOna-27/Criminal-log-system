package com.example.Controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.example.Service.RemoveMostWantedService;
import com.example.models.Detective;

import java.io.IOException;

@WebServlet("/RemoveMostWantedController")
public class RemoveMostWantedController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check if user is authenticated
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("detective") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Check authorization level
        Detective detective = (Detective) session.getAttribute("detective");
        if (detective.getLevel() < 2) {
            req.setAttribute("error", "Unauthorized: Insufficient access level");
            req.getRequestDispatcher("MostWantedController").forward(req, resp);
            return;
        }

        // Proceed with removal
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Criminal name is required");
            req.getRequestDispatcher("MostWantedController").forward(req, resp);
            return;
        }

        boolean success = RemoveMostWantedService.removeByName(name);

        if (success) {
            req.setAttribute("message", "Target removed successfully");
            req.getRequestDispatcher("MostWantedController").forward(req, resp);
        } else {
        	 HttpSession session1 = req.getSession();
             session1.setAttribute("errorMessage", "Failed to remove the criminal information. Please try again.");
            req.setAttribute("error", "Failed to remove target");
            req.getRequestDispatcher("MostWantedController").forward(req, resp);
        }
    }
}