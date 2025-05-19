package com.example.Controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.example.Service.AddInmateService;

@WebServlet("/AddInmateController")
@MultipartConfig
public class AddInmateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String charges = req.getParameter("charges");
        String sentence = req.getParameter("sentence");
        String info = req.getParameter("info");
        String behavior = req.getParameter("behavior");
        String mentalState = req.getParameter("mentalState");

        boolean success = AddInmateService.addInmate(name, charges, sentence, info, behavior, mentalState);

        if (success) {
        	
            resp.sendRedirect("AddInmateController");
        } else {
        	HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Failed to add the inmate information. Please try again.");
            resp.sendRedirect("AddInmateController");
        }
    }
}
