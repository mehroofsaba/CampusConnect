<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>CampusConnect</title>

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
            font-family: "Segoe UI", Arial, sans-serif;
            background: #071426;
            color: #f5f1e8;
        }


        /* ================= NAVBAR ================= */

        .navbar-custom {
            padding: 22px 0;
            background: rgba(7, 20, 38, 0.94);
            border-bottom: 1px solid rgba(212, 168, 72, 0.18);
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 25px;
            font-weight: 750;
            letter-spacing: -0.5px;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .nav-login {
            color: #d6ad52;
            text-decoration: none;
            font-weight: 650;
            padding: 9px 18px;
            border: 1px solid rgba(214, 173, 82, 0.5);
            border-radius: 8px;
            transition: .25s;
        }

        .nav-login:hover {
            background: #d6ad52;
            color: #071426;
        }


        /* ================= HERO ================= */

        .hero {
            min-height: 570px;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
            background:
                radial-gradient(
                    circle at 80% 20%,
                    rgba(214, 173, 82, 0.12),
                    transparent 30%
                ),
                #071426;
        }


        .hero::before {
            content: "";
            position: absolute;

            width: 420px;
            height: 420px;

            border-radius: 50%;

            border: 1px solid rgba(214, 173, 82, 0.12);

            right: -130px;
            top: -150px;
        }


        .hero::after {
            content: "";
            position: absolute;

            width: 260px;
            height: 260px;

            border-radius: 50%;

            background: rgba(214, 173, 82, 0.05);

            left: -100px;
            bottom: -120px;
        }


        .hero-content {
            position: relative;
            z-index: 2;
        }


        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;

            color: #d6ad52;

            font-size: 13px;
            font-weight: 700;

            letter-spacing: 2px;
            text-transform: uppercase;

            margin-bottom: 20px;
        }


        .eyebrow span {
            width: 30px;
            height: 1px;
            background: #d6ad52;
            display: inline-block;
        }


        .hero h1 {
            font-size: clamp(48px, 7vw, 78px);
            line-height: 1.02;

            font-weight: 800;

            letter-spacing: -3px;

            max-width: 800px;

            margin-bottom: 25px;
        }


        .gold-text {
            color: #d6ad52;
        }


        .hero-description {
            color: #b8c0cb;

            max-width: 620px;

            font-size: 18px;

            line-height: 1.7;

            margin-bottom: 35px;
        }


        /* ================= BUTTONS ================= */

        .btn-gold {
            display: inline-flex;
            align-items: center;
            gap: 9px;

            background: #d6ad52;
            color: #071426;

            border: none;

            padding: 14px 25px;

            border-radius: 9px;

            font-weight: 750;

            text-decoration: none;

            transition: .25s;

            box-shadow:
                0 8px 25px rgba(214, 173, 82, 0.18);
        }


        .btn-gold:hover {
            background: #e3be68;
            color: #071426;

            transform: translateY(-3px);

            box-shadow:
                0 12px 30px rgba(214, 173, 82, 0.25);
        }


        .btn-outline-gold {
            display: inline-flex;
            align-items: center;
            gap: 9px;

            background: transparent;

            color: #d6ad52;

            border: 1px solid rgba(214, 173, 82, 0.55);

            padding: 13px 24px;

            border-radius: 9px;

            font-weight: 650;

            text-decoration: none;

            transition: .25s;

            margin-left: 10px;
        }


        .btn-outline-gold:hover {
            background: rgba(214, 173, 82, 0.08);

            color: #e3be68;

            border-color: #d6ad52;

            transform: translateY(-2px);
        }


        /* ================= STATS ================= */

        .stats {
            display: flex;
            gap: 35px;

            margin-top: 50px;
        }


        .stat {
            border-left: 2px solid #d6ad52;

            padding-left: 14px;
        }


        .stat strong {
            display: block;

            color: #f5f1e8;

            font-size: 22px;
        }


        .stat span {
            color: #7f8a98;

            font-size: 13px;
        }


        /* ================= FEATURES ================= */

        .features {
            background: #0a1a2e;

            padding: 90px 0;

            border-top: 1px solid rgba(214, 173, 82, 0.10);
        }


        .section-heading {
            text-align: center;

            margin-bottom: 55px;
        }


        .section-heading small {
            color: #d6ad52;

            text-transform: uppercase;

            letter-spacing: 2px;

            font-weight: 700;
        }


        .section-heading h2 {
            font-size: 38px;

            font-weight: 750;

            margin-top: 10px;

            letter-spacing: -1px;
        }


        .section-heading p {
            color: #8793a1;

            max-width: 600px;

            margin: 12px auto 0;

            line-height: 1.7;
        }


        /* ================= CARDS ================= */

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

            position: relative;

            overflow: hidden;

            transition: .3s;
        }


        .feature-card::after {
            content: "";

            position: absolute;

            width: 110px;
            height: 110px;

            border-radius: 50%;

            background: rgba(214,173,82,.06);

            right: -45px;
            bottom: -45px;
        }


        .feature-card:hover {
            transform: translateY(-8px);

            border-color:
                rgba(214,173,82,.45);

            box-shadow:
                0 20px 45px rgba(0,0,0,.25);
        }


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

            margin-bottom: 13px;
        }


        .feature-card p {
            color: #8d98a6;

            line-height: 1.7;

            margin-bottom: 0;
        }


        /* ================= CTA ================= */

        .cta {
            padding: 90px 0;

            background: #071426;
        }


        .cta-box {
            padding: 55px;

            border-radius: 20px;

            background:
                linear-gradient(
                    135deg,
                    #10263f,
                    #0b1b2f
                );

            border:
                1px solid rgba(214,173,82,.22);

            text-align: center;

            position: relative;

            overflow: hidden;
        }


        .cta-box::before {
            content: "";

            position: absolute;

            width: 200px;
            height: 200px;

            border-radius: 50%;

            border:
                1px solid rgba(214,173,82,.12);

            top: -120px;
            left: -70px;
        }


        .cta-box h2 {
            font-size: 35px;

            font-weight: 750;

            margin-bottom: 13px;
        }


        .cta-box p {
            color: #9da8b5;

            margin-bottom: 28px;
        }


        /* ================= FOOTER ================= */

        footer {
            padding: 28px 0;

            background: #050f1c;

            border-top:
                1px solid rgba(255,255,255,.06);

            color: #707b89;
        }


        footer .brand {
            font-size: 19px;
        }


        footer .brand i {
            font-size: 17px;
        }


        @media(max-width: 768px) {

            .hero {
                min-height: 620px;
            }

            .hero h1 {
                letter-spacing: -2px;
            }

            .btn-outline-gold {
                margin-left: 0;
                margin-top: 12px;
            }

            .stats {
                gap: 20px;
                flex-wrap: wrap;
            }

            .feature-card {
                min-height: 260px;
            }

            .cta-box {
                padding: 40px 25px;
            }

        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar-custom">

    <div class="container">

        <div class="d-flex justify-content-between align-items-center">

            <a href="index.jsp" class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>


            <a href="login.jsp"
               class="nav-login">

                Sign in

            </a>

        </div>

    </div>

</nav>



<!-- ================= HERO ================= -->

<section class="hero">

    <div class="container">

        <div class="hero-content">

            <div class="eyebrow">

                <span></span>

                Campus opportunities, reimagined

            </div>


            <h1>

                Find where your

                <span class="gold-text">
                    potential
                </span>

                takes you.

            </h1>


            <p class="hero-description">

                CampusConnect brings students and companies
                together in one simple platform — making it
                easier to discover opportunities, connect with
                talent and build what comes next.

            </p>


            <div>

                <a href="register.jsp"
                   class="btn-gold">

                    Get started

                    <i class="bi bi-arrow-right"></i>

                </a>


                <a href="login.jsp"
                   class="btn-outline-gold">

                    Sign in

                </a>

            </div>


            <div class="stats">

                <div class="stat">

                    <strong>
                        Students
                    </strong>

                    <span>
                        Discover opportunities
                    </span>

                </div>


                <div class="stat">

                    <strong>
                        Companies
                    </strong>

                    <span>
                        Find emerging talent
                    </span>

                </div>


                <div class="stat">

                    <strong>
                        One platform
                    </strong>

                    <span>
                        Built for campus
                    </span>

                </div>

            </div>

        </div>

    </div>

</section>



<!-- ================= FEATURES ================= -->

<section class="features">

    <div class="container">


        <div class="section-heading">

            <small>
                Why CampusConnect
            </small>

            <h2>
                Everything starts here.
            </h2>

            <p>

                A focused platform designed to make
                campus opportunities easier to discover,
                explore and pursue.

            </p>

        </div>


        <div class="row g-4 align-items-stretch">


            <!-- CARD 1 -->

            <div class="col-lg-4 col-md-6 d-flex">

                <div class="feature-card w-100">

                    <div class="icon-box">

                        <i class="bi bi-compass"></i>

                    </div>


                    <h4>
                        Discover Opportunities
                    </h4>


                    <p>

                        Explore internships and job
                        opportunities that match your
                        interests and career goals.

                    </p>

                </div>

            </div>



            <!-- CARD 2 -->

            <div class="col-lg-4 col-md-6 d-flex">

                <div class="feature-card w-100">

                    <div class="icon-box">

                        <i class="bi bi-building"></i>

                    </div>


                    <h4>
                        Connect with Companies
                    </h4>


                    <p>

                        Discover companies looking for
                        motivated students and emerging
                        talent.

                    </p>

                </div>

            </div>



            <!-- CARD 3 -->

            <div class="col-lg-4 col-md-6 d-flex">

                <div class="feature-card w-100">

                    <div class="icon-box">

                        <i class="bi bi-rocket-takeoff"></i>

                    </div>


                    <h4>
                        Grow Your Career
                    </h4>


                    <p>

                        Turn opportunities into experience
                        and take meaningful steps toward
                        your future.

                    </p>

                </div>

            </div>



            <!-- CARD 4 -->

            <div class="col-lg-4 col-md-6 d-flex">

                <div class="feature-card w-100">

                    <div class="icon-box">

                        <i class="bi bi-search"></i>

                    </div>


                    <h4>
                        Easy to Explore
                    </h4>


                    <p>

                        Find relevant opportunities without
                        navigating through complicated
                        systems.

                    </p>

                </div>

            </div>



            <!-- CARD 5 -->

            <div class="col-lg-4 col-md-6 d-flex">

                <div class="feature-card w-100">

                    <div class="icon-box">

                        <i class="bi bi-people"></i>

                    </div>


                    <h4>
                        Built for Students
                    </h4>


                    <p>

                        A simple experience focused on
                        helping students move from campus
                        to career.

                    </p>

                </div>

            </div>



            <!-- CARD 6 -->

            <div class="col-lg-4 col-md-6 d-flex">

                <div class="feature-card w-100">

                    <div class="icon-box">

                        <i class="bi bi-stars"></i>

                    </div>


                    <h4>
                        One Connected Platform
                    </h4>


                    <p>

                        Students, companies and opportunities
                        come together in one place.

                    </p>

                </div>

            </div>


        </div>

    </div>

</section>



<!-- ================= CTA ================= -->

<section class="cta">

    <div class="container">

        <div class="cta-box">

            <h2>
                Ready to connect?
            </h2>

            <p>

                Create your account and start exploring
                CampusConnect.

            </p>


            <a href="register.jsp"
               class="btn-gold">

                Join CampusConnect

                <i class="bi bi-arrow-right"></i>

            </a>

        </div>

    </div>

</section>



<!-- ================= FOOTER ================= -->

<footer>

    <div class="container">

        <div class="d-flex justify-content-between
                    align-items-center flex-wrap gap-3">

            <a href="index.jsp" class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>


            <small>

                © 2026 CampusConnect · Connecting
                students with opportunities.

            </small>

        </div>

    </div>

</footer>


</body>

</html>