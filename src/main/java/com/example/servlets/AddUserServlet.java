package com.example.servlets;

import com.example.utils.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.example.utils.PasswordUtil;

@WebServlet("/AddDetectiveServlet")
public class AddUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Get form data
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String number = req.getParameter("number");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String hashedPassword = PasswordUtil.hashPassword(password);

        // Insert into database
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO detective (First_name, Last_name, Number, Email, Password) VALUES (?, ?, ?, ?, ?)";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, firstName);
                stmt.setString(2, lastName);
                stmt.setString(3, number);
                stmt.setString(4, email);
                stmt.setString(5, hashedPassword);
                
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    resp.sendRedirect("login.jsp"); // Success
                } else {
                    resp.sendRedirect("error.jsp");  // Failure
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp"); // Error
        }
    }
}