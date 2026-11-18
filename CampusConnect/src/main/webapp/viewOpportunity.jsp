<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Opportunity" %>
<%@ page import="com.campusconnect.dao.OpportunityDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int oppId = 0;

    try {
        oppId = Integer.parseInt(request.getParameter("oppId"));
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
        return;
    }

    OpportunityDAO opportunityDAO = new OpportunityDAO();
    Opportunity opportunity = opportunityDAO.getOpportunityById(oppId);

    if (opportunity == null) {
        response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
        return;
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>View Opportunity | CampusConnect</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

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

        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            color: #d6ad52 !important;
            font-size: 14px;
            font-weight: 700;
            padding: 10px 14px;
            border: 1px solid rgba(214,173,82,.25);
            border-radius: 10px;
            background: transparent;
            text-decoration: none;
            transition: .3s ease;
        }

        .back-btn:hover {
            color: #071426 !important;
            background: #d6ad52;
            border-color: #d6ad52;
            transform: translateY(-2px);
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

        .brand:hover {
            color: white;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .admin-name {
            color: #b8c0cb;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .admin-icon {
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
        }

        .logout-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 10px 15px;
            color: #d6ad52;
            border: 1px solid rgba(214,173,82,.3);
            border-radius: 9px;
            background: transparent;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: .3s ease;
        }

        .logout-btn:hover {
            color: #071426;
            background: #d6ad52;
            border-color: #d6ad52;
            transform: translateY(-2px);
        }


        /* ================= HERO ================= */

        .hero {
            padding: 65px 0;
            background:
                radial-gradient(
                    circle at 85% 20%,
                    rgba(214,173,82,.12),
                    transparent 30%
                ),
                #0a1a2e;
            border-bottom: 1px solid rgba(214,173,82,.10);
        }

        .hero-label {
            color: #d6ad52;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .hero h1 {
            font-size: 45px;
            font-weight: 800;
            letter-spacing: -1.5px;
        }

        .hero p {
            color: #8d98a6;
            font-size: 16px;
            line-height: 1.7;
        }


        /* ================= MAIN CONTENT ================= */

        .dashboard {
            padding: 60px 0 90px;
        }

        .section-title {
            font-size: 27px;
            font-weight: 750;
            margin-bottom: 25px;
        }

        .data-card {
            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border: 1px solid rgba(255,255,255,.09);
            border-radius: 18px;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .data-header {
            padding: 24px 28px;
            border-bottom: 1px solid rgba(255,255,255,.08);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
        }

        .data-header h3 {
            margin: 0;
            font-size: 21px;
            font-weight: 700;
        }

        .data-header h3 i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .count-badge {
            background: rgba(214,173,82,.12);
            color: #d6ad52;
            border: 1px solid rgba(214,173,82,.25);
            padding: 6px 11px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
        }


        /* ================= DETAILS ================= */

        .details-content {
            padding: 28px;
        }

        .detail-box {
            height: 100%;
            padding: 19px;
            border-radius: 12px;
            background: rgba(255,255,255,.025);
            border: 1px solid rgba(255,255,255,.07);
            transition: .3s ease;
        }

        .detail-box:hover {
            border-color: rgba(214,173,82,.35);
            background: rgba(214,173,82,.035);
            transform: translateY(-2px);
        }

        .detail-label {
            color: #8d98a6;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .7px;
            margin-bottom: 9px;
        }

        .detail-value {
            color: #f5f1e8;
            font-size: 15px;
            font-weight: 600;
            overflow-wrap: anywhere;
            line-height: 1.6;
        }

        .type-badge {
            display: inline-block;
            padding: 7px 13px;
            border-radius: 7px;
            background: rgba(214,173,82,.10);
            color: #d6ad52;
            border: 1px solid rgba(214,173,82,.25);
            font-size: 12px;
            font-weight: 700;
        }

        .description-box {
            background: rgba(255,255,255,.025);
            border: 1px solid rgba(255,255,255,.07);
            border-radius: 12px;
            padding: 22px;
            color: #c5ccd5;
            font-size: 14px;
            line-height: 1.8;
            white-space: pre-wrap;
            overflow-wrap: anywhere;
        }


        /* ================= BUTTONS ================= */

        .action-buttons {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .edit-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 10px 17px;
            color: #c5ccd5;
            border: 1px solid rgba(255,255,255,.15);
            border-radius: 8px;
            background: transparent;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: .3s ease;
        }

        .edit-btn:hover {
            color: #071426;
            background: #f5f1e8;
            border-color: #f5f1e8;
            transform: translateY(-1px);
        }


        /* ================= FOOTER ================= */

        footer {
            background: #050f1c;
            border-top: 1px solid rgba(255,255,255,.06);
            padding: 28px 0;
            color: #707b89;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 768px) {

            .navbar-container {
                padding: 0 15px;
            }

            .navbar-left {
                gap: 10px;
            }

            .brand {
                font-size: 20px;
            }

            .navbar-right {
                gap: 8px;
            }

            .admin-name {
                font-size: 13px;
            }

            .logout-btn {
                padding: 8px 10px;
            }

            .hero {
                padding: 50px 20px;
            }

            .hero h1 {
                font-size: 36px;
            }

            .dashboard {
                padding: 45px 15px 65px;
            }

            .details-content {
                padding: 20px;
            }
        }

        @media (max-width: 480px) {

            .navbar-container {
                flex-wrap: wrap;
                gap: 15px;
            }

            .brand {
                font-size: 18px;
            }

            .admin-icon {
                width: 32px;
                height: 32px;
            }

            .hero h1 {
                font-size: 31px;
            }

            .data-header {
                padding: 19px;
            }

            .details-content {
                padding: 15px;
            }
        }

    </style>

</head>

<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar-custom">

    <div class="navbar-container">

        <div class="navbar-left">

            <a href="<%= request.getContextPath() %>/adminDashboard.jsp"
               class="back-btn">

                <i class="bi bi-arrow-left"></i>
                Back

            </a>

            <a href="<%= request.getContextPath() %>/adminDashboard.jsp"
               class="brand">

                <i class="bi bi-mortarboard-fill"></i>
                <span>CampusConnect</span>

            </a>

        </div>


        <div class="navbar-right">

            <div class="admin-name">

                <span class="admin-icon">
                    <i class="bi bi-shield-check"></i>
                </span>

                <span><%= user.getName() %></span>

            </div>

            <a href="<%= request.getContextPath() %>/logout"
               class="logout-btn">

                <i class="bi bi-box-arrow-right"></i>
                Logout

            </a>

        </div>

    </div>

</nav>


<!-- ================= HERO ================= -->

<section class="hero">

    <div class="container">

        <div class="hero-label">
            Administration / Opportunities
        </div>

        <h1 class="mt-3">
            Opportunity <span style="color:#d6ad52;">Details.</span>
        </h1>

        <p class="mt-3 mb-0">
            Review the complete information of this opportunity posted on CampusConnect.
        </p>

    </div>

</section>


<!-- ================= CONTENT ================= -->

<section class="dashboard">

    <div class="container">

        <div class="data-card">

            <div class="data-header">

                <h3>
                    <i class="bi bi-briefcase-fill"></i>
                    <%= opportunity.getTitle() %>
                </h3>

                <span class="count-badge">
                    ID: #<%= opportunity.getOppId() %>
                </span>

            </div>


            <div class="details-content">

                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">

                    <div>
                        <div class="detail-label">Posted By</div>

                        <div class="detail-value">
                            <i class="bi bi-building" style="color:#d6ad52;"></i>
                            <%= opportunity.getCompanyName() %>
                        </div>
                    </div>

                    <span class="type-badge">
                        <%= opportunity.getType() %>
                    </span>

                </div>


                <h5 class="section-title">Opportunity Information</h5>

                <div class="row g-3">

                    <div class="col-md-6 col-lg-4">
                        <div class="detail-box">
                            <div class="detail-label">Location</div>
                            <div class="detail-value">
                                <i class="bi bi-geo-alt" style="color:#d6ad52;"></i>
                                <%= opportunity.getLocation() == null ? "Not specified" : opportunity.getLocation() %>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4">
                        <div class="detail-box">
                            <div class="detail-label">Required Skills</div>
                            <div class="detail-value">
                                <%= opportunity.getSkillRequired() == null ? "Not specified" : opportunity.getSkillRequired() %>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4">
                        <div class="detail-box">
                            <div class="detail-label">Minimum CGPA</div>
                            <div class="detail-value">
                                <%= opportunity.getMinCgpa() %>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4">
                        <div class="detail-box">
                            <div class="detail-label">Eligible Departments</div>
                            <div class="detail-value">
                                <%= opportunity.getEligibleDepartments() == null ? "Not specified" : opportunity.getEligibleDepartments() %>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4">
                        <div class="detail-box">
                            <div class="detail-label">Graduation Year</div>
                            <div class="detail-value">
                                <%= opportunity.getGraduationYear() == null ? "Not specified" : opportunity.getGraduationYear() %>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4">
                        <div class="detail-box">
                            <div class="detail-label">Posted Date</div>
                            <div class="detail-value">
                                <%= opportunity.getPostedDate() == null ? "Not available" : dateFormat.format(opportunity.getPostedDate()) %>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4">
                        <div class="detail-box">
                            <div class="detail-label">Application Deadline</div>
                            <div class="detail-value">
                                <%= opportunity.getApplicationDeadline() == null ? "Not specified" : dateFormat.format(opportunity.getApplicationDeadline()) %>
                            </div>
                        </div>
                    </div>

                </div>


                <h5 class="section-title mt-5">Opportunity Description</h5>

                <div class="description-box">
                    <%= opportunity.getDescription() == null ? "No description available." : opportunity.getDescription() %>
                </div>


                <div class="action-buttons">

                    <a href="<%= request.getContextPath() %>/editOpportunity.jsp?oppId=<%= opportunity.getOppId() %>"
                       class="edit-btn">

                        <i class="bi bi-pencil-square"></i>
                        Edit Opportunity

                    </a>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <div class="container text-center">

        <small>
            © 2026 CampusConnect · Administration
        </small>

    </div>

</footer>


</body>
</html>