package com.campusconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.campusconnect.model.Application;
import com.campusconnect.util.DBConnection;

public class ApplicationDAO {

    // --------------------------------------------------
    // CHECK WHETHER STUDENT ALREADY APPLIED
    // --------------------------------------------------
    public boolean alreadyApplied(int studentId, int oppId) {

        String sql = "SELECT app_id FROM application "
                   + "WHERE student_id = ? AND opp_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);
            ps.setInt(2, oppId);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // --------------------------------------------------
    // APPLY FOR OPPORTUNITY
    // --------------------------------------------------
    public boolean apply(int studentId, int oppId) {

        String sql = "INSERT INTO application "
                   + "(student_id, opp_id, status, applied_date) "
                   + "VALUES (?, ?, 'PENDING', CURDATE())";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);
            ps.setInt(2, oppId);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // --------------------------------------------------
    // GET ALL APPLICATIONS OF A COMPANY
    // --------------------------------------------------
    public List<Application> getApplicationsByCompany(int userId) {

        List<Application> applications = new ArrayList<>();

        String sql =
                "SELECT a.app_id, "
              + "       a.student_id, "
              + "       a.opp_id, "
              + "       a.status, "
              + "       a.applied_date "
              + "FROM application a "
              + "JOIN opportunity o "
              + "ON a.opp_id = o.opp_id "
              +"JOIN company c "
              +"ON o.company_id=c.company_id "
              + "WHERE c.user_id = ? "
              + "ORDER BY a.applied_date DESC";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Application application = new Application();

                application.setAppId(
                    rs.getInt("app_id")
                );

                application.setStudentId(
                    rs.getInt("student_id")
                );

                application.setOppId(
                    rs.getInt("opp_id")
                );

                application.setStatus(
                    rs.getString("status")
                );

                application.setAppliedDate(
                    rs.getDate("applied_date")
                );

                applications.add(application);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return applications;
    }
}