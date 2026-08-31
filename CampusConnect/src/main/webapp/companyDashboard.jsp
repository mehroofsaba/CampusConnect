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
}

.brand:hover {
    color: #f5f1e8;
}

.brand i {
    color: #d6ad52;
    margin-right: 8px;
}

.company-name {
    color: #b8c0cb;
    font-weight: 600;
}

.company-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: rgba(214,173,82,.10);
    border: 1px solid rgba(214,173,82,.25);
    color: #d6ad52;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-right: 8px;
}


/* HERO */

.hero {
    padding: 75px 0;
    background:
        radial-gradient(circle at 85% 20%,
        rgba(214,173,82,.12),
        transparent 30%),
        #0a1a2e;
}

.hero-label {
    color: #d6ad52;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 2px;
    text-transform: uppercase;
}

.hero h1 {
    font-size: 50px;
    font-weight: 800;
    letter-spacing: -2px;
}

.hero p {
    color: #8d98a6;
    font-size: 17px;
    line-height: 1.7;
}


/* DASHBOARD */

.dashboard {
    padding: 70px 0 90px;
}

.section-title {
    font-size: 32px;
    font-weight: 750;
}


/* DASHBOARD CARDS */

.dash-card {
    height: 100%;
    min-height: 270px;
    background: linear-gradient(145deg,
        rgba(255,255,255,.045),
        rgba(255,255,255,.015));
    border: 1px solid rgba(255,255,255,.09);
    border-radius: 18px;
    padding: 32px;
    text-decoration: none;
    color: inherit;
    display: block;
    transition: .3s;
}

.dash-card:hover {
    transform: translateY(-7px);
    color: inherit;
    border-color: rgba(214,173,82,.45);
    box-shadow: 0 20px 45px rgba(0,0,0,.25);
}

.icon-box {
    width: 58px;
    height: 58px;
    border-radius: 15px;
    background: rgba(214,173,82,.10);
    border: 1px solid rgba(214,173,82,.25);
    color: #d6ad52;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 25px;
    margin-bottom: 25px;
}

.dash-card h4 {
    font-size: 21px;
    font-weight: 700;
}

.dash-card p {
    color: #8d98a6;
    line-height: 1.7;
}


/* OLD FEATURE SECTION */

.feature-card {
    height: 100%;
    min-height: 300px;
    background: linear-gradient(145deg,
        rgba(255,255,255,.045),
        rgba(255,255,255,.015));
    border: 1px solid rgba(255,255,255,.09);
    border-radius: 18px;
    padding: 32px;
    transition: .3s;
}

.feature-card:hover {
    transform: translateY(-7px);
    border-color: rgba(214,173,82,.45);
    box-shadow: 0 20px 45px rgba(0,0,0,.25);
}

.feature-card h4 {
    font-size: 21px;
    font-weight: 700;
}

.feature-card p {
    color: #8d98a6;
    line-height: 1.7;
    min-height: 60px;
}


/* BUTTON */

.post-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: #d6ad52;
    color: #071426;
    border-radius: 9px;
    padding: 13px 22px;
    font-weight: 750;
    text-decoration: none;
    transition: .25s;
}

.post-btn:hover {
    background: #e3be68;
    color: #071426;
    transform: translateY(-2px);
}

.btn-outline-dark {
    color: #d6ad52;
    border-color: rgba(214,173,82,.45);
}

.btn-outline-dark:hover {
    background: #d6ad52;
    color: #071426;
    border-color: #d6ad52;
}


/* COMING SOON */

.coming {
    background: rgba(214,173,82,.10);
    color: #d6ad52;
    border: 1px solid rgba(214,173,82,.20);
}


/* FOOTER */

footer {
    background: #050f1c;
    border-top: 1px solid rgba(255,255,255,.06);
    padding: 28px 0;
    color: #707b89;
}

</style>

</head>


<body>


<!-- NAVBAR -->

<nav class="navbar-custom">

    <div class="container">

        <div class="d-flex justify-content-between align-items-center">

            <a href="companyDashboard.jsp" class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>


            <div class="company-name">

                <span class="company-icon">

                    <i class="bi bi-building"></i>

                </span>

                <%= user.getName() %>

            </div>

        </div>

    </div>

</nav>



<!-- HERO -->

<section class="hero">

    <div class="container">

        <div class="hero-label">
            Company Dashboard
        </div>


        <h1 class="mt-3">

            Welcome,

            <span style="color:#d6ad52;">

                <%= user.getName() %>.

            </span>

        </h1>


        <p class="mt-3 mb-0">

            Connect with talented students and build
            your next generation of talent.

        </p>

    </div>

</section>



<!-- DASHBOARD -->

<section class="dashboard">

    <div class="container">


        <h2 class="section-title mb-4">

            Company Tools

        </h2>


        <div class="row g-4">


            <!-- POST OPPORTUNITY -->

            <div class="col-md-4">

                <a href="postJob.jsp"
                   class="dash-card">

                    <div class="icon-box">

                        <i class="bi bi-briefcase-fill"></i>

                    </div>


                    <h4>

                        Post Opportunity

                    </h4>


                    <p>

                        Create and publish a new
                        job or internship opportunity
                        for students.

                    </p>


                    <span class="post-btn mt-2">

                        <i class="bi bi-plus-lg"></i>

                        Post now

                    </span>

                </a>

            </div>



            <!-- MY POSTINGS -->

            <div class="col-md-4">

                <a href="#"
                   class="dash-card">

                    <div class="icon-box">

                        <i class="bi bi-list-check"></i>

                    </div>


                    <h4>

                        My Postings

                    </h4>


                    <p>

                        View and manage all the
                        jobs and internships you
                        have posted.

                    </p>


                    <span class="badge coming mt-2">

                        Coming Soon

                    </span>

                </a>

            </div>



            <!-- APPLICANTS -->

            <div class="col-md-4">

                <a href="#"
                   class="dash-card">

                    <div class="icon-box">

                        <i class="bi bi-people-fill"></i>

                    </div>


                    <h4>

                        View Applicants

                    </h4>


                    <p>

                        Review students who applied
                        to your job and internship
                        opportunities.

                    </p>


                    <span class="badge coming mt-2">

                        Coming Soon

                    </span>

                </a>

            </div>


        </div>


    </div>

</section>



<!-- FOOTER -->

<footer>

    <div class="container text-center">

        <small>

            © 2026 CampusConnect · Built for companies

        </small>

    </div>

</footer>



</body>

</html>