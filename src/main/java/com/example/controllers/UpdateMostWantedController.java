package com.example.Controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.example.Service.UpdateMostWantedService;

@WebServlet("/UpdateMostWantedController")
public class UpdateMostWantedController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String charges = req.getParameter("charges");
        String lastSeen = req.getParameter("lastSeen");
        String description = req.getParameter("description");

        boolean success = UpdateMostWantedService.updateCriminal(name, charges, lastSeen, description);

        if (success) {
            resp.sendRedirect("MostWantedController");
        } else {
        	 HttpSession session = req.getSession();
             session.setAttribute("errorMessage", "Failed to update the criminal information. Please try again.");
            resp.sendRedirect("MostWantedController");
        }
    }
}
