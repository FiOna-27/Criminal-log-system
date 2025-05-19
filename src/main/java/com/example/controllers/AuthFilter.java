package com.example.Controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*") 
public class AuthFilter implements Filter {
    
    private static final Set<String> ALLOWED_PATHS = new HashSet<String>() {/**
		 * 
		 */
		private static final long serialVersionUID = 1L;

	{
        add("/login.jsp");
        add("/LoginController");
        add("/addUser.jsp");
        add("/login.jsp");
        add("/AddDetectiveServlet");
        add("/css/");
        add("/js/");
        add("/assets/");
        add("/forgotpassword.jsp");
        add("/public.jsp");
        add("/PublicMostWantedController");
        add("/help.jsp");
        add("/contact.jsp");
        
    }};
    

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("Authentication Filter initialized");
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        String path = request.getRequestURI().substring(
            request.getContextPath().length()).replaceAll("[/]+$", "");
        
        boolean isLoggedIn = (session != null && session.getAttribute("detective") != null);
        boolean isAllowedPath = ALLOWED_PATHS.stream().anyMatch(path::startsWith);
        
        System.out.println("Path: " + path + " | Logged in: " + isLoggedIn);
        
        if (isLoggedIn || isAllowedPath) {
            chain.doFilter(request, response);
        } else {
            System.out.println("Unauthorized access attempt to: " + path);
            request.setAttribute("error", "Please login to access this page");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        System.out.println("Authentication Filter destroyed");
    }
}
