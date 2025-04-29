package com.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.example.models.Prisoner;
import com.example.utils.DBUtil;

@WebServlet(name = "PrisonerServlet", urlPatterns = {"/PrisonerServlet"})
public class PrisonerServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM prisoners";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            List<Prisoner> prisoners = new ArrayList<>();
            
            while (rs.next()) {
                Prisoner prisoner = new Prisoner();
                prisoner.setId(rs.getInt("Prisoner_id"));
                prisoner.setName(rs.getString("Prisoner_name"));
                prisoner.setCharges(rs.getString("Prisoner_charges"));
                prisoner.setSentence(rs.getString("Prisoner_sentence"));
                prisoner.setInfo(rs.getString("Prisoner_info"));
                prisoner.setBehavior(rs.getString("Prisoner_behavior"));
                prisoner.setMentalState(rs.getString("Prisoner_mentalstate"));
                
                prisoners.add(prisoner);
            }
            
            request.setAttribute("prisoners", prisoners);
            request.getRequestDispatcher("in-custody.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error accessing incarceration records");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}