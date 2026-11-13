<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.StudentProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="com.campusconnect.model.StudentProject" %>

<%

    // =========================================================
    // GET LOGGED-IN USER
    // =========================================================

    User user = (User) session.getAttribute("user");

    if (user == null || !"STUDENT".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }


    // =========================================================
    // GET STUDENT PROFILE
    // =========================================================

    StudentProfile profile =
            (StudentProfile) request.getAttribute("profile");


    // =========================================================
    // DEFAULT VALUES
    // =========================================================

    String phone = "";
    String location = "";
    String bio = "";
    String education = "";
    String skills = "";
    String githubLink = "";
    String linkedinLink = "";
    String resumePath = "";
    String department = "";
    String cgpa = "";
    String graduationYear = "";
    String achievements = "";


    // =========================================================
    // LOAD PROFILE DATA
    // =========================================================

    if (profile != null) {

        if (profile.getDepartment() != null) {
            department = profile.getDepartment();
        }

        if (profile.getCgpa() != null) {
            cgpa = profile.getCgpa().toPlainString();
        }

        if (profile.getGraduationYear() != null) {
            graduationYear =
                    String.valueOf(profile.getGraduationYear());
        }

        if (profile.getAchievements() != null) {
            achievements = profile.getAchievements();
        }

        if (profile.getPhone() != null) {
            phone = profile.getPhone();
        }

        if (profile.getLocation() != null) {
            location = profile.getLocation();
        }

        if (profile.getBio() != null) {
            bio = profile.getBio();
        }

        if (profile.getEducation() != null) {
            education = profile.getEducation();
        }

        if (profile.getSkills() != null) {
            skills = profile.getSkills();
        }

        if (profile.getGithubLink() != null) {
            githubLink = profile.getGithubLink();
        }

        if (profile.getLinkedinLink() != null) {
            linkedinLink = profile.getLinkedinLink();
        }

        if (profile.getResumePath() != null) {
            resumePath = profile.getResumePath();
        }
    }


    // =========================================================
    // LOAD STUDENT PROJECTS
    // =========================================================

    List<StudentProject> projects =
            (List<StudentProject>) request.getAttribute("projects");

    if (projects == null) {
        projects = new java.util.ArrayList<>();
    }

%>


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Profile | CampusConnect</title>


    <!-- =====================================================
         BOOTSTRAP
    ====================================================== -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- =====================================================
         BOOTSTRAP ICONS
    ====================================================== -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">


    <style>
    /* ================= BACK BUTTON ================= */

.back-btn {


display: inline-flex;
align-items: center;
gap: 5px;

color: #d6ad52 !important;

font-size: 14px;
font-weight: 700;

margin-left: 0;

padding: 10px 14px !important;

border: 1px solid rgba(214,173,82,.25);

border-radius: 10px;

background: transparent;

cursor: pointer;

transition: .3s ease;


}

.back-btn i {
margin-right: 5px;
}

.back-btn:hover {


color: #071426 !important;

background: #d6ad52 !important;

border-color: #d6ad52;

box-shadow:
    0 0 10px rgba(214,173,82,.35),
    0 0 25px rgba(214,173,82,.15);

transform: translateY(-2px);


}

.back-btn:hover i {


color: #071426;

text-shadow: none;


}
.apply-message {
    max-width: 800px;
    margin: 20px auto;
    padding: 15px 20px;
    border-radius: 10px;
    background: #fff3cd;
    color: #856404;
    border: 1px solid #ffe69c;
    font-weight: 600;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}
/* =========================================================
   GLOBAL
========================================================= */

* {
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    margin: 0;
    background:
        radial-gradient(circle at 15% 15%, rgba(214,173,82,0.07), transparent 28%),
        radial-gradient(circle at 85% 30%, rgba(214,173,82,0.05), transparent 30%),
        #071426;
    color: #f5f1e8;
    font-family: "Segoe UI", Arial, sans-serif;
    min-height: 100vh;
}


/* =========================================================
   NAVBAR
========================================================= */

.navbar-custom {
    background: rgba(7,20,38,0.92) !important;
    backdrop-filter: blur(12px);
    border-bottom: 1px solid rgba(214,173,82,0.12);
    padding: 17px 0;
}

.brand {
    color: #f5f1e8 !important;
    text-decoration: none;
    font-size: 23px;
    font-weight: 800;
    letter-spacing: -0.5px;
}

.brand i {
    color: #d6ad52;
    margin-right: 8px;
    filter: drop-shadow(0 0 6px rgba(214,173,82,0.55));
}


/* NAV LINKS */

.custom-link {
    position: relative;
    color: #aeb9c8 !important;
    font-size: 14px;
    font-weight: 600;
    margin-left: 10px;
    padding: 10px 9px !important;
    background: transparent !important;
    border: none !important;
    transition: 0.3s ease;
}

.custom-link i {
    color: #d6ad52;
    margin-right: 5px;
}

.custom-link:hover,
.custom-link.active {
    color: #f5f1e8 !important;
}

.custom-link::after {
    content: "";
    position: absolute;
    left: 50%;
    bottom: 3px;
    width: 0;
    height: 2px;
    transform: translateX(-50%);
    background: #d6ad52;
    box-shadow: 0 0 10px rgba(214,173,82,0.8);
    transition: width 0.3s ease;
}

.custom-link:hover::after,
.custom-link.active::after {
    width: 55%;
}


/* LOGOUT */

.logout-link {
    color: #d6ad52 !important;
    font-size: 14px;
    font-weight: 700;
    margin-left: 14px;
    padding: 9px 14px !important;
    border: 1px solid rgba(214,173,82,0.25) !important;
    border-radius: 9px !important;
    transition: 0.3s ease;
}

.logout-link:hover {
    color: #071426 !important;
    background: #d6ad52 !important;
    box-shadow: 0 0 20px rgba(214,173,82,0.35);
    transform: translateY(-2px);
}


/* =========================================================
   MAIN SECTION
========================================================= */

.profile-section {
    padding: 65px 5% 80px;
    min-height: calc(100vh - 80px);
}


/* =========================================================
   HEADING
========================================================= */

.profile-heading {
    text-align: center;
    margin-bottom: 42px;
}

.profile-heading h1 {
    margin: 0 0 10px;
    color: #d6ad52;
    font-size: 2.4rem;
    font-weight: 800;
    letter-spacing: -1px;
    text-shadow: 0 0 22px rgba(214,173,82,0.18);
}

.profile-heading h1 i {
    margin-right: 7px;
}

.profile-heading p {
    margin: 0;
    color: #8291a5;
    font-size: 0.9rem;
}


/* =========================================================
   MAIN PROFILE CARD
========================================================= */

.profile-card {
    max-width: 1000px;
    margin: auto;

    background:
        linear-gradient(
            145deg,
            rgba(14,35,59,0.94),
            rgba(7,20,38,0.94)
        );

    border: 1px solid rgba(214,173,82,0.18);

    border-radius: 22px;

    padding: 42px;

    box-shadow:
        0 20px 60px rgba(0,0,0,0.35),
        0 0 40px rgba(214,173,82,0.035);

    position: relative;
    overflow: hidden;
}


/* subtle glow */

.profile-card::before {
    content: "";
    position: absolute;

    width: 300px;
    height: 300px;

    top: -180px;
    right: -120px;

    background: rgba(214,173,82,0.07);

    border-radius: 50%;

    filter: blur(50px);

    pointer-events: none;
}


/* =========================================================
   PROFILE HEADER
========================================================= */

.profile-header {
    text-align: center;
    padding-bottom: 30px;
    border-bottom: 1px solid rgba(214,173,82,0.10);
    position: relative;
    z-index: 1;
}

.profile-icon {
    width: 92px;
    height: 92px;

    margin: 0 auto 18px;

    border-radius: 50%;

    display: flex;
    align-items: center;
    justify-content: center;

    color: #d6ad52;

    background:
        radial-gradient(
            circle,
            rgba(214,173,82,0.15),
            rgba(214,173,82,0.03)
        );

    border: 1px solid rgba(214,173,82,0.38);

    font-size: 41px;

    box-shadow:
        0 0 25px rgba(214,173,82,0.10),
        inset 0 0 20px rgba(214,173,82,0.04);
}

.student-name {
    color: #f5f1e8;
    font-size: 1.8rem;
    font-weight: 750;
    margin-bottom: 7px;
}

.student-email {
    color: #8795a8;
    font-size: 0.88rem;
    margin-bottom: 14px;
}

.student-email i {
    color: #d6ad52;
    margin-right: 5px;
}

.student-role {
    display: inline-flex;
    align-items: center;
    gap: 6px;

    padding: 6px 14px;

    border-radius: 20px;

    color: #d6ad52;

    background: rgba(214,173,82,0.07);

    border: 1px solid rgba(214,173,82,0.22);

    font-size: 0.72rem;
    font-weight: 700;

    letter-spacing: 0.5px;

    box-shadow: 0 0 15px rgba(214,173,82,0.05);
}


/* =========================================================
   DETAILS GRID
========================================================= */

.details-grid {
    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 17px;

    margin-top: 28px;
}


/* =========================================================
   INFO BOX
========================================================= */

.info-box {
    position: relative;

    background:
        rgba(5,15,29,0.58);

    border: 1px solid rgba(214,173,82,0.11);

    border-radius: 15px;

    padding: 20px 21px;

    min-height: 0;

    transition:
        transform 0.25s ease,
        border-color 0.25s ease,
        box-shadow 0.25s ease;

    overflow: hidden;
}

.info-box::before {
    content: "";

    position: absolute;

    top: 0;
    left: 0;

    width: 100%;
    height: 1px;

    background:
        linear-gradient(
            90deg,
            transparent,
            rgba(214,173,82,0.45),
            transparent
        );

    opacity: 0;

    transition: 0.3s ease;
}

.info-box:hover {
    transform: translateY(-3px);

    border-color:
        rgba(214,173,82,0.30);

    box-shadow:
        0 10px 28px rgba(0,0,0,0.25),
        0 0 18px rgba(214,173,82,0.04);
}

.info-box:hover::before {
    opacity: 1;
}


/* =========================================================
   LABEL
========================================================= */

.info-label {
    display: flex;
    align-items: center;

    color: #d6ad52;

    font-size: 0.83rem;

    font-weight: 700;

    margin-bottom: 11px;

    letter-spacing: 0.2px;
}

.info-label i {
    margin-right: 8px;

    font-size: 0.95rem;

    filter:
        drop-shadow(
            0 0 5px rgba(214,173,82,0.3)
        );
}


/* =========================================================
   VALUE
========================================================= */

.info-value {
    color: #dfe2e7;

    font-size: 0.87rem;

    line-height: 1.65;

    white-space: pre-wrap;

    word-break: break-word;
}

.empty-value {
    color: #617086;

    font-size: 0.80rem;

    font-style: italic;
}


/* =========================================================
   BIO
========================================================= */

.info-box:has(.bi-person-lines-fill) {
    min-height: 145px;
}


/* =========================================================
   SKILLS
========================================================= */

.skills-container {
    display: flex;

    flex-wrap: wrap;

    gap: 7px;
}

.skill-tag {
    display: inline-flex;

    align-items: center;

    padding: 5px 11px;

    border-radius: 20px;

    background:
        rgba(214,173,82,0.07);

    border:
        1px solid rgba(214,173,82,0.22);

    color: #e2c56d;

    font-size: 0.74rem;

    font-weight: 600;

    transition: 0.25s ease;
}

.skill-tag:hover {
    background:
        rgba(214,173,82,0.14);

    border-color:
        rgba(214,173,82,0.40);

    box-shadow:
        0 0 12px rgba(214,173,82,0.12);

    transform: translateY(-1px);
}


/* =========================================================
   SOCIAL BUTTONS
========================================================= */

.social-btn {
    display: inline-flex;

    align-items: center;

    gap: 7px;

    text-decoration: none;

    color: #d6ad52;

    background:
        rgba(214,173,82,0.06);

    border:
        1px solid rgba(214,173,82,0.20);

    padding: 8px 13px;

    border-radius: 8px;

    font-size: 0.76rem;

    font-weight: 650;

    transition: 0.25s ease;
}

.social-btn:hover {
    color: #071426;

    background: #d6ad52;

    border-color: #d6ad52;

    box-shadow:
        0 0 18px rgba(214,173,82,0.25);

    transform: translateY(-2px);
}


/* =========================================================
   RESUME
========================================================= */

.resume-box {
    grid-column: 1 / -1;
}

.resume-content {
    display: flex;

    align-items: center;

    gap: 16px;
}

.resume-icon {
    flex-shrink: 0;

    width: 48px;
    height: 48px;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 11px;

    color: #d6ad52;

    background:
        rgba(214,173,82,0.08);

    border:
        1px solid rgba(214,173,82,0.20);

    font-size: 25px;

    box-shadow:
        0 0 15px rgba(214,173,82,0.05);
}

.resume-info {
    flex: 1;
}

.resume-info strong {
    color: #f5f1e8;

    font-size: 0.87rem;

    font-weight: 650;
}

.resume-info p {
    color: #69788b;

    font-size: 0.73rem;

    margin: 3px 0 0;
}

.profile-btn {
    display: inline-flex;

    align-items: center;

    justify-content: center;

    gap: 7px;

    text-decoration: none;

    color: #071426;

    background:
        linear-gradient(
            135deg,
            #e2bf69,
            #cfa449
        );

    border: none;

    padding: 9px 15px;

    border-radius: 8px;

    font-size: 0.76rem;

    font-weight: 700;

    white-space: nowrap;

    transition: 0.25s ease;

    box-shadow:
        0 3px 10px rgba(214,173,82,0.10);
}

.profile-btn:hover {
    color: #071426;

    transform: translateY(-2px);

    box-shadow:
        0 0 20px rgba(214,173,82,0.30);
}


/* =========================================================
   PROFILE ACTION
========================================================= */

.profile-actions {
    text-align: right;

    margin-top: 23px;
}


/* =========================================================
   NO PROFILE
========================================================= */

.no-profile {
    text-align: center;

    padding: 50px 20px 35px;
}

.empty-icon {
    width: 72px;
    height: 72px;

    margin: 0 auto 18px;

    border-radius: 50%;

    display: flex;

    align-items: center;
    justify-content: center;

    color: #d6ad52;

    background:
        rgba(214,173,82,0.07);

    border:
        1px solid rgba(214,173,82,0.25);

    font-size: 29px;

    box-shadow:
        0 0 25px rgba(214,173,82,0.07);
}

.no-profile h4 {
    color: #f5f1e8;

    font-size: 1.05rem;

    font-weight: 700;

    margin-bottom: 8px;
}

.no-profile p {
    color: #718095;

    font-size: 0.83rem;

    max-width: 450px;

    margin: 0 auto 23px;
}


/* =========================================================
   FOOTER
========================================================= */

footer {
    background: #050f1c;

    border-top:
        1px solid rgba(214,173,82,0.10);

    text-align: center;

    padding: 20px;

    color: #667589;

    font-size: 0.75rem;
}

footer i {
    color: #d6ad52;

    margin-right: 5px;
}


/* =========================================================
   TABLET
========================================================= */

@media (max-width: 991px) {

    .navbar-collapse {
        margin-top: 15px;
    }

    .navbar-nav {
        align-items: flex-start !important;
    }

    .custom-link {
        margin-left: 0;

        padding-left: 0 !important;
    }

    .logout-link {
        display: inline-block;

        margin-left: 0;

        margin-top: 8px;
    }

    .profile-section {
        padding: 50px 5% 70px;
    }
}


/* =========================================================
   MOBILE
========================================================= */

@media (max-width: 768px) {

    .profile-heading h1 {
        font-size: 2rem;
    }

    .profile-card {
        padding: 28px 20px;
    }

    .details-grid {
        grid-template-columns: 1fr;
    }

    .resume-box {
        grid-column: auto;
    }

    .resume-content {
        flex-wrap: wrap;
    }

    .resume-btn {
        width: 100%;
    }

    .profile-actions {
        text-align: center;
    }
}


/* =========================================================
   SMALL MOBILE
========================================================= */

@media (max-width: 480px) {

    .profile-section {
        padding: 40px 4% 60px;
    }

    .profile-heading h1 {
        font-size: 1.7rem;
    }

    .profile-card {
        padding: 23px 15px;
        border-radius: 17px;
    }

    .profile-icon {
        width: 76px;
        height: 76px;
        font-size: 33px;
    }

    .student-name {
        font-size: 1.4rem;
    }

    .info-box {
        padding: 17px;
    }
} 
/* =========================================================
   PROJECT PORTFOLIO
========================================================= */

.projects-section {
    margin-top: 40px;
    padding-top: 30px;
    border-top: 1px solid rgba(214,173,82,0.15);
}

.projects-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    margin-bottom: 22px;
}

.projects-heading h3 {
    color: #d6ad52;
    font-size: 1.35rem;
    font-weight: 750;
    margin: 0;
}

.projects-heading p {
    color: #8291a5;
    font-size: 0.82rem;
    margin: 6px 0 0;
}

.project-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 18px;
}

.project-card {
    background: rgba(5,15,29,0.65);
    border: 1px solid rgba(214,173,82,0.16);
    border-radius: 15px;
    padding: 22px;
    transition: 0.25s ease;
    min-width: 0;
}

.project-card:hover {
    transform: translateY(-3px);
    border-color: rgba(214,173,82,0.4);
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

.project-card h5 {
    color: #f5f1e8;
    font-size: 1.05rem;
    font-weight: 700;
    margin-bottom: 12px;
    overflow-wrap: anywhere;
}

.project-description {
    color: #aeb9c8;
    font-size: 0.84rem;
    line-height: 1.7;
    white-space: pre-wrap;
    overflow-wrap: anywhere;
}

.project-technologies {
    display: flex;
    flex-wrap: wrap;
    gap: 7px;
    margin: 15px 0;
}

.project-tech {
    background: rgba(214,173,82,0.08);
    border: 1px solid rgba(214,173,82,0.2);
    color: #e2c56d;
    border-radius: 20px;
    padding: 5px 10px;
    font-size: 0.72rem;
}

.project-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 9px;
    margin-top: 18px;
}

.project-action-btn {
    border: 1px solid rgba(214,173,82,0.25);
    background: rgba(214,173,82,0.07);
    color: #d6ad52;
    border-radius: 7px;
    padding: 7px 12px;
    font-size: 0.76rem;
    font-weight: 650;
    text-decoration: none;
    cursor: pointer;
}

.project-action-btn:hover {
    background: #d6ad52;
    color: #071426;
}

.project-empty {
    text-align: center;
    padding: 35px 15px;
    border: 1px dashed rgba(214,173,82,0.25);
    border-radius: 15px;
    color: #8291a5;
}

.project-empty i {
    display: block;
    font-size: 35px;
    color: #d6ad52;
    margin-bottom: 12px;
}

.project-modal .modal-content {
    background: #0e233b;
    color: #f5f1e8;
    border: 1px solid rgba(214,173,82,0.3);
    border-radius: 15px;
}

.project-modal .modal-header {
    border-bottom: 1px solid rgba(214,173,82,0.15);
}

.project-modal .modal-footer {
    border-top: 1px solid rgba(214,173,82,0.15);
}

.project-modal .form-label {
    color: #d6ad52;
    font-size: 0.85rem;
    font-weight: 650;
}

.project-modal .form-control {
    background: #071426;
    color: #f5f1e8;
    border: 1px solid rgba(214,173,82,0.2);
}

.project-modal .form-control:focus {
    border-color: #d6ad52;
    box-shadow: 0 0 0 0.2rem rgba(214,173,82,0.12);
}

.project-modal .btn-close {
    filter: invert(1);
}

@media (max-width: 768px) {
    .project-grid {
        grid-template-columns: 1fr;
    }

    .projects-heading {
        align-items: flex-start;
        flex-direction: column;
    }
}

</style>

</head>


<body>

<%
    String applyMessage = (String) session.getAttribute("applyMessage");

    if (applyMessage != null) {
%>

<div class="apply-message">
    ⚠️ <%= applyMessage %>
</div>

<%
        session.removeAttribute("applyMessage");
    }
%>

<!-- =========================================================
     NAVBAR
========================================================== -->

<nav class="navbar navbar-expand-lg navbar-custom">

<div class="container">

    <!-- LEFT SIDE: BACK + BRAND -->
    <div class="d-flex align-items-center gap-3">

        <button type="button"
                class="back-btn"
                onclick="history.back()">

            <i class="bi bi-arrow-left"></i>
            Back

        </button>

        <a class="brand"
           href="<%= request.getContextPath() %>/studentDashboard.jsp">

            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect

        </a>

    </div>


    <!-- MOBILE BUTTON -->
    <button class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#studentNavbar"
            aria-controls="studentNavbar"
            aria-expanded="false"
            aria-label="Toggle navigation">

        <i class="bi bi-list"></i>

    </button>


    <!-- NAVIGATION -->
    <div class="collapse navbar-collapse"
         id="studentNavbar">

        <ul class="navbar-nav ms-auto align-items-lg-center">

            <li class="nav-item">

                <a class="nav-link custom-link"
                   href="<%= request.getContextPath() %>/studentDashboard.jsp">

                    <i class="bi bi-house"></i>
                    Dashboard

                </a>

            </li>


            <li class="nav-item">

                <a class="nav-link custom-link"
                   href="<%= request.getContextPath() %>/studentDashboard.jsp#opportunities">

                    <i class="bi bi-briefcase"></i>
                    Opportunities

                </a>

            </li>


            <li class="nav-item">

                <a class="nav-link custom-link"
                   href="<%= request.getContextPath() %>/studentDashboard.jsp#applications">

                    <i class="bi bi-file-earmark-text"></i>
                    My Applications

                </a>

            </li>


            <li class="nav-item">

                <a class="nav-link custom-link active"
                   href="<%= request.getContextPath() %>/studentProfile">

                    <i class="bi bi-person-circle"></i>
                    Profile

                </a>

            </li>


            <li class="nav-item">

                <a class="nav-link logout-link"
                   href="<%= request.getContextPath() %>/logout">

                    <i class="bi bi-box-arrow-right"></i>
                    Logout

                </a>

            </li>

        </ul>

    </div>

</div>

</nav>




<!-- =========================================================
     PROFILE SECTION
========================================================== -->

<section class="profile-section">


    <!-- HEADING -->

    <div class="profile-heading">

        <h1>
            <i class="bi bi-person-badge"></i>
            My Profile
        </h1>

        <p>
            Manage your personal and professional information
        </p>

    </div>



    <!-- PROFILE CARD -->

    <div class="profile-card">


        <!-- =================================================
             PROFILE EXISTS
        ================================================== -->

        <% if (profile != null) { %>


            <!-- PROFILE HEADER -->

            <div class="profile-header">

                <div class="profile-icon">

                    <i class="bi bi-person-fill"></i>

                </div>


                <div class="student-name">

                    <%= user.getName() %>

                </div>


                <div class="student-email">

                    <i class="bi bi-envelope"></i>

                    <%= user.getEmail() %>

                </div>


                <div class="student-role">

                    <i class="bi bi-mortarboard"></i>

                    STUDENT

                </div>

            </div>


            <%
    int completedFields = 0;

    int totalFields = 12;

    if (!phone.isEmpty()) completedFields++;
    if (!location.isEmpty()) completedFields++;
    if (!bio.isEmpty()) completedFields++;
    if (!education.isEmpty()) completedFields++;

    if (!department.isEmpty()) completedFields++;
    if (!cgpa.isEmpty()) completedFields++;
    if (!graduationYear.isEmpty()) completedFields++;

    if (!skills.isEmpty()) completedFields++;
    if (!achievements.isEmpty()) completedFields++;

    if (!githubLink.isEmpty()) completedFields++;
    if (!linkedinLink.isEmpty()) completedFields++;
    if (!resumePath.isEmpty()) completedFields++;

    int completionPercent =
        (completedFields * 100) / totalFields;
%>

<div class="mb-4 p-3"
     style="border-radius:14px;background:#f8f5ed;">

    <div class="d-flex justify-content-between mb-2">

        <strong>Profile Completion</strong>

        <strong><%= completionPercent %>%</strong>

    </div>

    <div class="progress" style="height:9px;">

        <div class="progress-bar"
             role="progressbar"
             style="width:<%= completionPercent %>%"
             aria-valuenow="<%= completionPercent %>"
             aria-valuemin="0"
             aria-valuemax="100">

        </div>

    </div>

    <small class="text-muted">
        Complete your profile to help recruiters understand your background.
    </small>

</div>
            <!-- =================================================
                 DETAILS
            ================================================== -->

            <div class="details-grid">


                <!-- PHONE -->

                <div class="info-box">

                    <div class="info-label">

                        <i class="bi bi-telephone"></i>

                        Phone

                    </div>


                    <div class="info-value">

                        <% if (!phone.isEmpty()) { %>

                            <%= phone %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>



                <!-- LOCATION -->

                <div class="info-box">

                    <div class="info-label">

                        <i class="bi bi-geo-alt"></i>

                        Location

                    </div>


                    <div class="info-value">

                        <% if (!location.isEmpty()) { %>

                            <%= location %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>



                <!-- EDUCATION -->

                <div class="info-box">

                    <div class="info-label">

                        <i class="bi bi-mortarboard"></i>

                        Education

                    </div>


                    <div class="info-value">

                        <% if (!education.isEmpty()) { %>

                            <%= education %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>
                <!-- DEPARTMENT -->

<div class="info-box">

    <div class="info-label">
        Department
    </div>

    <div class="info-value">
        <%= department.isEmpty()
            ? "Not provided" : department %>
    </div>

</div>


<!-- CGPA -->

<div class="info-box">

    <div class="info-label">
        CGPA
    </div>

    <div class="info-value">
        <%= cgpa.isEmpty()
            ? "Not provided" : cgpa + " / 10" %>
    </div>

</div>


<!-- GRADUATION YEAR -->

<div class="info-box">

    <div class="info-label">
        Graduation Year
    </div>

    <div class="info-value">
        <%= graduationYear.isEmpty()
            ? "Not provided" : graduationYear %>
    </div>

</div>


<!-- ACHIEVEMENTS -->

<div class="info-box">

    <div class="info-label">
        Achievements
    </div>

    <div class="info-value">
        <%= achievements.isEmpty()
            ? "Not provided" : achievements %>
    </div>

</div>


                <!-- ABOUT ME -->

                <div class="info-box">

                    <div class="info-label">

                        <i class="bi bi-person-lines-fill"></i>

                        About Me

                    </div>


                    <div class="info-value">

                        <% if (!bio.isEmpty()) { %>

                            <%= bio %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>



                <!-- =================================================
                     SKILLS
                ================================================== -->

                <div class="info-box">

                    <div class="info-label">

                        <i class="bi bi-tools"></i>

                        Skills

                    </div>


                    <div class="skills-container">


                        <% if (!skills.isEmpty()) {

                            String[] skillList =
                                    skills.split(",");

                            for (String skill : skillList) {

                                skill = skill.trim();

                                if (!skill.isEmpty()) {
                        %>

                                    <span class="skill-tag">

                                        <%= skill %>

                                    </span>

                        <%
                                }
                            }

                        } else {
                        %>

                            <span class="empty-value">
                                No skills added
                            </span>

                        <% } %>

                    </div>

                </div>



                <!-- =================================================
                     GITHUB
                ================================================== -->

                <div class="info-box">

                    <div class="info-label">

                        <i class="bi bi-github"></i>

                        GitHub

                    </div>


                    <div class="info-value">

                        <% if (!githubLink.isEmpty()) { %>

                            <a href="<%= githubLink %>"
                               target="_blank"
                               class="social-btn">

                                <i class="bi bi-box-arrow-up-right"></i>

                                View GitHub

                            </a>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>



                <!-- =================================================
                     LINKEDIN
                ================================================== -->

                <div class="info-box">

                    <div class="info-label">

                        <i class="bi bi-linkedin"></i>

                        LinkedIn

                    </div>


                    <div class="info-value">

                        <% if (!linkedinLink.isEmpty()) { %>

                            <a href="<%= linkedinLink %>"
                               target="_blank"
                               class="social-btn">

                                <i class="bi bi-box-arrow-up-right"></i>

                                View LinkedIn

                            </a>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>



                <!-- =================================================
                     RESUME
                ================================================== -->

                <div class="info-box resume-box">

                    <div class="info-label">

                        <i class="bi bi-file-earmark-pdf"></i>

                        Resume

                    </div>


                    <div class="resume-content">


                        <i class="bi bi-file-earmark-pdf resume-icon"></i>


                        <div class="resume-info">


                            <% if (!resumePath.isEmpty()) { %>

                                <strong>
                                    Resume.pdf
                                </strong>

                                <p>
                                    Your uploaded resume
                                </p>

                            <% } else { %>

                                <strong>
                                    No resume uploaded
                                </strong>

                                <p>
                                    Upload your resume from Edit Profile
                                </p>

                            <% } %>


                        </div>



                        <% if (!resumePath.isEmpty()) { %>

                            <a href="<%= request.getContextPath() + "/" + resumePath %>"
                               target="_blank"
                               class="profile-btn">

                                <i class="bi bi-eye"></i>

                                View Resume

                            </a>

                        <% } %>


                    </div>

                </div>


            </div>


                        <!-- =================================================
                 STUDENT PROJECT PORTFOLIO
            ================================================== -->

            <div class="projects-section">

                <div class="projects-heading">

                    <div>
                        <h3>
                            <i class="bi bi-code-square me-2"></i>
                            My Projects
                        </h3>

                        <p>
                            Showcase your technical work and achievements.
                        </p>
                    </div>

                    <button type="button"
                            class="profile-btn"
                            data-bs-toggle="modal"
                            data-bs-target="#addProjectModal">

                        <i class="bi bi-plus-circle"></i>
                        Add Project

                    </button>

                </div>


                <% if (projects.isEmpty()) { %>

                    <div class="project-empty">

                        <i class="bi bi-folder2-open"></i>

                        <h5>No projects added yet</h5>

                        <p>
                            Add your first project to showcase your skills
                            to recruiters.
                        </p>

                    </div>

                <% } else { %>

                    <div class="project-grid">

                        <% for (StudentProject project : projects) { %>

                            <div class="project-card">

                                <h5>
                                    <i class="bi bi-terminal me-2"
                                       style="color:#d6ad52;"></i>

                                    <%= project.getProjectTitle() %>
                                </h5>


                                <div class="project-description">

                                    <%= project.getDescription() == null
                                        || project.getDescription().trim().isEmpty()
                                        ? "No description provided."
                                        : project.getDescription() %>

                                </div>


                                <% if (project.getTechnologies() != null
                                      && !project.getTechnologies().trim().isEmpty()) { %>

                                    <div class="project-technologies">

                                        <% for (String tech :
                                                project.getTechnologies().split(",")) {

                                            tech = tech.trim();

                                            if (!tech.isEmpty()) {
                                        %>

                                            <span class="project-tech">
                                                <%= tech %>
                                            </span>

                                        <%
                                            }
                                        } %>

                                    </div>

                                <% } %>


                                <div class="project-actions">

                                    <% if (project.getProjectLink() != null
                                          && !project.getProjectLink().trim().isEmpty()) { %>

                                        <a href="<%= project.getProjectLink() %>"
                                           target="_blank"
                                           rel="noopener noreferrer"
                                           class="project-action-btn">

                                            <i class="bi bi-box-arrow-up-right"></i>
                                            View Project

                                        </a>

                                    <% } %>


                                    <button type="button"
                                            class="project-action-btn edit-project-btn"

                                            data-id="<%= project.getProjectId() %>"

                                            data-title="<%= project.getProjectTitle() %>"

                                            data-description="<%= project.getDescription() == null ? "" : project.getDescription() %>"

                                            data-technologies="<%= project.getTechnologies() == null ? "" : project.getTechnologies() %>"

                                            data-link="<%= project.getProjectLink() == null ? "" : project.getProjectLink() %>"

                                            data-bs-toggle="modal"
                                            data-bs-target="#editProjectModal">

                                        <i class="bi bi-pencil"></i>
                                        Edit

                                    </button>


                                    <form method="post"
                                          action="<%= request.getContextPath() %>/studentProjects"
                                          onsubmit="return confirm('Are you sure you want to delete this project?');">

                                        <input type="hidden"
                                               name="action"
                                               value="delete">

                                        <input type="hidden"
                                               name="projectId"
                                               value="<%= project.getProjectId() %>">

                                        <button type="submit"
                                                class="project-action-btn">

                                            <i class="bi bi-trash"></i>
                                            Delete

                                        </button>

                                    </form>

                                </div>

                            </div>

                        <% } %>

                    </div>

                <% } %>

            </div>
            <!-- =================================================
                 EDIT BUTTON
            ================================================== -->

            <div class="profile-actions">

                <a href="<%= request.getContextPath() %>/editStudentProfile"
                   class="profile-btn">

                    <i class="bi bi-pencil-square"></i>

                    Edit Profile

                </a>

            </div>


        <% } else { %>


            <!-- =================================================
                 NO PROFILE
            ================================================== -->

            <div class="no-profile">


                <div class="empty-icon">

                    <i class="bi bi-person-plus"></i>

                </div>


                <h4>
                    Complete Your Profile
                </h4>


                <p>
                    Add your education, skills, contact information,
                    GitHub, LinkedIn and resume.
                </p>


                <a href="<%= request.getContextPath() %>/editStudentProfile"
                   class="profile-btn">

                    <i class="bi bi-plus-circle"></i>

                    Add Profile Information

                </a>


            </div>


        <% } %>


    </div>
<!-- =========================================================
     ADD PROJECT MODAL
========================================================== -->

<div class="modal fade project-modal"
     id="addProjectModal"
     tabindex="-1">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <form method="post"
                  action="<%= request.getContextPath() %>/studentProjects">

                <div class="modal-header">

                    <h5 class="modal-title">
                        <i class="bi bi-plus-circle me-2"></i>
                        Add New Project
                    </h5>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"></button>

                </div>


                <div class="modal-body">

                    <input type="hidden"
                           name="action"
                           value="add">


                    <div class="mb-3">

                        <label class="form-label">
                            Project Title *
                        </label>

                        <input type="text"
                               name="projectTitle"
                               class="form-control"
                               maxlength="150"
                               required>

                    </div>


                    <div class="mb-3">

                        <label class="form-label">
                            Description
                        </label>

                        <textarea name="description"
                                  class="form-control"
                                  rows="3"
                                  placeholder="Describe your project..."></textarea>

                    </div>


                    <div class="mb-3">

                        <label class="form-label">
                            Technologies Used
                        </label>

                        <input type="text"
                               name="technologies"
                               class="form-control"
                               maxlength="500"
                               placeholder="Java, JSP, MySQL, Bootstrap">

                        <small class="text-secondary">
                            Separate technologies using commas.
                        </small>

                    </div>


                    <div class="mb-3">

                        <label class="form-label">
                            GitHub / Live Project URL
                        </label>

                        <input type="url"
                               name="projectLink"
                               class="form-control"
                               maxlength="500"
                               placeholder="https://github.com/username/project">

                    </div>

                </div>


                <div class="modal-footer">

                    <button type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">

                        Cancel

                    </button>

                    <button type="submit"
                            class="profile-btn">

                        <i class="bi bi-check-circle"></i>
                        Save Project

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>



<!-- =========================================================
     EDIT PROJECT MODAL
========================================================== -->

<div class="modal fade project-modal"
     id="editProjectModal"
     tabindex="-1">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <form method="post"
                  action="<%= request.getContextPath() %>/studentProjects">

                <div class="modal-header">

                    <h5 class="modal-title">
                        <i class="bi bi-pencil-square me-2"></i>
                        Edit Project
                    </h5>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"></button>

                </div>


                <div class="modal-body">

                    <input type="hidden"
                           name="action"
                           value="update">

                    <input type="hidden"
                           name="projectId"
                           id="editProjectId">


                    <div class="mb-3">

                        <label class="form-label">
                            Project Title *
                        </label>

                        <input type="text"
                               name="projectTitle"
                               id="editProjectTitle"
                               class="form-control"
                               maxlength="150"
                               required>

                    </div>


                    <div class="mb-3">

                        <label class="form-label">
                            Description
                        </label>

                        <textarea name="description"
                                  id="editProjectDescription"
                                  class="form-control"
                                  rows="3"></textarea>

                    </div>


                    <div class="mb-3">

                        <label class="form-label">
                            Technologies Used
                        </label>

                        <input type="text"
                               name="technologies"
                               id="editProjectTechnologies"
                               class="form-control"
                               maxlength="500">

                    </div>


                    <div class="mb-3">

                        <label class="form-label">
                            GitHub / Live Project URL
                        </label>

                        <input type="url"
                               name="projectLink"
                               id="editProjectLink"
                               class="form-control"
                               maxlength="500">

                    </div>

                </div>


                <div class="modal-footer">

                    <button type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">

                        Cancel

                    </button>

                    <button type="submit"
                            class="profile-btn">

                        <i class="bi bi-check-circle"></i>
                        Update Project

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>
</section>



<!-- =========================================================
     FOOTER
========================================================== -->

<footer>

    <i class="bi bi-mortarboard-fill"></i>

    CampusConnect © 2026

</footer>



<!-- =========================================================
     BOOTSTRAP JS
========================================================== -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
<script>

document.querySelectorAll(".edit-project-btn").forEach(button => {

    button.addEventListener("click", function () {

        document.getElementById("editProjectId").value =
            this.dataset.id;

        document.getElementById("editProjectTitle").value =
            this.dataset.title;

        document.getElementById("editProjectDescription").value =
            this.dataset.description;

        document.getElementById("editProjectTechnologies").value =
            this.dataset.technologies;

        document.getElementById("editProjectLink").value =
            this.dataset.link;

    });

});

</script>
</script>


</body>

</html>