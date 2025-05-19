package com.example.Controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import com.example.Service.MostWantedService;
import com.example.models.MostWanted;

@WebServlet("/MostWantedController")
public class MostWantedController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<MostWanted> mostWantedList = MostWantedService.getAllMostWanted();
            request.setAttribute("mostWantedList", mostWantedList);
            request.getRequestDispatcher("most-wanted.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error accessing most wanted database");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
