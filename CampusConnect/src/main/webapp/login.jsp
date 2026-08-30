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
        body {
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background: #eef4ff;
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .login-card {
            max-width: 1000px;
            width: 100%;
            background: white;
            border-radius: 22px;
            overflow: hidden;
            box-shadow: 0 15px 45px rgba(0,0,0,.12);
        }

        .left-panel {
            background: linear-gradient(135deg, #123b8f, #2563eb);
            color: white;
            min-height: 550px;
            padding: 55px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .brand {
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 50px;
        }

        .left-panel h1 {
            font-size: 42px;
            font-weight: 700;
        }

        .left-panel p {
            line-height: 1.7;
            opacity: .9;
        }

        .right-panel {
            padding: 55px;
        }

        .form-control {
            padding: 13px;
            border-radius: 10px;
        }

        .btn-login {
            padding: 13px;
            border-radius: 10px;
            font-weight: 600;
        }

        .register-link {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }

        @media(max-width: 768px) {
            .left-panel {
                min-height: auto;
                padding: 35px;
            }

            .right-panel {
                padding: 35px;
            }
        }
    </style>
</head>

<body>

<div class="login-wrapper">

    <div class="row g-0 login-card">

        <div class="col-md-6">
            <div class="left-panel">

                <div class="brand">
                    <i class="bi bi-mortarboard-fill"></i>
                    CampusConnect
                </div>

                <h1>Welcome Back!</h1>

                <p class="mt-3">
                    Your campus opportunities, career connections
                    and professional journey — all in one place.
                </p>

                <div class="mt-4">
                    <p>
                        <i class="bi bi-check-circle-fill me-2"></i>
                        Discover opportunities
                    </p>

                    <p>
                        <i class="bi bi-check-circle-fill me-2"></i>
                        Connect with companies
                    </p>

                    <p>
                        <i class="bi bi-check-circle-fill me-2"></i>
                        Build your career
                    </p>
                </div>

            </div>
        </div>


        <div class="col-md-6">
            <div class="right-panel">

                <h2 class="fw-bold">Sign In</h2>

                <p class="text-muted mb-4">
                    Login to your CampusConnect account
                </p>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-circle me-2"></i>
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="alert alert-success">
                        <i class="bi bi-check-circle me-2"></i>
                        <%= request.getAttribute("message") %>
                    </div>
                <% } %>


                <form action="login" method="post">

                    <div class="mb-4">
                        <label class="form-label fw-semibold">
                            Email Address
                        </label>

                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-envelope"></i>
                            </span>

                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="Enter your email"
                                   required>
                        </div>
                    </div>


                    <div class="mb-4">
                        <label class="form-label fw-semibold">
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
                            class="btn btn-primary btn-login w-100">
                        <i class="bi bi-box-arrow-in-right me-2"></i>
                        Login
                    </button>

                </form>


                <div class="text-center mt-4">
                    <span class="text-muted">
                        Don't have an account?
                    </span>

                    <a href="register.jsp" class="register-link">
                        Register here
                    </a>
                </div>

            </div>
        </div>

    </div>

</div>

</body>
</html>