<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register | CampusConnect</title>

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

        .register-wrapper {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .register-card {
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 22px;
            overflow: hidden;
            box-shadow: 0 15px 45px rgba(0,0,0,.12);
        }

        .info-panel {
            background: linear-gradient(135deg, #123b8f, #2563eb);
            color: white;
            padding: 50px;
            min-height: 600px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .brand {
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .form-panel {
            padding: 50px;
        }

        .form-control,
        .form-select {
            padding: 13px;
            border-radius: 10px;
        }

        .btn-register {
            padding: 13px;
            border-radius: 10px;
            font-weight: 600;
        }

        .login-link {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }

        @media(max-width: 768px) {
            .info-panel {
                min-height: auto;
                padding: 35px;
            }

            .form-panel {
                padding: 35px;
            }
        }

    </style>

</head>

<body>

<div class="register-wrapper">

    <div class="row g-0 register-card">

        <!-- INFORMATION -->

        <div class="col-md-5">

            <div class="info-panel">

                <div class="brand">
                    <i class="bi bi-mortarboard-fill"></i>
                    CampusConnect
                </div>

                <h2 class="fw-bold">
                    Start Your Journey
                </h2>

                <p class="mt-3">
                    Join CampusConnect and explore opportunities
                    that can help you take the next step in your career.
                </p>

                <div class="mt-4">

                    <p>
                        <i class="bi bi-briefcase-fill me-2"></i>
                        Find jobs and internships
                    </p>

                    <p>
                        <i class="bi bi-building me-2"></i>
                        Connect with companies
                    </p>

                    <p>
                        <i class="bi bi-people-fill me-2"></i>
                        Build professional connections
                    </p>

                </div>

            </div>

        </div>


        <!-- FORM -->

        <div class="col-md-7">

            <div class="form-panel">

                <h2 class="fw-bold">
                    Create Account
                </h2>

                <p class="text-muted mb-4">
                    Register for CampusConnect
                </p>


                <% if (request.getAttribute("error") != null) { %>

                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-circle me-2"></i>
                        <%= request.getAttribute("error") %>
                    </div>

                <% } %>


                <form action="register" method="post">

                    <div class="mb-3">

                        <label class="form-label fw-semibold">
                            Name
                        </label>

                        <input type="text"
                               name="name"
                               class="form-control"
                               placeholder="Enter your name"
                               required>

                    </div>


                    <div class="mb-3">

                        <label class="form-label fw-semibold">
                            Email
                        </label>

                        <input type="email"
                               name="email"
                               class="form-control"
                               placeholder="Enter your email"
                               required>

                    </div>


                    <div class="mb-3">

                        <label class="form-label fw-semibold">
                            Password
                        </label>

                        <input type="password"
                               name="password"
                               class="form-control"
                               placeholder="Create a password"
                               minlength="4"
                               required>

                    </div>


                    <div class="mb-4">

                        <label class="form-label fw-semibold">
                            Register As
                        </label>

                        <select name="role"
                                class="form-select"
                                required>

                            <option value="" selected disabled>
                                Select your role
                            </option>

                            <option value="STUDENT">
                                Student
                            </option>

                            <option value="COMPANY">
                                Company
                            </option>

                        </select>

                    </div>


                    <button type="submit"
                            class="btn btn-primary btn-register w-100">

                        <i class="bi bi-person-plus-fill me-2"></i>
                        Create Account

                    </button>

                </form>


                <div class="text-center mt-4">

                    <span class="text-muted">
                        Already have an account?
                    </span>

                    <a href="login.jsp" class="login-link">
                        Login here
                    </a>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>