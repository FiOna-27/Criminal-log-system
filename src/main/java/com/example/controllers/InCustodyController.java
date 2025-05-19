package com.example.Controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import com.example.Service.InCustodyService;
import com.example.models.InCustody;

@WebServlet("/InCustodyController")
public class InCustodyController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            
            List<InCustody> prisoners = InCustodyService.getAllPrisoners();
            request.setAttribute("prisoners", prisoners);
            request.getRequestDispatcher("in-custody.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
