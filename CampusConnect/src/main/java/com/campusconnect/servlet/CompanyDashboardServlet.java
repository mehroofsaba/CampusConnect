package com.campusconnect.servlet;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/companyDashboard")
public class CompanyDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Check company login
        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get company using logged-in user's ID
        CompanyDAO companyDAO = new CompanyDAO();

        Company company = companyDAO.getCompanyByUserId(user.getUserId());

        if (company == null) {
            request.setAttribute("error", "Company profile not found.");
            request.getRequestDispatcher("/companyDashboard.jsp")
                   .forward(request, response);
            return;
        }

        // IMPORTANT:
        // Use company_id, NOT user_id
        int companyId = company.getCompanyId();
        System.out.println("USER ID = " + user.getUserId());
        System.out.println("COMPANY ID = " + companyId);

        // Get opportunities posted by this company
        OpportunityDAO opportunityDAO = new OpportunityDAO();

        List<Opportunity> opportunities =
                opportunityDAO.getOpportunitiesByCompany(companyId);

        // Send opportunities to JSP
        request.setAttribute("opportunities", opportunities);

        // Send company information too
        request.setAttribute("company", company);

        // Open dashboard
        request.getRequestDispatcher("/companyDashboard.jsp")
               .forward(request, response);
    }
}