<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Post Opportunity | CampusConnect</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            background: #f5f7fb;
            font-family: Arial, sans-serif;
        }

        .navbar {
            background: #123b8f;
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 24px;
        }

        .page-wrapper {
            padding: 50px 15px;
        }

        .form-card {
            max-width: 750px;
            margin: auto;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 30px rgba(0,0,0,.08);
        }

        .form-control,
        .form-select {
            padding: 12px;
            border-radius: 10px;
        }

        textarea {
            resize: vertical;
        }

        .submit-btn {
            padding: 13px;
            border-radius: 10px;
            font-weight: 600;
        }

    </style>

</head>

<body>


<nav class="navbar navbar-dark">

    <div class="container">

        <a class="navbar-brand" href="companyDashboard.jsp">
            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect
        </a>

        <a href="companyDashboard.jsp"
           class="btn btn-outline-light">

            <i class="bi bi-arrow-left me-1"></i>
            Dashboard

        </a>

    </div>

</nav>


<div class="page-wrapper">

    <div class="form-card">

        <div class="text-center mb-4">

            <div class="mb-3"
                 style="font-size:45px;color:#2563eb;">

                <i class="bi bi-briefcase-fill"></i>

            </div>

            <h2 class="fw-bold">
                Post an Opportunity
            </h2>

            <p class="text-muted">
                Create a new job or internship opportunity.
            </p>

        </div>


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


        <form action="postOpportunity" method="post">


            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Opportunity Title
                </label>

                <input type="text"
                       name="title"
                       class="form-control"
                       placeholder="e.g. Java Developer Intern"
                       required>

            </div>


            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Opportunity Type
                </label>

                <select name="type"
                        class="form-select"
                        required>

                    <option value="" selected disabled>
                        Select type
                    </option>

                    <option value="JOB">
                        Full-Time Job
                    </option>

                    <option value="INTERNSHIP">
                        Internship
                    </option>

                </select>

            </div>


            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Skills Required
                </label>

                <input type="text"
                       name="skillRequired"
                       class="form-control"
                       placeholder="e.g. Java, SQL, HTML, CSS">

            </div>


            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Location
                </label>

                <input type="text"
                       name="location"
                       class="form-control"
                       placeholder="e.g. Kolkata / Remote">

            </div>


            <div class="mb-4">

                <label class="form-label fw-semibold">
                    Description
                </label>

                <textarea name="description"
                          class="form-control"
                          rows="6"
                          placeholder="Describe the opportunity, responsibilities and requirements..."></textarea>

            </div>


            <button type="submit"
                    class="btn btn-primary submit-btn w-100">

                <i class="bi bi-send-fill me-2"></i>
                Post Opportunity

            </button>

        </form>


        <div class="text-center mt-4">

            <a href="companyDashboard.jsp"
               class="text-decoration-none">

                <i class="bi bi-arrow-left"></i>
                Back to Dashboard

            </a>

        </div>

    </div>

</div>


</body>
</html>