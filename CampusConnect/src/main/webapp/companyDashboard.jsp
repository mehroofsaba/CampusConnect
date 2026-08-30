<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusconnect.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"COMPANY".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Company Dashboard | CampusConnect</title>

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

        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,.06);
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

        .post-btn {
            padding: 12px 22px;
            border-radius: 10px;
            font-weight: 600;
        }

    </style>

</head>

<body>


<nav class="navbar navbar-dark">

    <div class="container">

        <a class="navbar-brand" href="companyDashboard.jsp">
            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect
        </a>

        <span class="text-white">
            <i class="bi bi-building me-2"></i>
            <%= user.getName() %>
        </span>

    </div>

</nav>


<section class="hero">

    <div class="container">

        <p class="mb-2">
            Company Dashboard
        </p>

        <h1 class="fw-bold">
            Welcome, <%= user.getName() %>!
        </h1>

        <p class="mb-0">
            Find talented students and post opportunities for your organization.
        </p>

    </div>

</section>


<div class="container py-5">

    <div class="card p-4 mb-4">

        <div class="row align-items-center">

            <div class="col-md-8">

                <h3 class="fw-bold">
                    Post a New Opportunity
                </h3>

                <p class="text-muted mb-0">
                    Create a job or internship opportunity for students.
                </p>

            </div>

            <div class="col-md-4 text-md-end mt-3 mt-md-0">

                <a href="postJob.jsp"
                   class="btn btn-primary post-btn">

                    <i class="bi bi-plus-circle me-2"></i>
                    Post Job / Internship

                </a>

            </div>

        </div>

    </div>


    <h3 class="fw-bold mb-4">
        Company Services
    </h3>


    <div class="row g-4">

        <div class="col-md-4">

            <div class="card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-megaphone"></i>
                </div>

                <h5 class="fw-bold">
                    Post Opportunities
                </h5>

                <p class="text-muted">
                    Publish jobs and internships for students.
                </p>

                <a href="postJob.jsp"
                   class="btn btn-outline-primary">
                    Post Now
                </a>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-people"></i>
                </div>

                <h5 class="fw-bold">
                    Student Applications
                </h5>

                <p class="text-muted">
                    View and manage applications from students.
                </p>

                <span class="badge text-bg-secondary">
                    Coming Soon
                </span>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card p-4 h-100">

                <div class="icon-box mb-3">
                    <i class="bi bi-list-check"></i>
                </div>

                <h5 class="fw-bold">
                    Manage Opportunities
                </h5>

                <p class="text-muted">
                    Manage your posted jobs and internships.
                </p>

                <span class="badge text-bg-secondary">
                    Coming Soon
                </span>

            </div>

        </div>

    </div>

</div>


<footer class="text-center text-muted py-4">
    <small>© 2026 CampusConnect</small>
</footer>


</body>
</html>