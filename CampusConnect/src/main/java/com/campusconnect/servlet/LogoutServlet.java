package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get the current session
        HttpSession session = request.getSession(false);

        // Destroy the session
        if (session != null) {
            session.invalidate();
        }

        // Prevent browser from caching protected pages
        response.setHeader("Cache-Control",
                "no-cache, no-store, must-revalidate");

        response.setHeader("Pragma", "no-cache");

        response.setDateHeader("Expires", 0);

        // Send user back to login page
        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
    }
}