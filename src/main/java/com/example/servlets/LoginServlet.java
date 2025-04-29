package com.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import com.example.utils.DBUtil;
import com.example.models.Detective; 
import com.example.utils.PasswordUtil;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Context Path: " + request.getContextPath());

        String emailInput = request.getParameter("email");
        String passwordInput = request.getParameter("password");
     // Hash the incoming password
        String hashedInputPassword = PasswordUtil.hashPassword(passwordInput);

        try (Connection conn = DBUtil.getConnection()) {
            // Enhanced query to get more user data
            String sql = "SELECT Detective_id, First_name, Last_name, Email FROM detective WHERE Email = ? AND Password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, emailInput);
            stmt.setString(2, hashedInputPassword);
            

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Create Detective object with user data
                Detective detective = new Detective();
                detective.setId(rs.getInt("Detective_id"));
                detective.setFirstName(rs.getString("First_name"));
                detective.setLastName(rs.getString("Last_name"));
                detective.setEmail(rs.getString("Email"));

                // Create session and store detective object
                HttpSession session = request.getSession();
                session.setAttribute("detective", detective);

                // Log session creation
                System.out.println("Session created for: " + detective.getEmail());
                System.out.println("Session ID: " + session.getId());

                // Redirect to home page
                response.sendRedirect("home.jsp");
            } else {
                System.out.println("Login failed - invalid credentials");
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            request.setAttribute("error", "System error. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}