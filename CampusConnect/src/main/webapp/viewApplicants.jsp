<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Application" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"COMPANY".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Application> applications =
        (List<Application>) request.getAttribute("applications");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>View Applicants | CampusConnect</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
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
        }

        /* NAVBAR */

        .navbar-custom {
            background: #071426;
            border-bottom: 1px solid rgba(214,173,82,.18);
            padding: 20px 0;
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 24px;
            font-weight: 750;
            transition: all .3s ease;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .brand:hover {
            color: #ffffff;
            text-shadow: 0 0 10px rgba(214,173,82,.5);
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;

            padding: 9px 16px;

            color: #d6ad52;
            border: 1px solid rgba(214,173,82,.35);
            border-radius: 9px;

            text-decoration: none;
            font-weight: 650;

            transition: all .25s ease;

            box-shadow:
                0 0 7px rgba(214,173,82,.12);
        }

        .back-btn:hover {
            color: #071426;
            background: #d6ad52;

            transform: translateY(-2px);

            box-shadow:
                0 0 10px rgba(214,173,82,.7),
                0 0 22px rgba(214,173,82,.35);
        }

        /* PAGE */

        .page {
            padding: 65px 15px 90px;
            min-height: calc(100vh - 80px);
        }

        .page-header {
            margin-bottom: 35px;
        }

        .page-label {
            color: #d6ad52;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .page-header h1 {
            font-size: 42px;
            font-weight: 800;
            margin-top: 10px;
        }

        .page-header p {
            color: #8d98a6;
            font-size: 16px;
        }

        /* APPLICATION CARD */

        .application-card {
            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border: 1px solid rgba(255,255,255,.09);

            border-radius: 18px;

            padding: 28px;

            margin-bottom: 20px;

            transition: all .3s ease;
        }

        .application-card:hover {
            transform: translateY(-5px);

            border-color:
                rgba(214,173,82,.45);

            box-shadow:
                0 0 15px rgba(214,173,82,.10),
                0 20px 45px rgba(0,0,0,.25);
        }

        .application-icon {
            width: 55px;
            height: 55px;

            border-radius: 14px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: rgba(214,173,82,.10);

            border: 1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            font-size: 24px;

            margin-bottom: 18px;
        }

        .application-card h4 {
            font-size: 20px;
            font-weight: 700;
        }

        .application-card p {
            color: #8d98a6;
            margin-bottom: 8px;
        }

        /* STATUS */

        .status {
            display: inline-flex;
            align-items: center;

            padding: 7px 13px;

            border-radius: 8px;

            background: rgba(214,173,82,.10);

            border: 1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            font-size: 12px;
            font-weight: 750;

            box-shadow:
                0 0 7px rgba(214,173,82,.12);
        }

        /* EMPTY */

        .empty-box {
            text-align: center;

            padding: 70px 20px;

            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border: 1px solid rgba(255,255,255,.09);

            border-radius: 18px;
        }

        .empty-box i {
            font-size: 50px;
            color: #d6ad52;
            margin-bottom: 20px;
        }

        .empty-box h3 {
            font-weight: 700;
        }

        .empty-box p {
            color: #8d98a6;
        }

        /* ERROR */

        .error-box {
            padding: 18px;

            border-radius: 10px;

            background: rgba(214,173,82,.08);

            border: 1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            margin-bottom: 25px;
        }

        /* RESPONSIVE */

        @media (max-width: 768px) {

            .navbar-custom {
                padding: 16px 15px;
            }

            .brand {
                font-size: 21px;
            }

            .page {
                padding: 50px 15px 70px;
            }

            .page-header h1 {
                font-size: 34px;
            }

            .application-card {
                padding: 24px;
            }

            .back-btn {
                padding: 8px 12px;
                font-size: 14px;
            }
        }

        @media (max-width: 480px) {

            .brand {
                font-size: 19px;
            }

            .page {
                padding: 45px 12px 60px;
            }

            .page-header h1 {
                font-size: 30px;
            }

            .application-card {
                padding: 22px;
                border-radius: 15px;
            }

            .back-btn {
                padding: 7px 10px;
                font-size: 13px;
            }
        }

    </style>

</head>

<body>


<!-- NAVBAR -->

<nav class="navbar-custom">

    <div class="container">

        <div class="d-flex
                    justify-content-between
                    align-items-center">

            <a href="companyDashboard.jsp"
               class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>

            <a href="companyDashboard.jsp"
               class="back-btn">

                <i class="bi bi-arrow-left"></i>

                Dashboard

            </a>

        </div>

    </div>

</nav>


<!-- PAGE -->

<section class="page">

    <div class="container">


        <!-- HEADER -->

        <div class="page-header">

            <div class="page-label">
                Company Dashboard
            </div>

            <h1>
                View Applicants
            </h1>

            <p>
                Review students who have applied
                to your opportunities.
            </p>

        </div>


        <!-- ERROR -->

        <% if (request.getAttribute("error") != null) { %>

            <div class="error-box">

                <i class="bi bi-exclamation-circle me-2"></i>

                <%= request.getAttribute("error") %>

            </div>

        <% } %>


        <!-- APPLICATIONS -->

        <%
            if (applications != null && !applications.isEmpty()) {

                for (Application app : applications) {
        %>


        <div class="application-card">

            <div class="application-icon">

                <i class="bi bi-person-fill"></i>

            </div>

            
            <p>
              <strong>Student ID:</strong>
              <%= app.getStudentId() %>
            </p>

            <p>
                <strong>Opportunity ID:</strong>
                <%= app.getOppId() %>
            </p>

            <p>
                <strong>Application ID:</strong>
                <%= app.getAppId() %>
            </p>

            <p>
                <strong>Applied Date:</strong>
                <%= app.getAppliedDate() %>
            </p>

            <div class="mt-3">

                <span class="status">

                    <i class="bi bi-clock me-1"></i>

                    <%= app.getStatus() %>

                </span>

            </div>

        </div>


        <%
                }

            } else {
        %>


        <!-- NO APPLICATIONS -->

        <div class="empty-box">

            <i class="bi bi-people"></i>

            <h3>
                No applicants yet
            </h3>

            <p>
                Students who apply to your
                opportunities will appear here.
            </p>

        </div>


        <%
            }
        %>


    </div>

</section>


</body>

</html>