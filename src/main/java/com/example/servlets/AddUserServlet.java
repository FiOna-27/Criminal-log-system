package com.example.servlets;

import com.example.controllers.AddUserController;
import com.example.servlets.AddUserServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AddDetectiveServlet")
public class AddUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String number = req.getParameter("number");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        boolean success = AddUserController.addUser(firstName, lastName, number, email, password);

        if (success) {
            resp.sendRedirect("login.jsp");
        } else {
            resp.sendRedirect("error.jsp");
        }
    }
}
