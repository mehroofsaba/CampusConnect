package com.campusconnect.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.NotificationDAO;
import com.campusconnect.model.Notification;
import com.campusconnect.model.User;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        NotificationDAO dao = new NotificationDAO();

        List<Notification> notifications =
                dao.getNotifications(user.getUserId());

        int unreadCount = dao.getUnreadCount(user.getUserId());

        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);

        request.getRequestDispatcher("/notifications.jsp")
               .forward(request, response);
    }

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

        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        NotificationDAO dao = new NotificationDAO();

        String action = request.getParameter("action");

        if ("read".equals(action)) {

            try {
                int notificationId = Integer.parseInt(
                        request.getParameter("notificationId")
                );

                dao.markAsRead(notificationId, user.getUserId());

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }

        } else if ("readAll".equals(action)) {

            dao.markAllAsRead(user.getUserId());
        }

        response.sendRedirect(
                request.getContextPath() + "/notifications"
        );
    }
}