package com.campusconnect.servlet;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.campusconnect.dao.StudentProfileDAO;
import com.campusconnect.model.StudentProfile;
import com.campusconnect.model.User;

@WebServlet("/editStudentProfile")

@MultipartConfig(
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 6 * 1024 * 1024
)

public class EditStudentProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // OPEN EDIT PROFILE PAGE

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        User user = getStudent(request, response);

        if (user == null) {
            return;
        }

        StudentProfileDAO dao = new StudentProfileDAO();

        StudentProfile profile =
            dao.getProfileByUserId(user.getUserId());

        request.setAttribute("profile", profile);

        request.getRequestDispatcher("/editStudentProfile.jsp")
               .forward(request, response);
    }


    // SAVE PROFILE

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User user = getStudent(request, response);

        if (user == null) {
            return;
        }

        String phone = trim(request.getParameter("phone"));
        String location = trim(request.getParameter("location"));
        String bio = trim(request.getParameter("bio"));

        String education = trim(request.getParameter("education"));
        String skills = trim(request.getParameter("skills"));

        String github = trim(request.getParameter("githubLink"));
        String linkedin = trim(request.getParameter("linkedinLink"));

        // New fields

        String department = trim(request.getParameter("department"));
        String cgpaText = trim(request.getParameter("cgpa"));

        String yearText = trim(request.getParameter("graduationYear"));

        String achievements = trim(request.getParameter("achievements"));


        StudentProfileDAO dao = new StudentProfileDAO();

        StudentProfile existing =
            dao.getProfileByUserId(user.getUserId());


        // CGPA VALIDATION

        BigDecimal cgpa = null;

        Integer graduationYear = null;

        try {

            if (!cgpaText.isEmpty()) {

                cgpa = new BigDecimal(cgpaText);

                if (cgpa.compareTo(BigDecimal.ZERO) < 0 ||
                    cgpa.compareTo(new BigDecimal("10.00")) > 0) {

                    forwardWithError(
                        request,
                        response,
                        existing,
                        "CGPA must be between 0 and 10."
                    );

                    return;
                }

                cgpa = cgpa.setScale(2, RoundingMode.HALF_UP);
            }


            // GRADUATION YEAR VALIDATION

            if (!yearText.isEmpty()) {

                graduationYear = Integer.valueOf(yearText);

                if (graduationYear < 2000 ||
                    graduationYear > 2100) {

                    forwardWithError(
                        request,
                        response,
                        existing,
                        "Enter a valid graduation year."
                    );

                    return;
                }
            }

        } catch (NumberFormatException e) {

            forwardWithError(
                request,
                response,
                existing,
                "Enter valid CGPA and graduation year."
            );

            return;
        }


        // FIELD LENGTH VALIDATION

        if (phone.length() > 20 ||
            location.length() > 100 ||
            department.length() > 100 ||
            skills.length() > 255 ||
            education.length() > 255 ||
            github.length() > 255 ||
            linkedin.length() > 255) {

            forwardWithError(
                request,
                response,
                existing,
                "One or more fields exceed the allowed length."
            );

            return;
        }


        // URL VALIDATION

        if (!validOptionalUrl(github) ||
            !validOptionalUrl(linkedin)) {

            forwardWithError(
                request,
                response,
                existing,
                "Enter valid HTTP/HTTPS GitHub and LinkedIn URLs."
            );

            return;
        }


        // RESUME MANAGEMENT

        String resumePath =
            existing == null ? null : existing.getResumePath();

        Part resumePart = request.getPart("resume");

        if (resumePart != null && resumePart.getSize() > 0) {

            String submittedName = resumePart.getSubmittedFileName();

            String contentType = resumePart.getContentType();

            if (submittedName == null ||
                !submittedName.toLowerCase().endsWith(".pdf") ||
                contentType == null ||
                !"application/pdf".equalsIgnoreCase(contentType)) {

                forwardWithError(
                    request,
                    response,
                    existing,
                    "Only PDF resumes are allowed."
                );

                return;
            }


            String uploadPath =
                getServletContext().getRealPath("/uploads/resumes");

            if (uploadPath == null) {

                forwardWithError(
                    request,
                    response,
                    existing,
                    "Resume upload directory is unavailable."
                );

                return;
            }

            File directory = new File(uploadPath);

            if (!directory.exists() && !directory.mkdirs()) {

                forwardWithError(
                    request,
                    response,
                    existing,
                    "Could not create resume directory."
                );

                return;
            }


            String fileName =
                "resume_" + user.getUserId() + ".pdf";

            File destination =
                new File(directory, fileName);

            resumePart.write(destination.getAbsolutePath());

            resumePath = "uploads/resumes/" + fileName;
        }


        // CREATE OR UPDATE PROFILE

        StudentProfile profile =
            existing == null ? new StudentProfile() : existing;

        profile.setUserId(user.getUserId());

        profile.setPhone(phone);
        profile.setLocation(location);
        profile.setBio(bio);

        profile.setEducation(education);
        profile.setSkills(skills);

        profile.setGithubLink(github);
        profile.setLinkedinLink(linkedin);

        // New fields

        profile.setDepartment(department);
        profile.setCgpa(cgpa);
        profile.setGraduationYear(graduationYear);
        profile.setAchievements(achievements);

        profile.setResumePath(resumePath);


        boolean saved =
            existing == null
            ? dao.createProfile(profile)
            : dao.updateProfile(profile);


        if (!saved) {

            forwardWithError(
                request,
                response,
                profile,
                "Profile could not be saved. Check the database and server console."
            );

            return;
        }


        response.sendRedirect(
            request.getContextPath() + "/studentProfile?updated=1"
        );
    }


    // CHECK STUDENT SESSION

    private User getStudent(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        HttpSession session = request.getSession(false);

        User user = session == null
            ? null
            : (User) session.getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole())) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );

            return null;
        }

        return user;
    }


    // ERROR HANDLING

    private void forwardWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            StudentProfile profile,
            String message
    ) throws ServletException, IOException {

        request.setAttribute("profile", profile);

        request.setAttribute("errorMessage", message);

        request.getRequestDispatcher("/editStudentProfile.jsp")
               .forward(request, response);
    }


    // TRIM INPUT

    private String trim(String value) {

        return value == null ? "" : value.trim();
    }


    // URL VALIDATION

    private boolean validOptionalUrl(String value) {

        if (value == null || value.isEmpty()) {
            return true;
        }

        try {

            java.net.URI uri = new java.net.URI(value);

            String scheme = uri.getScheme();

            return uri.getHost() != null &&
                   scheme != null &&
                   ("http".equalsIgnoreCase(scheme) ||
                    "https".equalsIgnoreCase(scheme));

        } catch (java.net.URISyntaxException e) {

            return false;
        }
    }
}