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

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    background: #071426;
    color: #f5f1e8;
    font-family: "Segoe UI", Arial, sans-serif;
}

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

.brand i {
    color: #d6ad52;
    margin-right: 8px;
}

.user-area {
    color: #b8c0cb;
    font-weight: 600;
}

.user-icon {
    width: 40px;
    height: 40px;
    background: rgba(214,173,82,.10);
    border: 1px solid rgba(214,173,82,.25);
    color: #d6ad52;
    border-radius: 50%;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-right: 8px;
}

.hero {
    padding: 75px 0;
    background:
        radial-gradient(circle at 85% 20%,
        rgba(214,173,82,.12),
        transparent 30%),
        #0a1a2e;
    border-bottom: 1px solid rgba(214,173,82,.10);
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
    max-width: 650px;
    line-height: 1.7;
}

.dashboard {
    padding: 70px 0 90px;
}

.section-title {
    font-size: 32px;
    font-weight: 750;
}

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

.feature-card h4 {
    font-size: 21px;
    font-weight: 700;
}

.feature-card p {
    color: #8d98a6;
    line-height: 1.7;
    min-height: 60px;
}

.coming {
    background: rgba(214,173,82,.10);
    color: #d6ad52;
    border: 1px solid rgba(214,173,82,.20);
}

footer {
    background: #050f1c;
    border-top: 1px solid rgba(255,255,255,.06);
    padding: 28px 0;
    color: #707b89;
}

@media(max-width:768px) {

    .hero h1 {
        font-size: 38px;
    }

}

</style>

</head>

<body>


<nav class="navbar-custom">

<div class="container">

<div class="d-flex justify-content-between align-items-center">

<a href="studentDashboard.jsp" class="brand">

<i class="bi bi-mortarboard-fill"></i>

CampusConnect

</a>

<div class="user-area">

<span class="user-icon">

<i class="bi bi-person"></i>

</span>

<%= user.getName() %>

</div>

</div>

</div>

</nav>


<section class="hero">

<div class="container">

<div class="hero-label">
Student Dashboard
</div>

<h1 class="mt-3">

Welcome,

<span style="color:#d6ad52;">
<%= user.getName() %>.
</span>

</h1>

<p class="mt-3 mb-0">

Discover opportunities, connect with companies
and take the next step in your career.

</p>

</div>

</section>


<section class="dashboard">

<div class="container">

<h2 class="section-title mb-4">
Your opportunities
</h2>


<div class="row g-4 align-items-stretch">


<div class="col-md-4 d-flex">

<div class="feature-card w-100">

<div class="icon-box">
<i class="bi bi-compass"></i>
</div>

<h4>
Discover Opportunities
</h4>

<p>

Browse jobs and internships posted
by companies on CampusConnect.

</p>

<span class="badge coming">
Coming Soon
</span>

</div>

</div>


<div class="col-md-4 d-flex">

<div class="feature-card w-100">

<div class="icon-box">
<i class="bi bi-file-earmark-text"></i>
</div>

<h4>
My Applications
</h4>

<p>

Keep track of applications and
opportunities you have applied for.

</p>

<span class="badge coming">
Coming Soon
</span>

</div>

</div>


<div class="col-md-4 d-flex">

<div class="feature-card w-100">

<div class="icon-box">
<i class="bi bi-person-vcard"></i>
</div>

<h4>
My Profile
</h4>

<p>

Manage your profile and keep your
information up to date.

</p>

<span class="badge coming">
Coming Soon
</span>

</div>

</div>


</div>

</div>

</section>


<footer>

<div class="container text-center">

<small>
© 2026 CampusConnect · Built for students
</small>

</div>

</footer>


</body>

</html>