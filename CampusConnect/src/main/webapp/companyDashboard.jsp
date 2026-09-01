
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

/* ================================================= */
/* ================= GENERAL ======================= */
/* ================================================= */

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    background: #071426;
    color: #f5f1e8;
    font-family: "Segoe UI", Arial, sans-serif;
}


/* ================================================= */
/* ================= NAVBAR ========================= */
/* ================================================= */

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
    transition: all .3s ease;
}

.brand:hover {
    color: #ffffff;
    text-shadow: 0 0 8px rgba(214,173,82,.35);
}

.brand:hover i {
    text-shadow:
        0 0 8px rgba(214,173,82,.65),
        0 0 18px rgba(214,173,82,.35);
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

    transition: all .3s ease;

    box-shadow:
        0 0 8px rgba(214,173,82,.15);
}

.company-icon:hover {
    transform: scale(1.08);

    box-shadow:
        0 0 10px rgba(214,173,82,.45),
        0 0 20px rgba(214,173,82,.20);
}


/* ================================================= */
/* ================= HERO =========================== */
/* ================================================= */

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
    line-height: 1.7;
}


/* ================================================= */
/* ================= DASHBOARD ===================== */
/* ================================================= */

.dashboard {
    padding: 70px 0 90px;
}

.section-title {
    font-size: 32px;
    font-weight: 750;
}


/* ================================================= */
/* ================= DASHBOARD CARDS ================ */
/* ================================================= */

.dash-card {
    height: 100%;
    min-height: 270px;

    background:
        linear-gradient(
            145deg,
            rgba(255,255,255,.045),
            rgba(255,255,255,.015)
        );

    border: 1px solid rgba(255,255,255,.09);
    border-radius: 18px;

    padding: 32px;

    text-decoration: none;
    color: inherit;

    display: block;

    transition:
        transform .3s ease,
        border-color .3s ease,
        box-shadow .3s ease;
}

.dash-card:hover {
    transform: translateY(-7px);
    color: inherit;

    border-color:
        rgba(214,173,82,.45);

    box-shadow:
        0 0 15px rgba(214,173,82,.10),
        0 20px 45px rgba(0,0,0,.25);
}


/* ================================================= */
/* ================= ICON BOX ======================= */
/* ================================================= */

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

    transition:
        transform .3s ease,
        box-shadow .3s ease,
        background .3s ease;
}

.dash-card:hover .icon-box {
    transform: translateY(-2px);

    background:
        rgba(214,173,82,.14);

    box-shadow:
        0 0 10px rgba(214,173,82,.35),
        0 0 22px rgba(214,173,82,.15);
}


/* ================================================= */
/* ================= CARD CONTENT =================== */
/* ================================================= */

.dash-card h4 {
    font-size: 21px;
    font-weight: 700;
}

.dash-card p {
    color: #8d98a6;
    line-height: 1.7;
    min-height: 65px;
}


/* ================================================= */
/* ================= POST BUTTON ==================== */
/* ================================================= */

.post-btn {
    display: inline-flex;

    align-items: center;
    justify-content: center;

    gap: 8px;

    background: #d6ad52;
    color: #071426;

    border: 1px solid #d6ad52;

    border-radius: 9px;

    padding: 13px 22px;

    font-weight: 750;

    text-decoration: none;

    cursor: pointer;

    transition:
        transform .25s ease,
        box-shadow .25s ease,
        background .25s ease,
        color .25s ease;
    
    box-shadow:
        0 0 8px rgba(214,173,82,.35),
        0 0 18px rgba(214,173,82,.18);
}


/* POST BUTTON HOVER */

.post-btn:hover {
    background: #e3be68;
    color: #071426;

    transform:
        translateY(-3px)
        scale(1.02);

    box-shadow:
        0 0 10px rgba(214,173,82,.75),
        0 0 22px rgba(214,173,82,.55),
        0 8px 25px rgba(214,173,82,.25);
}


/* POST BUTTON ACTIVE */

.post-btn:active {
    transform:
        translateY(-1px)
        scale(.98);

    box-shadow:
        0 0 8px rgba(214,173,82,.55);
}


/* POST BUTTON FOCUS */

.post-btn:focus {
    outline: none;

    box-shadow:
        0 0 0 3px rgba(214,173,82,.20),
        0 0 18px rgba(214,173,82,.55);
}


/* ================================================= */
/* ================= COMING SOON ==================== */
/* ================================================= */

.coming {
    display: inline-flex;

    align-items: center;
    justify-content: center;

    padding: 9px 17px;

    border-radius: 9px;

    background:
        rgba(214,173,82,.10);

    color: #d6ad52;

    border:
        1px solid rgba(214,173,82,.25);

    font-size: 12px;
    font-weight: 750;

    letter-spacing: .3px;

    transition:
        transform .25s ease,
        box-shadow .25s ease,
        background .25s ease,
        color .25s ease;

    box-shadow:
        0 0 7px rgba(214,173,82,.12);
}


/* COMING SOON HOVER */

.coming:hover {
    background:
        rgba(214,173,82,.16);

    color: #f0ca70;

    transform:
        translateY(-3px)
        scale(1.02);

    border-color:
        rgba(214,173,82,.55);

    box-shadow:
        0 0 8px rgba(214,173,82,.45),
        0 0 18px rgba(214,173,82,.25);
}


/* COMING SOON ACTIVE */

.coming:active {
    transform:
        translateY(-1px)
        scale(.98);

    box-shadow:
        0 0 8px rgba(214,173,82,.35);
}


/* COMING SOON FOCUS */

.coming:focus {
    outline: none;

    box-shadow:
        0 0 0 3px rgba(214,173,82,.15),
        0 0 15px rgba(214,173,82,.35);
}


/* ================================================= */
/* ================= OLD FEATURE SECTION ============ */
/* ================================================= */

.feature-card {
    height: 100%;
    min-height: 300px;

    background:
        linear-gradient(
            145deg,
            rgba(255,255,255,.045),
            rgba(255,255,255,.015)
        );

    border: 1px solid rgba(255,255,255,.09);
    border-radius: 18px;

    padding: 32px;

    transition:
        transform .3s ease,
        border-color .3s ease,
        box-shadow .3s ease;
}

.feature-card:hover {
    transform: translateY(-7px);

    border-color:
        rgba(214,173,82,.45);

    box-shadow:
        0 0 15px rgba(214,173,82,.10),
        0 20px 45px rgba(0,0,0,.25);
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


/* ================================================= */
/* ================= FOOTER ========================= */
/* ================================================= */

footer {
    background: #050f1c;

    border-top:
        1px solid rgba(255,255,255,.06);

    padding: 28px 0;

    color: #707b89;
}


/* ================================================= */
/* ================= TABLET ========================= */
/* ================================================= */

@media (max-width: 991px) {

    .hero {
        padding: 60px 25px;
    }

    .hero h1 {
        font-size: 44px;
    }

    .dashboard {
        padding: 60px 20px 80px;
    }

    .dash-card {
        min-height: 270px;
        padding: 28px;
    }

    .post-btn {
        padding: 12px 20px;
    }
}


/* ================================================= */
/* ================= MOBILE ========================= */
/* ================================================= */

@media (max-width: 768px) {

    .navbar-custom {
        padding: 16px 15px;
    }

    .brand {
        font-size: 21px;
    }

    .company-name {
        font-size: 14px;
    }

    .company-icon {
        width: 35px;
        height: 35px;
    }


    /* HERO */

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


    /* DASHBOARD */

    .dashboard {
        padding: 50px 15px 70px;
    }

    .section-title {
        font-size: 28px;
    }


    /* CARDS */

    .dash-card {
        min-height: 280px;
        padding: 27px;
    }

    .dash-card h4 {
        font-size: 20px;
    }

    .dash-card p {
        min-height: auto;
    }


    /* BUTTON */

    .post-btn {
        width: auto;
        min-width: 125px;

        padding: 12px 18px;

        font-size: 14px;
    }

    .coming {
        padding: 9px 16px;
        font-size: 12px;
    }
}


/* ================================================= */
/* ================= SMALL MOBILE =================== */
/* ================================================= */

@media (max-width: 480px) {

    .navbar-custom {
        padding: 15px 12px;
    }

    .brand {
        font-size: 19px;
    }

    .brand i {
        margin-right: 5px;
    }

    .company-name {
        font-size: 13px;
    }

    .company-icon {
        width: 32px;
        height: 32px;
        margin-right: 5px;
    }


    /* HERO */

    .hero {
        padding: 45px 18px;
    }

    .hero h1 {
        font-size: 34px;
    }

    .hero-label {
        font-size: 11px;
        letter-spacing: 1.5px;
    }


    /* DASHBOARD */

    .dashboard {
        padding: 45px 12px 60px;
    }

    .section-title {
        font-size: 26px;
    }


    /* CARDS */

    .dash-card {
        padding: 25px;
        border-radius: 15px;
        min-height: 260px;
    }

    .icon-box {
        width: 54px;
        height: 54px;
        font-size: 23px;
        margin-bottom: 20px;
    }


    /* POST BUTTON */

    .post-btn {
        width: 100%;

        padding: 12px 16px;

        font-size: 14px;
    }


    /* COMING SOON */

    .coming {
        padding: 8px 14px;
        font-size: 11px;
    }
}


/* ================================================= */
/* ================= VERY SMALL ===================== */
/* ================================================= */

@media (max-width: 360px) {

    .brand {
        font-size: 17px;
    }

    .company-name {
        font-size: 12px;
    }

    .company-icon {
        width: 30px;
        height: 30px;
    }

    .hero h1 {
        font-size: 30px;
    }

    .hero p {
        font-size: 14px;
    }

    .dashboard {
        padding: 40px 10px 55px;
    }

    .dash-card {
        padding: 22px;
    }

    .post-btn {
        padding: 11px 14px;
        font-size: 13px;
    }

    .coming {
        font-size: 10px;
        padding: 7px 12px;
    }
}


/* ================================================= */
/* ================= TOUCH DEVICES ================== */
/* ================================================= */

@media (hover: none) {

    .post-btn:active {
        transform: scale(.97);
    }

    .coming:active {
        transform: scale(.97);
    }

    .dash-card:active {
        transform: translateY(-3px);
    }
}

</style>

</head>


<body>


<!-- ================================================= -->
<!-- ================= NAVBAR ======================== -->
<!-- ================================================= -->

<nav class="navbar-custom">

    <div class="container">

        <div class="d-flex justify-content-between align-items-center">

            <a href="companyDashboard.jsp"
               class="brand">

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


<!-- ================================================= -->
<!-- ================= HERO ========================== -->
<!-- ================================================= -->

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


<!-- ================================================= -->
<!-- ================= DASHBOARD ==================== -->
<!-- ================================================= -->

<section class="dashboard">

    <div class="container">

        <h2 class="section-title mb-4">
            Company Tools
        </h2>


        <div class="row g-4">


            <!-- ================================================= -->
            <!-- POST OPPORTUNITY -->
            <!-- ================================================= -->

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


            <!-- ================================================= -->
            <!-- MY POSTINGS -->
            <!-- ================================================= -->

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


           <div class="col-md-4">

    <a href="${pageContext.request.contextPath}/companyapplications"
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

        <span class="post-btn mt-2">
            <i class="bi bi-eye-fill"></i>
            View applicants
        </span>

    </a>

</div>


        </div>

    </div>

</section>


<!-- ================================================= -->
<!-- ================= FOOTER ======================== -->
<!-- ================================================= -->

<footer>

    <div class="container text-center">

        <small>

            © 2026 CampusConnect · Built for companies

        </small>

    </div>

</footer>


</body>

</html>
