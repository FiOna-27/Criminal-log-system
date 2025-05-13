package com.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.example.models.MostWanted;
import com.example.utils.DBUtil;

@WebServlet("/MostWantedServlet")
public class MostWantedServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBUtil.getConnection()) {
        	String sql = "SELECT * FROM `most-wanted`";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            List<MostWanted> mostWantedList = new ArrayList<>();
            
            while (rs.next()) {
                MostWanted criminal = new MostWanted();
                criminal.setId(rs.getInt("Criminal_id"));
                criminal.setName(rs.getString("Criminal_name"));
                criminal.setCharges(rs.getString("Charges"));
                criminal.setLastSeen(rs.getString("Last_seen"));
                criminal.setInfo(rs.getString("Criminal_info"));
                mostWantedList.add(criminal);
                
            }
            
            request.setAttribute("mostWantedList", mostWantedList);
            request.getRequestDispatcher("most-wanted.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error accessing most wanted database");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}