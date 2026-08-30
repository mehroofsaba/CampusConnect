<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusconnect.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"STUDENT".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Dashboard | CampusConnect</title>

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

        .stat-card,
        .feature-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,.06);
        }

        .icon-box {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #e8f0ff;
            color: #2563eb;
            font-size: 22px;
        }

        .feature-card {
            transition: .2s;
        }

        .feature-card:hover {
            transform: translateY(-4px);
        }

        .coming {
            font-size: 12px;
        }

    </style>

</head>

<body>


<nav class="navbar navbar-dark">

    <div class="container">

        <a class="navbar-brand" href="studentDashboard.jsp">
            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect
        </a>

        <div class="text-white">
            <i class="bi bi-person-circle me-2"></i>
            <%= user.getName() %>
        </div>

    </div>

</nav>


<section class="hero">

    <div class="container">

        <p class="mb-2">
            Student Dashboard
        </p>

        <h1 class="fw-bold">
            Welcome, <%= user.getName() %>!
        </h1>

        <p class="mb-0">
            Explore opportunities and take the next step in your career.
        </p>

    </div>

</section>


<div class="container py-5">

    <div class="row g-4 mb-5">

        <div class="col-md-4">

            <div class="card stat-card p-4">

                <div class="d-flex align-items-center">

                    <div class="icon-box me-3">
                        <i class="bi bi-briefcase"></i>
                    </div>

                    <div>
                        <small class="text-muted">
                            Opportunities
                        </small>

                        <h3 class="fw-bold mb-0">
                            Explore
                        </h3>
                    </div>

                </div>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card stat-card p-4">

                <div class="d-flex align-items-center">

                    <div class="icon-box me-3">
                        <i class="bi bi-send"></i>
                    </div>

                    <div>
                        <small class="text-muted">
                            Applications
                        </small>

                        <h3 class="fw-bold mb-0">
                            Track
                        </h3>
                    </div>

                </div>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card stat-card p-4">

                <div class="d-flex align-items-center">

                    <div class="icon-box me-3">
                        <i class="bi bi-person"></i>
                    </div>

                    <div>
                        <small class="text-muted">
                            Profile
                        </small>

                        <h3 class="fw-bold mb-0">
                            Manage
                        </h3>
                    </div>

                </div>

            </div>

        </div>

    </div>


    <h3 class="fw-bold mb-4">
        Student Services
    </h3>


    <div class="row g-4">

        <div class="col-md-4">

            <div class="card feature-card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-search"></i>
                </div>

                <h5 class="fw-bold">
                    Browse Opportunities
                </h5>

                <p class="text-muted">
                    Explore jobs and internships posted by companies.
                </p>

                <span class="badge text-bg-secondary coming">
                    Coming Soon
                </span>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card feature-card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-file-earmark-text"></i>
                </div>

                <h5 class="fw-bold">
                    My Applications
                </h5>

                <p class="text-muted">
                    Keep track of the opportunities you have applied for.
                </p>

                <span class="badge text-bg-secondary coming">
                    Coming Soon
                </span>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card feature-card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-person-vcard"></i>
                </div>

                <h5 class="fw-bold">
                    My Profile
                </h5>

                <p class="text-muted">
                    Complete and manage your student profile.
                </p>

                <span class="badge text-bg-secondary coming">
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