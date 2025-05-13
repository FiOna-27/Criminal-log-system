package com.example.servlets;

import com.example.models.MostWanted;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SearchMostWantedServlet")
public class SearchMostWantedServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        System.out.println("Searching for: " + keyword);
        List<MostWanted> searchResults = new ArrayList<>();

        try (Connection conn = com.example.utils.DBUtil.getConnection()) {
            String sql = "SELECT * FROM `most-wanted` WHERE Criminal_name LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                MostWanted mw = new MostWanted(
                    rs.getInt("Criminal_id"),
                    rs.getString("Criminal_name"),
                    rs.getString("Charges"),
                    rs.getString("Last_seen"),
                    rs.getString("Criminal_info")
                );
                searchResults.add(mw);
            }

        } catch (Exception e) {
            e.printStackTrace(); 
        }

        request.setAttribute("mostWantedList", searchResults);
        request.getRequestDispatcher("most-wanted.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<String> suggestions = new ArrayList<>();

        try (Connection conn = com.example.utils.DBUtil.getConnection()) {
            String sql = "SELECT Criminal_name FROM `most-wanted` WHERE Criminal_name LIKE ? LIMIT 5";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                suggestions.add(rs.getString("Criminal_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        StringBuilder result = new StringBuilder();
        for (String name : suggestions) {
            if (result.length() > 0) result.append(",");
            result.append(name);
        }

        response.setContentType("text/plain");
        response.getWriter().write(result.toString());
    }
}
