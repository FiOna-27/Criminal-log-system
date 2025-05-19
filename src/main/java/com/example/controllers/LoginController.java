package com.example.Controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import com.example.Service.LoginService;
import com.example.models.Detective;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Context Path: " + request.getContextPath());

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Detective detective = LoginService.authenticate(email, password);

            if (detective != null) {
                HttpSession session = request.getSession();
                session.setAttribute("detective", detective);

                System.out.println("Session created for: " + detective.getEmail());
                response.sendRedirect("home.jsp");
            } else {
                System.out.println("Login failed - invalid credentials");
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            request.setAttribute("error", "System error. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
