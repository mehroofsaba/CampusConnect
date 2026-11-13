<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.campusconnect.model.Notification" %>

<%
    List<Notification> notifications =
        (List<Notification>) request.getAttribute("notifications");

    Integer unreadCount =
        (Integer) request.getAttribute("unreadCount");

    if (unreadCount == null) unreadCount = 0;

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notifications | CampusConnect</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background: #071426;
            color: #f5f5f5;
            font-family: Arial, sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: #0b1d33;
            border-bottom: 1px solid rgba(214, 173, 82, 0.25);
        }

        .brand {
            color: #d6ad52 !important;
            font-weight: bold;
            font-size: 22px;
        }

        .main-container {
            max-width: 850px;
            margin: 55px auto;
            padding: 0 18px;
        }

        .page-title {
            color: #d6ad52;
            font-weight: bold;
        }

        .notification-card {
            background: #10243d;
            border: 1px solid rgba(214, 173, 82, 0.2);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .unread {
            border-left: 4px solid #d6ad52;
            background: #142b47;
        }

        .notification-message {
            margin-bottom: 7px;
            color: #ffffff;
        }

        .notification-date {
            color: #aab6c5;
            font-size: 13px;
        }

        .gold-btn {
            background: #d6ad52;
            color: #071426;
            border: none;
            border-radius: 7px;
            padding: 8px 14px;
            font-weight: bold;
            white-space: nowrap;
        }

        .gold-btn:hover {
            background: #e8c36b;
            color: #071426;
        }

        .empty-box {
            background: #10243d;
            border-radius: 12px;
            padding: 45px 20px;
            text-align: center;
            color: #aab6c5;
        }

        .back-link {
            color: #d6ad52;
            text-decoration: none;
        }

        .back-link:hover {
            color: #e8c36b;
        }

        @media (max-width: 600px) {
            .notification-card {
                align-items: flex-start;
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<nav class="navbar navbar-dark">
    <div class="container">
        <a class="navbar-brand brand" href="<%= contextPath %>/studentDashboard.jsp">
            CampusConnect
        </a>

        <a href="<%= contextPath %>/studentDashboard.jsp"
           class="back-link">
            <i class="bi bi-arrow-left"></i> Dashboard
        </a>
    </div>
</nav>

<div class="main-container">

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">

        <div>
            <h2 class="page-title">
                <i class="bi bi-bell"></i> Notifications
            </h2>

            <p class="text-secondary mb-0">
                You have <%= unreadCount %> unread notification(s).
            </p>
        </div>

        <% if (unreadCount > 0) { %>
            <form action="<%= contextPath %>/notifications" method="post">
                <input type="hidden" name="action" value="readAll">

                <button type="submit" class="gold-btn">
                    <i class="bi bi-check2-all"></i> Mark all as read
                </button>
            </form>
        <% } %>

    </div>

    <% if (notifications == null || notifications.isEmpty()) { %>

        <div class="empty-box">
            <i class="bi bi-bell-slash" style="font-size: 40px;"></i>
            <h5 class="mt-3">No notifications yet</h5>
            <p class="mb-0">
                Updates about your applications will appear here.
            </p>
        </div>

    <% } else { %>

        <% for (Notification n : notifications) { %>

            <div class="notification-card <%= !n.isRead() ? "unread" : "" %>">

                <div>
                    <p class="notification-message">
                        <i class="bi bi-info-circle text-warning me-2"></i>
                        <%= n.getMessage()
                            .replace("&", "&amp;")
                            .replace("<", "&lt;")
                            .replace(">", "&gt;")
                            .replace("\"", "&quot;")
                            .replace("'", "&#39;") %>
                    </p>

                    <span class="notification-date">
                        <i class="bi bi-clock"></i>
                        <%= n.getCreatedAt() %>
                    </span>

                    <% if (!n.isRead()) { %>
                        <span class="badge bg-warning text-dark ms-2">
                            NEW
                        </span>
                    <% } %>
                </div>

                <% if (!n.isRead()) { %>
                    <form action="<%= contextPath %>/notifications"
                          method="post">

                        <input type="hidden" name="action" value="read">

                        <input type="hidden"
                               name="notificationId"
                               value="<%= n.getNotificationId() %>">

                        <button type="submit" class="gold-btn">
                            Mark as read
                        </button>
                    </form>
                <% } %>

            </div>

        <% } %>

    <% } %>

</div>

</body>
</html>