<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusconnect.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Company Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"COMPANY".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="container mt-5">
    <h2>Welcome, <%= user.getName() %>!</h2>
    <p><a href="postJob.jsp" class="btn btn-primary">Post a new Job/Internship</a></p>
</div>
</body>
</html>