package com.campusconnect.servlet;

import java.io.IOException;
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

        // Security check: only logged-in COMPANY users can post
        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        CompanyDAO companyDAO = new CompanyDAO();
        Company company = companyDAO.getCompanyByUserId(user.getUserId());

        if (company == null) {
            request.setAttribute("error", "Company profile not found.");
            request.getRequestDispatcher("postJob.jsp").forward(request, response);
            return;
        }

        String title = request.getParameter("title");
        String type = request.getParameter("type");
        String skillRequired = request.getParameter("skillRequired");
        String location = request.getParameter("location");
        String description = request.getParameter("description");

        Opportunity opp = new Opportunity();
        opp.setCompanyId(company.getCompanyId());
        opp.setTitle(title);
        opp.setType(type);
        opp.setSkillRequired(skillRequired);
        opp.setLocation(location);
        opp.setDescription(description);

        OpportunityDAO oppDAO = new OpportunityDAO();
        boolean success = oppDAO.addOpportunity(opp);

        if (success) {

            response.sendRedirect(
                request.getContextPath() + "/companyDashboard"
            );

            return;

        } else {

            request.setAttribute("error", "Failed to post opportunity.");

            request.getRequestDispatcher("/postJob.jsp")
                   .forward(request, response);
        }
    }
}