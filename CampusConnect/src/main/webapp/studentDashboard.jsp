<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.campusconnect.dao.OpportunityDAO" %>
<%@ page import="com.campusconnect.model.Opportunity" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"STUDENT".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    OpportunityDAO opportunityDAO = new OpportunityDAO();
    List<Opportunity> opportunities = opportunityDAO.getAllOpportunities();

    String applyMessage = (String) session.getAttribute("applyMessage");
    session.removeAttribute("applyMessage");
%>
<%
    if (applyMessage != null) {
%>

<div class="container mt-4">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>
        <%= applyMessage %>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>
</div>

<%
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Student Dashboard | CampusConnect</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


<style>

/* ================= GENERAL ================= */

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    background: #071426;
    color: #f5f1e8;
    font-family: "Segoe UI", Arial, sans-serif;
}


/* ================= NAVBAR ================= */

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
    transition: .3s;
}

.brand i {
    color: #d6ad52;
    margin-right: 8px;
}

.brand:hover {
    color: #ffffff;
    text-shadow:
        0 0 8px rgba(214,173,82,.35);
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


/* ================= HERO ================= */

.hero {
    padding: 75px 0;

    background:
        radial-gradient(
            circle at 85% 20%,
            rgba(214,173,82,.12),
            transparent 30%
        ),
        #0a1a2e;

    border-bottom:
        1px solid rgba(214,173,82,.10);
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


/* ================= DASHBOARD ================= */

.dashboard {
    padding: 70px 0 90px;
}

.section-title {
    font-size: 32px;

    font-weight: 750;
}


/* ================= OPPORTUNITY CARD ================= */

.feature-card {
    height: 100%;

    min-height: 300px;

    background:
        linear-gradient(
            145deg,
            rgba(255,255,255,.045),
            rgba(255,255,255,.015)
        );

    border:
        1px solid rgba(255,255,255,.09);

    border-radius: 18px;

    padding: 32px;

    transition: .3s;
}

.feature-card:hover {

    transform: translateY(-7px);

    border-color:
        rgba(214,173,82,.45);

    box-shadow:
        0 20px 45px rgba(0,0,0,.25);
}


/* ================= ICON ================= */

.icon-box {

    width: 58px;
    height: 58px;

    border-radius: 15px;

    background:
        rgba(214,173,82,.10);

    border:
        1px solid rgba(214,173,82,.25);

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
}


/* ================= OPPORTUNITY TYPE ================= */

.opportunity-type {

    display: inline-block;

    color: #d6ad52;

    background:
        rgba(214,173,82,.10);

    border:
        1px solid rgba(214,173,82,.20);

    border-radius: 20px;

    padding: 6px 13px;

    font-size: 12px;

    font-weight: 700;

    text-transform: uppercase;

    letter-spacing: .5px;
}


/* ================= OPPORTUNITY INFO ================= */

.opportunity-location {

    color: #b8c0cb;

    font-size: 14px;

    margin-top: 14px;
}

.opportunity-location i {

    color: #d6ad52;

    margin-right: 5px;
}

.posted-date {

    color: #707b89;

    font-size: 12px;

    margin-top: 6px;
}

.opportunity-description {

    color: #8d98a6;

    line-height: 1.6;

    margin-top: 18px;

    min-height: 70px;
}

.skills-title {

    color: #f5f1e8;

    font-size: 14px;

    font-weight: 700;
}

.skills {

    color: #d6ad52;

    font-size: 14px;
}


/* ================================================= */
/* ================= APPLY BUTTON ================== */
/* ================================================= */

.apply-btn {

    display: inline-flex;

    align-items: center;

    justify-content: center;

    gap: 5px;

    margin-top: 20px;

    padding: 11px 21px;

    border-radius: 9px;

    background: #d6ad52;

    color: #071426;

    text-decoration: none;

    font-weight: 750;

    font-size: 14px;

    border: 1px solid #d6ad52;

    transition:
        transform .25s ease,
        box-shadow .25s ease,
        background .25s ease;

    /* GLOW */

    box-shadow:
        0 0 8px rgba(214,173,82,.35),
        0 0 18px rgba(214,173,82,.18);
}


/* BUTTON HOVER */

.apply-btn:hover {

    background: #f0ca70;

    color: #071426;

    transform:
        translateY(-3px)
        scale(1.02);

    box-shadow:
        0 0 10px rgba(214,173,82,.65),
        0 0 25px rgba(214,173,82,.45),
        0 8px 25px rgba(214,173,82,.25);
}


/* BUTTON CLICK */

.apply-btn:active {

    transform:
        translateY(-1px)
        scale(.98);

    box-shadow:
        0 0 8px rgba(214,173,82,.5);
}


/* ================= EMPTY STATE ================= */

.empty-box {

    border:
        1px dashed rgba(214,173,82,.25);

    border-radius: 18px;

    padding: 50px 20px;

    text-align: center;

    background:
        rgba(255,255,255,.02);
}

.empty-box i {

    font-size: 40px;

    color: #d6ad52;

    margin-bottom: 15px;
}

.empty-box h4 {

    font-weight: 700;
}

.empty-box p {

    color: #8d98a6;
}


/* ================= FOOTER ================= */

footer {

    background: #050f1c;

    border-top:
        1px solid rgba(255,255,255,.06);

    padding: 28px 0;

    color: #707b89;
}


/* ================================================= */
/* ================= RESPONSIVE ==================== */
/* ================================================= */

@media (max-width: 768px) {

    .navbar-custom {
        padding: 16px 0;
    }

    .brand {
        font-size: 21px;
    }

    .user-area {
        font-size: 14px;
    }

    .user-icon {
        width: 35px;
        height: 35px;
    }

    .hero {

        padding: 55px 20px;
    }

    .hero h1 {

        font-size: 38px;

        letter-spacing: -1.5px;
    }

    .hero p {

        font-size: 16px;
    }

    .dashboard {

        padding:
            50px 15px
            70px;
    }

    .section-title {

        font-size: 28px;
    }

    .feature-card {

        min-height: 280px;

        padding: 27px;
    }

    /* RESPONSIVE APPLY BUTTON */

    .apply-btn {

        width: 100%;

        padding: 12px 18px;

        margin-top: 22px;

        font-size: 14px;
    }

}


/* SMALL MOBILE */

@media (max-width: 480px) {

    .brand {

        font-size: 19px;
    }

    .brand i {

        margin-right: 5px;
    }

    .user-area {

        font-size: 13px;
    }

    .user-icon {

        width: 32px;
        height: 32px;

        margin-right: 5px;
    }

    .hero {

        padding:
            45px 18px;
    }

    .hero h1 {

        font-size: 34px;
    }

    .hero-label {

        font-size: 11px;

        letter-spacing: 1.5px;
    }

    .dashboard {

        padding:
            45px 12px
            60px;
    }

    .feature-card {

        padding: 25px;

        border-radius: 15px;
    }

    .opportunity-description {

        min-height: auto;
    }

}


/* ACCESSIBILITY */

.apply-btn:focus {

    outline: none;

    box-shadow:
        0 0 0 3px rgba(214,173,82,.20),
        0 0 18px rgba(214,173,82,.45);
}

</style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar-custom">

<div class="container">

<div class="d-flex justify-content-between align-items-center">

<a href="studentDashboard.jsp"
   class="brand">

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



<!-- ================= HERO ================= -->

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



<!-- ================= OPPORTUNITIES ================= -->

<section class="dashboard">

<div class="container">


<h2 class="section-title mb-2">

Latest Opportunities

</h2>


<p style="color:#8d98a6;"
   class="mb-4">

Explore jobs and internships posted by companies
on CampusConnect.

</p>


<div class="row g-4">


<%

if (opportunities != null && !opportunities.isEmpty()) {

    for (Opportunity opp : opportunities) {

%>


<div class="col-md-6 col-lg-4 d-flex">

<div class="feature-card w-100">


<!-- TYPE -->

<span class="opportunity-type">

<%= opp.getType() %>

</span>



<!-- LOCATION -->

<div class="opportunity-location">

<i class="bi bi-geo-alt-fill"></i>

<%= opp.getLocation() %>

</div>



<!-- POSTED DATE -->

<div class="posted-date">

Posted:

<%= opp.getPostedDate() %>

</div>



<!-- DESCRIPTION -->

<p class="opportunity-description">

<%= opp.getDescription() %>

</p>



<!-- SKILLS -->

<div>

<span class="skills-title">

Skills:

</span>

<span class="skills">

<%= opp.getSkillRequired() %>

</span>

</div>



<!-- APPLY BUTTON -->

<form action="${pageContext.request.contextPath}/apply" method="post">
 <input type="hidden"
           name="oppId"
           value="<%= opp.getOppId() %>">

    <button type="submit" class="apply-btn border-0">

        Apply Now
        <i class="bi bi-arrow-right ms-1"></i>

    </button>

</form>


</div>

</div>


<%

    }

} else {

%>


<!-- ================= EMPTY STATE ================= -->

<div class="col-12">

<div class="empty-box">

<i class="bi bi-briefcase"></i>

<h4>

No opportunities available

</h4>

<p>

There are no jobs or internships posted yet.

Please check back later.

</p>

</div>

</div>


<%

}

%>


</div>

</div>

</section>



<!-- ================= FOOTER ================= -->

<footer>

<div class="container text-center">

<small>

© 2026 CampusConnect · Built for students

</small>

</div>

</footer>


</body>

</html>