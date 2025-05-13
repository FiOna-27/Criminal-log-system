package com.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import com.example.models.Detective;
import com.example.utils.DBUtil;

@WebServlet("/AgentProfileServlet")
public class AgentProfileServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Detective detective = (Detective) session.getAttribute("detective");
        
        if (detective == null) {
            response.sendRedirect("loginController.jsp");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM detective WHERE Detective_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, detective.getId());
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                detective.setFirstName(rs.getString("FirstName"));
                detective.setLastName(rs.getString("LastName"));
                detective.setEmail(rs.getString("Email"));
                detective.setNumber(rs.getString("Number"));
                
                session.setAttribute("detective", detective);
                
                request.getRequestDispatcher("agent-profile.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Agent profile not found");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error loading profile");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}