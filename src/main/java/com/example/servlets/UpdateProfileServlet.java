package com.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import com.example.models.Detective;
import com.example.utils.DBUtil;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Detective detective = (Detective) session.getAttribute("detective");
        
        if (detective == null) {
            response.sendRedirect("loginController.jsp");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            
            
            String sql = "UPDATE detective SET FirstName=?, LastName=?, Email=?, Status=?, Specialty=? WHERE Detective_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, email);
            stmt.setInt(6, detective.getId());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                detective.setFirstName(firstName);
                detective.setLastName(lastName);
                detective.setEmail(email);
                
                session.setAttribute("detective", detective);
                request.setAttribute("success", "Profile updated successfully");
            } else {
                request.setAttribute("error", "Failed to update profile");
            }
            
            response.sendRedirect("agent-profile.jsp");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error updating profile");
            request.getRequestDispatcher("agent-profile.jsp").forward(request, response);
        }
    }
}