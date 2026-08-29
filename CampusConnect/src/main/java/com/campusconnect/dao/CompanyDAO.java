package com.campusconnect.dao;

import java.sql.*;
import com.campusconnect.model.Company;
import com.campusconnect.util.DBConnection;

public class CompanyDAO {

    // Create a company profile row, linked to a user_id
    public boolean createCompanyProfile(int userId, String companyName) {
        String sql = "INSERT INTO company (user_id, company_name, description) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, companyName);
            ps.setString(3, "");

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get company profile by user_id (needed to find company_id for posting opportunities)
    public Company getCompanyByUserId(int userId) {
        String sql = "SELECT * FROM company WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Company c = new Company();
                c.setCompanyId(rs.getInt("company_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setCompanyName(rs.getString("company_name"));
                c.setDescription(rs.getString("description"));
                return c;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}