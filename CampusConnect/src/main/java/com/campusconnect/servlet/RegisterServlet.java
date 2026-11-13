package com.campusconnect.servlet;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.campusconnect.dao.UserDAO;
import com.campusconnect.dao.CompanyDAO;
import com.campusconnect.model.User;
import com.campusconnect.model.Company;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Check empty fields
        if (name == null || email == null ||
            password == null || role == null ||
            name.trim().isEmpty() ||
            email.trim().isEmpty() ||
            password.isEmpty() ||
            role.trim().isEmpty()) {

            showError(request, response, "All fields are required.");
            return;
        }

        // Normalize name and email
        name = name.trim();
        email = email.trim().toLowerCase(Locale.ROOT);
        role = role.trim().toUpperCase(Locale.ROOT);

        // Validate name
        if (name.length() < 2) {
            showError(request, response,
                    "Name must contain at least 2 characters.");
            return;
        }

        // Validate email
        if (email.length() > 254 ||
            !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {

            showError(request, response,
                    "Please enter a valid email address.");
            return;
        }

        // Validate password length
        int passwordBytes =
                password.getBytes(StandardCharsets.UTF_8).length;

        if (password.length() < 8) {
            showError(request, response,
                    "Password must contain at least 8 characters.");
            return;
        }
     // Require at least one special character
        if (!password.matches(".*[^a-zA-Z0-9\\s].*")) {
            showError(request, response,
                    "Password must contain at least one special character (e.g. @, #, $, !).");
            return;
        }
        // BCrypt supports a maximum of 72 UTF-8 bytes
        if (passwordBytes > 72) {
            showError(request, response,
                    "Password is too long. Please use a shorter password.");
            return;
        }

        // Only STUDENT and COMPANY registrations are allowed
        if (!"STUDENT".equals(role) &&
            !"COMPANY".equals(role)) {

            showError(request, response,
                    "Invalid registration role.");
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Check duplicate email
        if (userDAO.emailExists(email)) {
            showError(request, response,
                    "Email already registered!");
            return;
        }

        // Create user
        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        // Register user (BCrypt hashing happens inside UserDAO)
        boolean success = userDAO.registerUser(user);

        if (!success) {
            showError(request, response,
                    "Registration failed. Please try again.");
            return;
        }

        // COMPANY REGISTRATION
        if ("COMPANY".equals(role)) {

            User newUser = userDAO.login(email, password);

            if (newUser != null) {

                Company company = new Company();

                company.setUserId(newUser.getUserId());
                company.setCompanyName(name);

                company.setIndustry("");
                company.setDescription("");
                company.setLocation("");
                company.setWebsite("");
                company.setCompanyEmail(email);
                company.setContactNumber("");
                company.setLogoPath("");
                company.setFoundedYear(null);
                company.setCompanySize("");
                company.setLinkedinUrl("");

                CompanyDAO companyDAO = new CompanyDAO();

                boolean companyCreated =
                        companyDAO.createCompanyProfile(company);

                if (!companyCreated) {
                    System.out.println(
                        "Warning: Company profile could not be created for user ID: "
                        + newUser.getUserId()
                    );
                }
            }
        }

        // Registration successful
        request.setAttribute(
                "message",
                "Registration successful! Please login."
        );

        request.getRequestDispatcher("/login.jsp")
               .forward(request, response);
    }

    private void showError(HttpServletRequest request,
                           HttpServletResponse response,
                           String message)
            throws ServletException, IOException {

        request.setAttribute("error", message);

        request.getRequestDispatcher("/register.jsp")
               .forward(request, response);
    }
}