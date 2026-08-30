<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusconnect.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | CampusConnect</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            background: #f5f7fb;
            font-family: Arial, sans-serif;
        }

        .navbar {
            background: #123b8f;
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 24px;
        }

        .hero {
            background: linear-gradient(135deg, #123b8f, #2563eb);
            color: white;
            padding: 45px 0;
        }

        .admin-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,.06);
            transition: .2s;
        }

        .admin-card:hover {
            transform: translateY(-4px);
        }

        .icon-box {
            width: 55px;
            height: 55px;
            border-radius: 14px;
            background: #e8f0ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

    </style>

</head>

<body>


<nav class="navbar navbar-dark">

    <div class="container">

        <a class="navbar-brand" href="adminDashboard.jsp">
            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect
        </a>

        <span class="text-white">
            <i class="bi bi-shield-check me-2"></i>
            Admin
        </span>

    </div>

</nav>


<section class="hero">

    <div class="container">

        <p class="mb-2">
            Administration
        </p>

        <h1 class="fw-bold">
            Welcome, <%= user.getName() %>!
        </h1>

        <p class="mb-0">
            Manage and monitor the CampusConnect platform.
        </p>

    </div>

</section>


<div class="container py-5">

    <h3 class="fw-bold mb-4">
        Administration Panel
    </h3>


    <div class="row g-4">

        <div class="col-md-4">

            <div class="card admin-card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-people-fill"></i>
                </div>

                <h5 class="fw-bold">
                    Manage Users
                </h5>

                <p class="text-muted">
                    View and manage registered students and companies.
                </p>

                <span class="badge text-bg-secondary">
                    Coming Soon
                </span>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card admin-card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-briefcase-fill"></i>
                </div>

                <h5 class="fw-bold">
                    Manage Opportunities
                </h5>

                <p class="text-muted">
                    Monitor jobs and internships posted by companies.
                </p>

                <span class="badge text-bg-secondary">
                    Coming Soon
                </span>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card admin-card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-file-earmark-check-fill"></i>
                </div>

                <h5 class="fw-bold">
                    Applications
                </h5>

                <p class="text-muted">
                    Monitor applications submitted by students.
                </p>

                <span class="badge text-bg-secondary">
                    Coming Soon
                </span>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card admin-card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-bar-chart-fill"></i>
                </div>

                <h5 class="fw-bold">
                    Reports
                </h5>

                <p class="text-muted">
                    View platform statistics and reports.
                </p>

                <span class="badge text-bg-secondary">
                    Coming Soon
                </span>

            </div>

        </div>

    </div>

</div>


<footer class="text-center text-muted py-4">

    <small>
        © 2026 CampusConnect
    </small>

</footer>


</body>
</html>