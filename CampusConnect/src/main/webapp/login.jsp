<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login | CampusConnect</title>

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
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #071426;
            color: #f5f1e8;
        }

        /* NAVBAR */

        .navbar-custom {
            padding: 22px 0;
            background: rgba(7,20,38,.95);
            border-bottom: 1px solid rgba(214,173,82,.18);
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 25px;
            font-weight: 750;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .home-link {
            color: #d6ad52;
            text-decoration: none;
            font-weight: 650;
        }

        .home-link:hover {
            color: #e3be68;
        }

        /* MAIN */

        .login-section {
            min-height: calc(100vh - 90px);
            display: flex;
            align-items: center;
            padding: 50px 0;
            position: relative;
            overflow: hidden;
        }

        .login-section::before {
            content: "";
            position: absolute;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            border: 1px solid rgba(214,173,82,.12);
            right: -160px;
            top: -150px;
        }

        .login-section::after {
            content: "";
            position: absolute;
            width: 280px;
            height: 280px;
            border-radius: 50%;
            background: rgba(214,173,82,.04);
            left: -120px;
            bottom: -120px;
        }

        .login-card {
            max-width: 950px;
            margin: auto;
            background: #0a1a2e;
            border: 1px solid rgba(214,173,82,.20);
            border-radius: 22px;
            overflow: hidden;
            box-shadow: 0 25px 70px rgba(0,0,0,.35);
            position: relative;
            z-index: 2;
        }

        /* LEFT */

        .login-info {
            height: 100%;
            min-height: 550px;
            padding: 55px;
            background:
                linear-gradient(145deg,#10263f,#0b1b2f);
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-right: 1px solid rgba(214,173,82,.12);
        }

        .gold-line {
            width: 45px;
            height: 3px;
            background: #d6ad52;
            margin-bottom: 25px;
        }

        .login-info h1 {
            font-size: 45px;
            font-weight: 800;
            letter-spacing: -2px;
        }

        .login-info p {
            color: #9da8b5;
            line-height: 1.7;
            max-width: 400px;
        }

        .info-item {
            margin-top: 28px;
            display: flex;
            align-items: center;
            gap: 13px;
            color: #c4ccd5;
        }

        .info-item i {
            color: #d6ad52;
            font-size: 20px;
        }

        /* FORM */

        .login-form {
            padding: 55px;
            background: #0a1a2e;
        }

        .login-form h2 {
            font-size: 32px;
            font-weight: 750;
        }

        .subtitle {
            color: #7f8a98;
            margin-bottom: 32px;
        }

        .form-label {
            color: #e8e4db;
            font-weight: 650;
            margin-bottom: 8px;
        }

        .input-group-text {
            background: #10263f;
            border-color: rgba(255,255,255,.12);
            color: #d6ad52;
        }

        .form-control {
            padding: 13px;
            background: #071426;
            border-color: rgba(255,255,255,.12);
            color: #f5f1e8;
        }

        .form-control::placeholder {
            color: #667384;
        }

        .form-control:focus {
            background: #071426;
            color: #f5f1e8;
            border-color: #d6ad52;
            box-shadow: 0 0 0 3px rgba(214,173,82,.12);
        }

        .login-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 9px;
            background: #d6ad52;
            color: #071426;
            font-weight: 750;
            transition: .25s;
        }

        .login-btn:hover {
            background: #e3be68;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(214,173,82,.18);
        }

        .register-text {
            text-align: center;
            margin-top: 25px;
            color: #7f8a98;
        }

        .register-text a {
            color: #d6ad52;
            font-weight: 700;
            text-decoration: none;
        }

        .alert {
            background: rgba(180,70,70,.12);
            border: 1px solid rgba(220,100,100,.25);
            color: #e8b5b5;
        }

        @media(max-width:768px) {

            .login-info {
                min-height: auto;
                padding: 40px;
            }

            .login-form {
                padding: 40px;
            }

        }

    </style>

</head>


<body>


<nav class="navbar-custom">

    <div class="container">

        <div class="d-flex justify-content-between align-items-center">

            <a href="index.jsp" class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>

            <a href="index.jsp" class="home-link">

                <i class="bi bi-arrow-left me-1"></i>

                Home

            </a>

        </div>

    </div>

</nav>


<section class="login-section">

    <div class="container">

        <div class="row login-card">


            <!-- LEFT -->

            <div class="col-lg-6">

                <div class="login-info">

                    <div class="gold-line"></div>

                    <h1>

                        Welcome<br>

                        <span style="color:#d6ad52;">
                            back.
                        </span>

                    </h1>

                    <p class="mt-3">

                        Sign in to continue exploring
                        opportunities and connecting
                        with your campus community.

                    </p>


                    <div class="info-item">

                        <i class="bi bi-compass"></i>

                        Discover opportunities

                    </div>


                    <div class="info-item">

                        <i class="bi bi-building"></i>

                        Connect with companies

                    </div>


                    <div class="info-item">

                        <i class="bi bi-rocket-takeoff"></i>

                        Build your career

                    </div>

                </div>

            </div>


            <!-- RIGHT -->

            <div class="col-lg-6">

                <div class="login-form">

                    <h2>Sign in</h2>

                    <p class="subtitle">

                        Enter your details to continue.

                    </p>


                    <% if (request.getAttribute("error") != null) { %>

                        <div class="alert mb-4">

                            <i class="bi bi-exclamation-circle me-2"></i>

                            <%= request.getAttribute("error") %>

                        </div>

                    <% } %>


                    <form action="login" method="post">


                        <div class="mb-4">

                            <label class="form-label">
                                Email address
                            </label>

                            <div class="input-group">

                                <span class="input-group-text">

                                    <i class="bi bi-envelope"></i>

                                </span>

                                <input type="email"
                                       name="email"
                                       class="form-control"
                                       placeholder="you@example.com"
                                       required>

                            </div>

                        </div>


                        <div class="mb-4">

                            <label class="form-label">
                                Password
                            </label>

                            <div class="input-group">

                                <span class="input-group-text">

                                    <i class="bi bi-lock"></i>

                                </span>

                                <input type="password"
                                       name="password"
                                       class="form-control"
                                       placeholder="Enter your password"
                                       required>

                            </div>

                        </div>


                        <button type="submit"
                                class="login-btn">

                            Sign in

                            <i class="bi bi-arrow-right ms-2"></i>

                        </button>


                    </form>


                    <div class="register-text">

                        Don't have an account?

                        <a href="register.jsp">
                            Create one
                        </a>

                    </div>

                </div>

            </div>


        </div>

    </div>

</section>


</body>

</html>