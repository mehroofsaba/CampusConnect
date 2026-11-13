package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.ApplicationDAO;
import com.campusconnect.dao.NotificationDAO;
import com.campusconnect.model.User;

@WebServlet("/applicationStatus")
public class ApplicationStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String appIdParam = request.getParameter("appId");
        String status = request.getParameter("status");

        if (appIdParam == null || appIdParam.trim().isEmpty()) {

            session.setAttribute("applicationMessage",
                    "Invalid application.");

            response.sendRedirect(
                    request.getContextPath() + "/companyapplications");
            return;
        }

        if (status == null ||
            !("ACCEPTED".equals(status) || "REJECTED".equals(status))) {

            session.setAttribute("applicationMessage",
                    "Invalid application status.");

            response.sendRedirect(
                    request.getContextPath() + "/companyapplications");
            return;
        }

        try {

            int appId = Integer.parseInt(appIdParam);

            ApplicationDAO dao = new ApplicationDAO();

            boolean updated = dao.updateApplicationStatus(
                    appId,
                    user.getUserId(),
                    status
            );

            if (updated) {

                // Find the student who submitted this application
                int studentId = dao.getStudentIdForApplication(
                        appId,
                        user.getUserId()
                );

                // Create notification for that student
                if (studentId != -1) {

                    NotificationDAO notificationDAO =
                            new NotificationDAO();

                    String message;

                    if ("ACCEPTED".equals(status)) {
                        message = "Congratulations! Your application has been accepted.";
                    } else {
                        message = "Your application status has been updated to Rejected.";
                    }

                    boolean notificationAdded =
                            notificationDAO.addNotification(
                                    studentId,
                                    message
                            );

                    if (!notificationAdded) {
                        System.out.println(
                                "Failed to save notification for student: "
                                + studentId
                        );
                    }

                } else {
                    System.out.println(
                            "Could not find student for application: " + appId
                    );
                }

                session.setAttribute(
                        "applicationMessage",
                        "Application status updated successfully."
                );

            } else {

                session.setAttribute(
                        "applicationMessage",
                        "Unable to update application. It may not belong to your company."
                );
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "applicationMessage",
                    "Invalid application ID."
            );
        }

        response.sendRedirect(
                request.getContextPath() + "/companyapplications"
        );
    }
}