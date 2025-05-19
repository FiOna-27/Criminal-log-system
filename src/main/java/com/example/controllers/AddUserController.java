package com.example.Controllers;

import com.example.Service.AddUserService;
import com.example.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AddDetectiveServlet")
public class AddUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String number = req.getParameter("number");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Validate email format
        if (!ValidationUtil.isValidEmail(email)) {
            req.setAttribute("error", "Invalid email format.");
            req.getRequestDispatcher("addUser.jsp").forward(req, resp);
            return;
        }

        // Validate email uniqueness
        if (!ValidationUtil.isEmailUnique(email)) {
            req.setAttribute("error", "Email already in use.");
            req.getRequestDispatcher("addUser.jsp").forward(req, resp);
            return;
        }

        // Validate phone number uniqueness
        if (!ValidationUtil.isPhoneUnique(number)) {
            req.setAttribute("error", "Phone number already in use.");
            req.getRequestDispatcher("addUser.jsp").forward(req, resp);
            return;
        }

        // Validate password strength
        if (!ValidationUtil.isValidPassword(password)) {
            req.setAttribute("error", "Password must be at least 8 characters long, include an uppercase letter, a number, and a special character.");
            req.getRequestDispatcher("addUser.jsp").forward(req, resp);
            return;
        }

        // All validations passed, go ahead and register
        boolean success = AddUserService.addUser(firstName, lastName, number, email, password);

        if (success) {
            resp.sendRedirect("login.jsp");
        } else {
            req.setAttribute("error", "Something went wrong. Please try again.");
            req.getRequestDispatcher("addUser.jsp").forward(req, resp);
        }
    }
}
