package com.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

import com.example.models.Photo;
import com.example.utils.PhotoDAO;

@WebServlet("/detectivePhotos")
public class DetectivePhotoServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int detectiveId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure JDBC driver is loaded

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/username-passwords", "root", ""
            );

            PhotoDAO dao = new PhotoDAO(conn);
            List<Photo> photos = dao.getPhotosByDetectiveId(detectiveId);

            request.setAttribute("photos", photos);
            RequestDispatcher rd = request.getRequestDispatcher("detectivePhotos.jsp");
            rd.forward(request, response);

            conn.close();
        } catch (Exception e) {
            throw new ServletException("Bruh. DB went 💥", e);
        }
    }
}