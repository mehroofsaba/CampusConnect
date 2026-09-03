package com.campusconnect.servlet;

import java.io.File;
import java.io.IOException;

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


    // OPEN EDIT PAGE
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        StudentProfileDAO dao = new StudentProfileDAO();

        StudentProfile profile =
                dao.getProfileByUserId(user.getUserId());

        request.setAttribute("profile", profile);

        request.getRequestDispatcher("editStudentProfile.jsp")
               .forward(request, response);
    }


    // SAVE PROFILE
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }


        int userId = user.getUserId();


        // GET FORM DATA

        String phone =
                request.getParameter("phone");

        String location =
                request.getParameter("location");

        String bio =
                request.getParameter("bio");

        String education =
                request.getParameter("education");

        String skills =
                request.getParameter("skills");

        String githubLink =
                request.getParameter("githubLink");

        String linkedinLink =
                request.getParameter("linkedinLink");


        StudentProfileDAO dao =
                new StudentProfileDAO();

        StudentProfile existingProfile =
                dao.getProfileByUserId(userId);


        String resumePath = null;


        // KEEP OLD RESUME IF NO NEW FILE IS SELECTED

        if (existingProfile != null) {
            resumePath = existingProfile.getResumePath();
        }


        // HANDLE NEW RESUME

        Part resumePart =
                request.getPart("resume");


        if (resumePart != null &&
            resumePart.getSize() > 0) {

            String contentType =
                    resumePart.getContentType();

            String submittedName =
                    resumePart.getSubmittedFileName();


            if (contentType == null ||
                !"application/pdf".equalsIgnoreCase(contentType) ||
                submittedName == null ||
                !submittedName.toLowerCase().endsWith(".pdf")) {

                response.getWriter().println(
                    "Only PDF resumes are allowed."
                );

                return;
            }


            // CREATE UPLOAD DIRECTORY

            String uploadPath =
                    getServletContext()
                    .getRealPath("/uploads/resumes");


            File uploadDirectory =
                    new File(uploadPath);

            if (!uploadDirectory.exists()) {
                uploadDirectory.mkdirs();
            }


            // UNIQUE NAME BASED ON USER ID

            String fileName =
                    "resume_" + userId + ".pdf";


            File savedFile =
                    new File(uploadDirectory, fileName);


            resumePart.write(savedFile.getAbsolutePath());


            resumePath =
                    "uploads/resumes/" + fileName;
        }


        // CREATE OR UPDATE PROFILE

        StudentProfile profile;


        if (existingProfile == null) {

            profile = new StudentProfile();

            profile.setUserId(userId);

            profile.setSkills(skills);
            profile.setEducation(education);
            profile.setResumePath(resumePath);

            profile.setPhone(phone);
            profile.setLocation(location);
            profile.setBio(bio);

            profile.setGithubLink(githubLink);
            profile.setLinkedinLink(linkedinLink);

            dao.createProfile(profile);

        } else {

            existingProfile.setSkills(skills);
            existingProfile.setEducation(education);
            existingProfile.setResumePath(resumePath);

            existingProfile.setPhone(phone);
            existingProfile.setLocation(location);
            existingProfile.setBio(bio);

            existingProfile.setGithubLink(githubLink);
            existingProfile.setLinkedinLink(linkedinLink);

            dao.updateProfile(existingProfile);
        }


        response.sendRedirect(
            request.getContextPath() + "/studentProfile"
        );
    }
}