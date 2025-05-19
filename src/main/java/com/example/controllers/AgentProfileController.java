package com.example.Controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;

import com.example.Service.DetectiveService;
import com.example.models.Detective;

@WebServlet("/AgentProfileController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,   // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class AgentProfileController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "assets/images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Detective detective = (Detective) session.getAttribute("detective");

        if (detective == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            DetectiveService controller = new DetectiveService();
            Detective updatedDetective = controller.getDetectiveById(detective.getId());
            
            if (updatedDetective != null) {
                session.setAttribute("detective", updatedDetective);
                request.getRequestDispatcher("agent-profile.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "Agent profile not found");
                response.sendRedirect("most-wanted.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "Database error loading profile");
            response.sendRedirect("most-wanted.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Detective detective = (Detective) session.getAttribute("detective");

        if (detective == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Part filePart = request.getPart("imageFile");
        boolean hideImage = "on".equals(request.getParameter("hideImage"));
        String imageUrl = detective.getImageUrl(); // Keep existing if no file uploaded

        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                session.setAttribute("error", "Only image files are allowed");
                response.sendRedirect("AgentProfileController");
                return;
            }

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIR;
            String filePath = uploadPath + "/" + fileName;

            Files.createDirectories(Paths.get(uploadPath));
            filePart.write(filePath);

            imageUrl = "/" + UPLOAD_DIR + "/" + fileName;
        }

        try {
            DetectiveService controller = new DetectiveService();
            boolean success = controller.updateProfileImageAndVisibility(detective.getId(), imageUrl, hideImage);

            if (success) {
                detective.setImageUrl(imageUrl);
                detective.setHideImage(hideImage);
                session.setAttribute("detective", detective);
                session.setAttribute("message", "Profile updated successfully");
            } else {
                session.setAttribute("error", "Failed to update profile");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "Database error updating profile");
        }

        response.sendRedirect("AgentProfileController");
    }
}
