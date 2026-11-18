<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.campusconnect.model.Notification" %>

<%
    List<Notification> notifications =
        (List<Notification>) request.getAttribute("notifications");

    Integer unreadCountObj =
        (Integer) request.getAttribute("unreadCount");

    int unreadCount = unreadCountObj == null ? 0 : unreadCountObj;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Notifications | CampusConnect</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #071426;
            color: #f5f1e8;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height: 100vh;
        }

        /* NAVBAR */

        .navbar-custom {
            background: #071426;
            border-bottom: 1px solid rgba(255,255,255,.06);
            padding: 18px 0;
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -.5px;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .custom-link {
            position: relative;
            color: #b8c0cb !important;
            font-size: 14px;
            font-weight: 600;
            margin-left: 10px;
            padding: 10px 8px !important;
            transition: color .3s;
        }

        .custom-link i {
            color: #d6ad52;
            margin-right: 5px;
        }

        .custom-link:hover {
            color: #f5f1e8 !important;
        }

        .custom-link:hover i,
        .custom-link.active i {
            color: #f0ca70;
            text-shadow: 0 0 10px rgba(214,173,82,.5);
        }

        .custom-link.active {
            color: #f5f1e8 !important;
        }

        .custom-link::after {
            content: "";
            position: absolute;
            bottom: 2px;
            left: 8px;
            width: 0;
            height: 2px;
            background: #d6ad52;
            transition: width .3s;
        }

        .custom-link:hover::after,
        .custom-link.active::after {
            width: 55%;
        }

        .logout-link {
            color: #d6ad52 !important;
            font-size: 14px;
            font-weight: 700;
            margin-left: 14px;
            padding: 10px 14px !important;
            border: 1px solid rgba(214,173,82,.25);
            border-radius: 10px;
            transition: .3s;
        }

        .logout-link:hover {
            color: #071426 !important;
            background: #d6ad52;
            border-color: #d6ad52;
            box-shadow: 0 5px 18px rgba(214,173,82,.2);
            transform: translateY(-2px);
        }

        .navbar-toggler {
            border: 1px solid rgba(214,173,82,.5);
            border-radius: 8px;
            padding: 7px 10px;
        }

        .navbar-toggler i {
            color: #d6ad52;
            font-size: 23px;
        }

        .navbar-toggler:focus {
            box-shadow: none;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            color: #d6ad52 !important;
            font-size: 14px;
            font-weight: 700;
            padding: 10px 14px !important;
            border: 1px solid rgba(214,173,82,.25);
            border-radius: 10px;
            background: transparent;
            text-decoration: none;
            transition: .3s;
        }

        .back-btn:hover {
            color: #071426 !important;
            background: #d6ad52;
            box-shadow: 0 5px 18px rgba(214,173,82,.2);
            transform: translateY(-2px);
        }

        /* PAGE HERO */

        .hero {
            padding: 55px 0 45px;
            background:
                radial-gradient(circle at 85% 15%,
                rgba(214,173,82,.12), transparent 32%),
                #0a1a2e;
            border-bottom: 1px solid rgba(214,173,82,.09);
        }

        .hero-label {
            color: #d6ad52;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .hero h1 {
            margin: 14px 0 12px;
            color: #f5f1e8;
            font-size: clamp(32px, 5vw, 45px);
            font-weight: 800;
            letter-spacing: -1.8px;
        }

        .hero h1 span {
            color: #d6ad52;
        }

        .hero p {
            max-width: 600px;
            margin: 0;
            color: #8d98a6;
            font-size: 14px;
            line-height: 1.7;
        }

        /* NOTIFICATIONS SECTION */

        .notifications-section {
            max-width: 900px;
            margin: auto;
            padding: 55px 15px 90px;
        }

        .section-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        .section-heading h3 {
            color: #f5f1e8;
            font-size: 23px;
            font-weight: 750;
            margin: 0;
        }

        .unread-count {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 27px;
            height: 27px;
            padding: 0 8px;
            margin-left: 7px;
            background: rgba(214,173,82,.12);
            border: 1px solid rgba(214,173,82,.3);
            border-radius: 20px;
            color: #d6ad52;
            font-size: 12px;
            font-weight: 700;
        }

        .gold-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 10px 16px;
            border: 1px solid rgba(214,173,82,.35);
            border-radius: 10px;
            background: transparent;
            color: #d6ad52;
            font-size: 13px;
            font-weight: 700;
            transition: .3s;
        }

        .gold-btn:hover {
            background: #d6ad52;
            color: #071426;
            border-color: #d6ad52;
            transform: translateY(-2px);
        }

        /* NOTIFICATION CARD */

        .notification-card {
            position: relative;
            display: flex;
            align-items: flex-start;
            gap: 18px;
            padding: 23px 25px;
            margin-bottom: 15px;
            background: linear-gradient(
                145deg,
                rgba(255,255,255,.045),
                rgba(255,255,255,.015)
            );
            border: 1px solid rgba(255,255,255,.09);
            border-radius: 16px;
            transition: .3s;
        }

        .notification-card:hover {
            transform: translateY(-4px);
            border-color: rgba(214,173,82,.45);
            box-shadow: 0 15px 35px rgba(0,0,0,.2);
        }

        .notification-card.unread {
            background: linear-gradient(
                145deg,
                rgba(214,173,82,.09),
                rgba(255,255,255,.015)
            );
            border-color: rgba(214,173,82,.28);
        }

        .notification-icon {
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 48px;
            height: 48px;
            border-radius: 13px;
            background: rgba(214,173,82,.10);
            border: 1px solid rgba(214,173,82,.25);
            color: #d6ad52;
            font-size: 21px;
        }

        .notification-content {
            flex: 1;
            min-width: 0;
        }

        .notification-message {
            color: #f5f1e8;
            font-size: 14px;
            line-height: 1.7;
            margin: 2px 0 9px;
            overflow-wrap: anywhere;
        }

        .notification-date {
            color: #8d98a6;
            font-size: 12px;
        }

        .notification-badge {
            display: inline-block;
            padding: 4px 9px;
            margin-bottom: 8px;
            border-radius: 20px;
            background: rgba(214,173,82,.13);
            color: #d6ad52;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: .5px;
            text-transform: uppercase;
        }

        .read-btn {
            flex-shrink: 0;
            padding: 7px 11px;
            border: 1px solid rgba(214,173,82,.3);
            border-radius: 8px;
            background: transparent;
            color: #d6ad52;
            font-size: 12px;
            font-weight: 700;
            transition: .3s;
        }

        .read-btn:hover {
            background: #d6ad52;
            color: #071426;
        }

        /* EMPTY STATE */

        .empty-box {
            padding: 65px 20px;
            text-align: center;
            background: rgba(255,255,255,.02);
            border: 1px dashed rgba(214,173,82,.25);
            border-radius: 18px;
        }

        .empty-box i {
            display: block;
            margin-bottom: 18px;
            color: #d6ad52;
            font-size: 42px;
        }

        .empty-box h4 {
            color: #f5f1e8;
            font-size: 20px;
            font-weight: 750;
            margin-bottom: 9px;
        }

        .empty-box p {
            color: #8d98a6;
            font-size: 14px;
            margin: 0;
        }

        /* FOOTER */

        footer {
            padding: 28px 0;
            background: #050f1c;
            border-top: 1px solid rgba(255,255,255,.06);
            color: #707b89;
            text-align: center;
            font-size: 13px;
        }

        /* RESPONSIVE */

        @media (max-width: 991px) {
            .custom-link {
                margin-left: 0;
            }

            .logout-link {
                margin-left: 0;
                margin-top: 8px;
            }

            .navbar-nav {
                padding-top: 15px;
            }
        }

        @media (max-width: 768px) {
            .navbar-custom {
                padding: 16px 0;
            }

            .brand {
                font-size: 21px;
            }

            .notifications-section {
                padding-top: 40px;
            }

            .notification-card {
                padding: 19px;
                gap: 13px;
            }
        }

        @media (max-width: 480px) {
            .brand {
                font-size: 19px;
            }

            .back-btn {
                padding: 8px 10px !important;
                font-size: 12px;
            }

            .notification-card {
                flex-wrap: wrap;
            }

            .read-btn {
                margin-left: 61px;
            }
        }
    </style>
</head>

<body>

<!-- NAVBAR -->

<nav class="navbar-custom navbar navbar-expand-lg">
    <div class="container">

        <div class="d-flex align-items-center gap-3">

            <button type="button" class="back-btn"
                    onclick="history.back()">
                <i class="bi bi-arrow-left"></i> Back
            </button>

            <a href="studentDashboard.jsp" class="brand">
                <i class="bi bi-mortarboard-fill"></i> CampusConnect
            </a>

        </div>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#studentNav"
                aria-controls="studentNav"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <i class="bi bi-list"></i>
        </button>

        <div class="collapse navbar-collapse" id="studentNav">

            <ul class="navbar-nav ms-auto align-items-lg-center">

                <li class="nav-item">
                    <a class="nav-link custom-link"
                       href="studentDashboard.jsp">
                        <i class="bi bi-grid"></i> Dashboard
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link custom-link"
                       href="studentDashboard.jsp#opportunities">
                        <i class="bi bi-briefcase"></i> Opportunities
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link custom-link"
                       href="studentDashboard.jsp#applications">
                        <i class="bi bi-file-earmark-text"></i> My Applications
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link custom-link"
                       href="<%= request.getContextPath() %>/studentProfile">
                        <i class="bi bi-person-circle"></i> My Profile
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link custom-link active"
                       href="<%= request.getContextPath() %>/notifications">

                        <i class="bi bi-bell"></i> Notifications

                        <% if (unreadCount > 0) { %>
                            <span class="badge bg-danger ms-1">
                                <%= unreadCount %>
                            </span>
                        <% } %>

                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link logout-link"
                       href="<%= request.getContextPath() %>/logout">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </li>

            </ul>
        </div>
    </div>
</nav>


<!-- HERO SECTION -->

<section class="hero">
    <div class="container">

        <div class="hero-label">
            <i class="bi bi-bell-fill"></i> STAY UPDATED
        </div>

        <h1>Your <span>Notifications</span></h1>

        <p>
            Keep track of your application updates and important
            announcements from companies.
        </p>

    </div>
</section>


<!-- NOTIFICATIONS -->

<section class="notifications-section">

    <div class="section-heading">

        <h3>
            Recent Notifications

            <% if (unreadCount > 0) { %>
                <span class="unread-count">
                    <%= unreadCount %> unread
                </span>
            <% } %>
        </h3>

        <% if (notifications != null && !notifications.isEmpty()
                && unreadCount > 0) { %>

            <form action="<%= request.getContextPath() %>/notifications"
                  method="post">

                <input type="hidden" name="action" value="readAll">

                <button type="submit" class="gold-btn">
                    <i class="bi bi-check2-all"></i>
                    Mark All as Read
                </button>

            </form>

        <% } %>

    </div>


    <% if (notifications == null || notifications.isEmpty()) { %>

        <div class="empty-box">

            <i class="bi bi-bell-slash"></i>

            <h4>You're All Caught Up!</h4>

            <p>
                You don't have any notifications right now.
                We'll let you know when something important happens.
            </p>

        </div>

    <% } else { %>

        <%
            for (Notification n : notifications) {

                String safeMessage = n.getMessage();

                if (safeMessage != null) {
                    safeMessage = safeMessage
                        .replace("&", "&amp;")
                        .replace("<", "&lt;")
                        .replace(">", "&gt;")
                        .replace("\"", "&quot;")
                        .replace("'", "&#39;");
                } else {
                    safeMessage = "";
                }
        %>

            <div class="notification-card <%= !n.isRead() ? "unread" : "" %>">

                <div class="notification-icon">
                    <i class="bi bi-bell-fill"></i>
                </div>

                <div class="notification-content">

                    <% if (!n.isRead()) { %>

                        <span class="notification-badge">
                            New
                        </span>

                    <% } %>

                    <p class="notification-message">
                        <%= safeMessage %>
                    </p>

                    <div class="notification-date">
                        <i class="bi bi-clock"></i>

                        <%= n.getCreatedAt() != null
                            ? n.getCreatedAt()
                            : "" %>
                    </div>

                </div>

                <% if (!n.isRead()) { %>

                    <form action="<%= request.getContextPath() %>/notifications"
                          method="post">

                        <input type="hidden" name="action" value="read">

                        <input type="hidden"
                               name="notificationId"
                               value="<%= n.getNotificationId() %>">

                        <button type="submit" class="read-btn">
                            <i class="bi bi-check2"></i> Mark Read
                        </button>

                    </form>

                <% } %>

            </div>

        <%
            }
        %>

    <% } %>

</section>


<!-- FOOTER -->

<footer>
    <div class="container">
        © 2026 CampusConnect. All Rights Reserved.
    </div>
</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>