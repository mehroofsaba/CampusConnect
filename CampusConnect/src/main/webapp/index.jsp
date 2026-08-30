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

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
        }

        .hero {
            min-height: 100vh;
            background: linear-gradient(135deg, #123b8f, #2563eb);
            color: white;
            display: flex;
            align-items: center;
        }

        .brand {
            font-size: 30px;
            font-weight: bold;
        }

        .hero h1 {
            font-size: 58px;
            font-weight: 800;
        }

        .hero p {
            font-size: 19px;
            line-height: 1.7;
            max-width: 650px;
            opacity: .9;
        }

        .btn-custom {
            padding: 13px 28px;
            border-radius: 10px;
            font-weight: 600;
            margin-right: 10px;
        }

        .feature {
    background: white;
    border-radius: 16px;
    padding: 25px;
    margin-top: 0;
    width: 100%;
    height: 100%;
}

        .icon {
            font-size: 32px;
            margin-bottom: 10px;
        }

        @media(max-width:768px) {

            .hero h1 {
                font-size: 40px;
            }

        }

    </style>

</head>

<body>

<section class="hero">

    <div class="container">

        <div class="brand mb-5">
            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect
        </div>

        <h1>
            Connect.<br>
            Discover.<br>
            Grow.
        </h1>

        <p class="mt-4">
            A campus opportunity platform connecting students
            with companies, jobs and internships.
        </p>

        <div class="mt-4">

            <a href="login.jsp"
               class="btn btn-light btn-custom">

                <i class="bi bi-box-arrow-in-right me-2"></i>
                Login

            </a>

            <a href="register.jsp"
               class="btn btn-outline-light btn-custom">

                <i class="bi bi-person-plus me-2"></i>
                Create Account

            </a>

        </div>


        <div class="row mt-5 g-4 align-items-stretch">

    <div class="col-md-4 d-flex">

        <div class="feature text-dark w-100 h-100">

            <div class="icon">
                <i class="bi bi-search"></i>
            </div>

            <h5 class="fw-bold">
                Discover
            </h5>

            <p class="text-muted mb-0">
                Find opportunities that match your interests.
            </p>

        </div>

    </div>


    <div class="col-md-4 d-flex">

        <div class="feature text-dark w-100 h-100">

            <div class="icon">
                <i class="bi bi-building"></i>
            </div>

            <h5 class="fw-bold">
                Connect
            </h5>

            <p class="text-muted mb-0">
                Connect students with organizations.
            </p>

        </div>

    </div>


    <div class="col-md-4 d-flex">

        <div class="feature text-dark w-100 h-100">

            <div class="icon">
                <i class="bi bi-rocket-takeoff"></i>
            </div>

            <h5 class="fw-bold">
                Grow
            </h5>

            <p class="text-muted mb-0">
                Take the next step in your career.
            </p>

        </div>

    </div>

</div>

            </div>

        </div>

    </div>

</section>

</body>
</html>