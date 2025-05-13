package com.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.example.controllers.AddInmateController;

import java.io.IOException;

@WebServlet("/AddInmateServlet")
@MultipartConfig
public class AddInmateServlet extends HttpServlet {
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

        boolean success = AddInmateController.addInmate(name, charges, sentence, info, behavior, mentalState);

        if (success) {
            resp.sendRedirect("login.jsp");
        } else {
            resp.sendRedirect("error.jsp");
        }
    }
}
