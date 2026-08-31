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

.back-link {
    color: #d6ad52;
    text-decoration: none;
    font-weight: 650;
}

.page {
    padding: 65px 15px 90px;
    min-height: calc(100vh - 80px);
}

.form-card {
    max-width: 800px;
    margin: auto;
    background: #0a1a2e;
    border: 1px solid rgba(214,173,82,.20);
    border-radius: 20px;
    padding: 45px;
    box-shadow: 0 25px 70px rgba(0,0,0,.35);
}

.heading-icon {
    width: 65px;
    height: 65px;
    background: rgba(214,173,82,.10);
    border: 1px solid rgba(214,173,82,.25);
    color: #d6ad52;
    border-radius: 17px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    margin-bottom: 22px;
}

.form-card h1 {
    font-size: 36px;
    font-weight: 800;
    letter-spacing: -1px;
}

.subtitle {
    color: #7f8a98;
    line-height: 1.7;
}

.form-label {
    font-weight: 650;
}

.form-control,
.form-select {
    padding: 13px;
    background: #071426;
    border-color: rgba(255,255,255,.12);
    color: #f5f1e8;
    border-radius: 9px;
}

.form-control::placeholder {
    color: #667384;
}

.form-select option {
    background: #071426;
}

.form-control:focus,
.form-select:focus {
    background: #071426;
    color: #f5f1e8;
    border-color: #d6ad52;
    box-shadow: 0 0 0 3px rgba(214,173,82,.12);
}

textarea {
    resize: vertical;
    min-height: 160px;
}

.submit-btn {
    width: 100%;
    padding: 13px;
    border: none;
    border-radius: 9px;
    background: #d6ad52;
    color: #071426;
    font-weight: 750;
    transition: .25s;
}

.submit-btn:hover {
    background: #e3be68;
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(214,173,82,.18);
}

.tip {
    margin-top: 25px;
    padding: 15px 18px;
    background: rgba(214,173,82,.06);
    border: 1px solid rgba(214,173,82,.12);
    border-radius: 10px;
    color: #8d98a6;
    font-size: 14px;
}

.tip i {
    color: #d6ad52;
}

.alert {
    background: rgba(214,173,82,.08);
    border: 1px solid rgba(214,173,82,.20);
    color: #d6ad52;
}

</style>

</head>

<body>


<nav class="navbar-custom">

<div class="container">

<div class="d-flex justify-content-between align-items-center">

<a href="companyDashboard.jsp" class="brand">

<i class="bi bi-mortarboard-fill"></i>

CampusConnect

</a>

<a href="companyDashboard.jsp" class="back-link">

<i class="bi bi-arrow-left me-1"></i>

Dashboard

</a>

</div>

</div>

</nav>


<section class="page">

<div class="form-card">


<div class="heading-icon">

<i class="bi bi-briefcase"></i>

</div>


<h1>
Post an opportunity
</h1>

<p class="subtitle mb-4">

Share a job or internship opportunity
with students on CampusConnect.

</p>


<% if (request.getAttribute("error") != null) { %>

<div class="alert mb-4">

<i class="bi bi-exclamation-circle me-2"></i>

<%= request.getAttribute("error") %>

</div>

<% } %>


<% if (request.getAttribute("message") != null) { %>

<div class="alert mb-4">

<i class="bi bi-check-circle me-2"></i>

<%= request.getAttribute("message") %>

</div>

<% } %>


<form action="postOpportunity" method="post">


<div class="mb-4">

<label class="form-label">
Opportunity title
</label>

<input type="text"
       name="title"
       class="form-control"
       placeholder="e.g. Java Developer Intern"
       required>

</div>


<div class="mb-4">

<label class="form-label">
Opportunity type
</label>

<select name="type"
        class="form-select"
        required>

<option value="" selected disabled>
Choose an opportunity type
</option>

<option value="JOB">
Full-Time Job
</option>

<option value="INTERNSHIP">
Internship
</option>

</select>

</div>


<div class="mb-4">

<label class="form-label">
Skills required
</label>

<input type="text"
       name="skillRequired"
       class="form-control"
       placeholder="e.g. Java, SQL, HTML, CSS">

</div>


<div class="mb-4">

<label class="form-label">
Location
</label>

<input type="text"
       name="location"
       class="form-control"
       placeholder="e.g. Kolkata / Remote">

</div>


<div class="mb-4">

<label class="form-label">
Description
</label>

<textarea name="description"
          class="form-control"
          placeholder="Describe the role, responsibilities and requirements..."
          required></textarea>

</div>


<button type="submit"
        class="submit-btn">

<i class="bi bi-send me-2"></i>

Publish opportunity

</button>


</form>


<div class="tip">

<i class="bi bi-lightbulb me-2"></i>

<strong>Tip:</strong>

Add clear skills and requirements so students
can quickly understand the opportunity.

</div>


</div>

</section>


</body>

</html>