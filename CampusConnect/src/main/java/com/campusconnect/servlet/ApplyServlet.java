package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.ApplicationDAO;
import com.campusconnect.model.User;

@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user
        User user = (User) session.getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get opportunity ID
        String oppIdParam = request.getParameter("oppId");

        if (oppIdParam == null || oppIdParam.trim().isEmpty()) {
            response.sendRedirect("studentDashboard.jsp");
            return;
        }

        try {

            int studentId = user.getUserId();
            int oppId = Integer.parseInt(oppIdParam);

            ApplicationDAO applicationDAO = new ApplicationDAO();

            // Prevent duplicate application
            if (applicationDAO.alreadyApplied(studentId, oppId)) {

                session.setAttribute(
                    "applyMessage",
                    "You have already applied for this opportunity."
                );

            } else {

                boolean success =
                    applicationDAO.apply(studentId, oppId);

                if (success) {

                    session.setAttribute(
                        "applyMessage",
                        "Application submitted successfully!"
                    );

                } else {

                    session.setAttribute(
                        "applyMessage",
                        "Application failed. Please try again."
                    );
                }
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                "applyMessage",
                "Invalid opportunity."
            );

        }

        response.sendRedirect("studentDashboard.jsp");
    }
}