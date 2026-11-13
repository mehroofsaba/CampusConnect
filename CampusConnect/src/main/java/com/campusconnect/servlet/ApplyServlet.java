package com.campusconnect.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.ApplicationDAO;
import com.campusconnect.dao.StudentProfileDAO;
import com.campusconnect.dao.OpportunityDAO;

import com.campusconnect.model.StudentProfile;
import com.campusconnect.model.Opportunity;
import com.campusconnect.model.User;

@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user
        User user = (User) session.getAttribute("user");

        // Only students can apply
        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get opportunity ID
        String oppIdParam = request.getParameter("oppId");

        if (oppIdParam == null || oppIdParam.trim().isEmpty()) {

            session.setAttribute("applyMessage", "Invalid opportunity.");

            response.sendRedirect(
                request.getContextPath() + "/studentDashboard.jsp"
            );

            return;
        }

        try {

            int studentId = user.getUserId();
            int oppId = Integer.parseInt(oppIdParam);

            // ==========================================
            // STEP 1: GET STUDENT PROFILE
            // ==========================================

            StudentProfileDAO profileDAO = new StudentProfileDAO();

            StudentProfile profile =
                    profileDAO.getProfileByUserId(studentId);

            // Check profile completeness
            if (profile == null
                    || profile.getSkills() == null
                    || profile.getSkills().trim().isEmpty()
                    || profile.getEducation() == null
                    || profile.getEducation().trim().isEmpty()
                    || profile.getResumePath() == null
                    || profile.getResumePath().trim().isEmpty()) {

                session.setAttribute(
                    "applyMessage",
                    "Please complete your profile to apply for this opportunity."
                );

                response.sendRedirect(
                    request.getContextPath() + "/studentProfile"
                );

                return;
            }

            // ==========================================
            // STEP 2: GET OPPORTUNITY DETAILS
            // ==========================================

            OpportunityDAO opportunityDAO = new OpportunityDAO();

            Opportunity opportunity =
                    opportunityDAO.getOpportunityById(oppId);

            if (opportunity == null) {

                session.setAttribute(
                    "applyMessage",
                    "Opportunity not found."
                );

                response.sendRedirect(
                    request.getContextPath() + "/studentDashboard.jsp"
                );

                return;
            }
         // ==========================================
         // CHECK APPLICATION DEADLINE
         // ==========================================

         if (opportunity.getApplicationDeadline() != null) {

             LocalDate deadline =
                     opportunity.getApplicationDeadline().toLocalDate();

             LocalDate today = LocalDate.now();

             if (today.isAfter(deadline)) {

                 session.setAttribute(
                     "applyMessage",
                     "The application deadline for this opportunity has passed."
                 );

                 response.sendRedirect(
                     request.getContextPath() + "/studentDashboard.jsp"
                 );

                 return;
             }
         }
            // ==========================================
            // STEP 3: CHECK ELIGIBILITY
            // ==========================================

            StringBuilder reasons = new StringBuilder();

            // CHECK CGPA

            double minimumCgpa = opportunity.getMinCgpa();

            if (minimumCgpa > 0) {

                BigDecimal studentCgpa = profile.getCgpa();

                if (studentCgpa == null ||
                    studentCgpa.compareTo(
                        BigDecimal.valueOf(minimumCgpa)
                    ) < 0) {

                    reasons.append(
                        "Minimum CGPA required: " + minimumCgpa +
                        ". Your CGPA: " +
                        (studentCgpa == null ? "Not provided" : studentCgpa) +
                        ". "
                    );
                }
            }

            // CHECK DEPARTMENT

            String eligibleDepartments =
                    opportunity.getEligibleDepartments();

            if (eligibleDepartments != null &&
                !eligibleDepartments.trim().isEmpty()) {

                String studentDepartment = profile.getDepartment();

                boolean departmentMatch = false;

                if (studentDepartment != null &&
                    !studentDepartment.trim().isEmpty()) {

                    String[] departments =
                            eligibleDepartments.split(",");

                    for (String department : departments) {

                        if (department.trim().equalsIgnoreCase(
                                studentDepartment.trim())) {

                            departmentMatch = true;
                            break;
                        }
                    }
                }

                if (!departmentMatch) {

                    reasons.append(
                        "Eligible departments: " +
                        eligibleDepartments +
                        ". Your department: " +
                        (studentDepartment == null ||
                         studentDepartment.trim().isEmpty()
                         ? "Not provided"
                         : studentDepartment) +
                        ". "
                    );
                }
            }

            // CHECK GRADUATION YEAR

            Integer requiredYear =
                    opportunity.getGraduationYear();

            if (requiredYear != null) {

                Integer studentYear =
                        profile.getGraduationYear();

                if (studentYear == null ||
                    !requiredYear.equals(studentYear)) {

                    reasons.append(
                        "Required graduation year: " + requiredYear +
                        ". Your graduation year: " +
                        (studentYear == null
                         ? "Not provided"
                         : studentYear) +
                        ". "
                    );
                }
            }

            // ==========================================
            // STEP 4: BLOCK INELIGIBLE STUDENTS
            // ==========================================

            if (reasons.length() > 0) {

                session.setAttribute(
                    "applyMessage",
                    "You are not eligible for this opportunity. " +
                    reasons.toString()
                );

                response.sendRedirect(
                    request.getContextPath() + "/studentDashboard.jsp"
                );

                return;
            }

            // ==========================================
            // STEP 5: CHECK DUPLICATE APPLICATION
            // ==========================================

            ApplicationDAO applicationDAO = new ApplicationDAO();

            if (applicationDAO.alreadyApplied(studentId, oppId)) {

                session.setAttribute(
                    "applyMessage",
                    "You have already applied for this opportunity."
                );

            } else {

                // ==========================================
                // STEP 6: SUBMIT APPLICATION
                // ==========================================

                boolean success =
                        applicationDAO.apply(studentId, oppId);

                if (success) {

                    session.setAttribute(
                        "applyMessage",
                        "Application submitted successfully!"
                    );

                } else {

                    session.setAttribute(
                        "applyMessage",
                        "Application failed. Please try again."
                    );
                }
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                "applyMessage",
                "Invalid opportunity."
            );
        }

        response.sendRedirect(
            request.getContextPath() + "/studentDashboard.jsp"
        );
    }
}