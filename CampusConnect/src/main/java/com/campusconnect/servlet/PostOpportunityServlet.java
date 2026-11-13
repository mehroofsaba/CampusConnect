package com.campusconnect.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.CompanyDAO;
import com.campusconnect.dao.OpportunityDAO;
import com.campusconnect.model.Company;
import com.campusconnect.model.Opportunity;
import com.campusconnect.model.User;

@WebServlet("/postOpportunity")
public class PostOpportunityServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // =====================================================
        // 1. SECURITY CHECK
        // =====================================================

        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // =====================================================
        // 2. GET COMPANY PROFILE FROM DATABASE
        // =====================================================

        CompanyDAO companyDAO = new CompanyDAO();

        Company company =
                companyDAO.getCompanyByUserId(user.getUserId());

        // No company profile exists
        if (company == null) {

            session.setAttribute(
                "profileMessage",
                "Please complete your profile to publish an opportunity."
            );

            response.sendRedirect(
                request.getContextPath() + "/companyProfile"
            );

            return;
        }

        if (company.getCompanyName() == null
                || company.getCompanyName().trim().isEmpty()
                || company.getIndustry() == null
                || company.getIndustry().trim().isEmpty()
                || company.getDescription() == null
                || company.getDescription().trim().isEmpty()
                || company.getLocation() == null
                || company.getLocation().trim().isEmpty()
                || company.getCompanyEmail() == null
                || company.getCompanyEmail().trim().isEmpty()
                || company.getContactNumber() == null
                || company.getContactNumber().trim().isEmpty()
                || company.getCompanySize() == null
                || company.getCompanySize().trim().isEmpty()) {

            session.setAttribute(
                "profileMessage",
                "Please complete your profile to publish an opportunity."
            );

            response.sendRedirect(
                request.getContextPath() + "/companyProfile"
            );

            return;
        }

        // =====================================================
        // 3. CHECK WHETHER COMPANY PROFILE IS COMPLETE
        // =====================================================

        boolean profileComplete = true;

        // Company name
        if (company.getCompanyName() == null ||
            company.getCompanyName().trim().isEmpty()) {

            profileComplete = false;
        }

        // Industry
        if (company.getIndustry() == null ||
            company.getIndustry().trim().isEmpty()) {

            profileComplete = false;
        }

        // Description
        if (company.getDescription() == null ||
            company.getDescription().trim().isEmpty()) {

            profileComplete = false;
        }

        // Location
        if (company.getLocation() == null ||
            company.getLocation().trim().isEmpty()) {

            profileComplete = false;
        }

        // Company email
        if (company.getCompanyEmail() == null ||
            company.getCompanyEmail().trim().isEmpty()) {

            profileComplete = false;
        }

        // Contact number
        if (company.getContactNumber() == null ||
            company.getContactNumber().trim().isEmpty()) {

            profileComplete = false;
        }

        // Company size
        if (company.getCompanySize() == null ||
            company.getCompanySize().trim().isEmpty()) {

            profileComplete = false;
        }

        // =====================================================
        // 4. BLOCK POSTING IF PROFILE IS INCOMPLETE
        // =====================================================

        if (!profileComplete) {

            response.sendRedirect(
                request.getContextPath() + "/companyProfile"
            );

            return;
        }

     // =====================================================
     // 5. GET OPPORTUNITY FORM DATA
     // =====================================================

     String title = request.getParameter("title");
     String type = request.getParameter("type");
     String skillRequired = request.getParameter("skillRequired");
     String location = request.getParameter("location");
     String description = request.getParameter("description");

     String minCgpaParam = request.getParameter("minCgpa");
     String departments = request.getParameter("eligibleDepartments");
     String graduationYearParam = request.getParameter("graduationYear");
     String deadlineParam = request.getParameter("applicationDeadline");

     double minCgpa = 0.0;
     Integer graduationYear = null;
     Date applicationDeadline = null;

     try {

         // Validate minimum CGPA
         if (minCgpaParam != null && !minCgpaParam.trim().isEmpty()) {
             minCgpa = Double.parseDouble(minCgpaParam);
         }

         if (minCgpa < 0 || minCgpa > 10) {
             request.setAttribute("error",
                     "Minimum CGPA must be between 0 and 10.");
             request.getRequestDispatcher("postJob.jsp").forward(request, response);
             return;
         }

         // Validate graduation year
         if (graduationYearParam != null && !graduationYearParam.trim().isEmpty()) {

             graduationYear = Integer.parseInt(graduationYearParam);

             if (graduationYear < 2000 || graduationYear > 2100) {
                 throw new NumberFormatException();
             }
         }

         // Validate application deadline
         if (deadlineParam != null && !deadlineParam.trim().isEmpty()) {

             LocalDate selectedDate = LocalDate.parse(deadlineParam);

             if (selectedDate.isBefore(LocalDate.now())) {

                 request.setAttribute("error",
                         "Application deadline cannot be in the past.");

                 request.getRequestDispatcher("postJob.jsp").forward(request, response);
                 return;
             }

             applicationDeadline = Date.valueOf(selectedDate);
         }

     } catch (NumberFormatException e) {

         request.setAttribute("error",
                 "Please enter valid eligibility details.");

         request.getRequestDispatcher("postJob.jsp").forward(request, response);
         return;

     } catch (DateTimeParseException e) {

         request.setAttribute("error",
                 "Please enter a valid application deadline.");

         request.getRequestDispatcher("postJob.jsp").forward(request, response);
         return;
     }

     // Clean department input
     if (departments != null) {

         departments = departments.trim();

         if (departments.isEmpty()) {
             departments = null;
         }
     }

        // =====================================================
        // 6. CREATE OPPORTUNITY
        // =====================================================

        Opportunity opp = new Opportunity();

        opp.setCompanyId(company.getCompanyId());
        opp.setTitle(title);
        opp.setType(type);
        opp.setSkillRequired(skillRequired);
        opp.setLocation(location);
        opp.setDescription(description);
        opp.setMinCgpa(minCgpa);
        opp.setEligibleDepartments(departments);
        opp.setGraduationYear(graduationYear);
        opp.setApplicationDeadline(applicationDeadline);

        OpportunityDAO oppDAO = new OpportunityDAO();

        boolean success = oppDAO.addOpportunity(opp);

        // =====================================================
        // 7. RESULT
        // =====================================================

        if (success) {

            session.setAttribute(
                "successMessage",
                "Opportunity posted successfully!"
            );

            response.sendRedirect(
                request.getContextPath() + "/companyDashboard"
            );

            return;
        } else {

            request.setAttribute(
                "error",
                "Failed to post opportunity."
            );

            request.getRequestDispatcher(
                "/postJob.jsp"
            ).forward(request, response);
        }
    }
}