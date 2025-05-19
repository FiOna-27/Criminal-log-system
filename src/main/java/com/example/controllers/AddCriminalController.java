package com.example.Controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import com.example.Service.AddCriminalService;

@WebServlet("/AddCriminalController")
public class AddCriminalController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String charges = req.getParameter("charges");
        String lastSeen = req.getParameter("lastSeen");
        String description = req.getParameter("description");

        boolean success = AddCriminalService.addWanted(name, charges, lastSeen, description);

        if (success) {
            resp.sendRedirect("MostWantedController");
        } else {
        	 HttpSession session = req.getSession();
             session.setAttribute("errorMessage", "Failed to add the criminal information. Please try again.");
            resp.sendRedirect("error.jsp");
        }
    }
}
