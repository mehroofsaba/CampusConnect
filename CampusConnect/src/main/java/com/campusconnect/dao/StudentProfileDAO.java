package com.campusconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import com.campusconnect.model.StudentProfile;
import com.campusconnect.util.DBConnection;

public class StudentProfileDAO {

    // GET STUDENT PROFILE

    public StudentProfile getProfileByUserId(int userId) {

        String sql =
            "SELECT * FROM student_profile WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                System.err.println("Database connection is null.");
                return null;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

                        StudentProfile profile = new StudentProfile();

                        profile.setProfileId(rs.getInt("profile_id"));
                        profile.setUserId(rs.getInt("user_id"));

                        profile.setSkills(rs.getString("skills"));
                        profile.setEducation(rs.getString("education"));
                        profile.setResumePath(rs.getString("resume_path"));

                        profile.setPhone(rs.getString("phone"));
                        profile.setLocation(rs.getString("location"));
                        profile.setBio(rs.getString("bio"));

                        profile.setGithubLink(rs.getString("github_link"));
                        profile.setLinkedinLink(rs.getString("linkedin_link"));

                        // New fields

                        profile.setDepartment(rs.getString("department"));

                        profile.setCgpa(rs.getBigDecimal("cgpa"));

                        int year = rs.getInt("graduation_year");

                        profile.setGraduationYear(
                            rs.wasNull() ? null : year
                        );

                        profile.setAchievements(
                            rs.getString("achievements")
                        );

                        return profile;
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // CREATE STUDENT PROFILE

    public boolean createProfile(StudentProfile profile) {

        String sql =
            "INSERT INTO student_profile "
            + "(user_id, skills, education, resume_path, phone, "
            + "location, bio, github_link, linkedin_link, "
            + "department, cgpa, graduation_year, achievements) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                return false;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                bindProfile(ps, profile, false);

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // UPDATE STUDENT PROFILE

    public boolean updateProfile(StudentProfile profile) {

        String sql =
            "UPDATE student_profile SET "
            + "skills=?, education=?, resume_path=?, "
            + "phone=?, location=?, bio=?, "
            + "github_link=?, linkedin_link=?, "
            + "department=?, cgpa=?, "
            + "graduation_year=?, achievements=? "
            + "WHERE user_id=?";

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                return false;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                bindProfile(ps, profile, true);

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // COMMON PARAMETER BINDING

    private void bindProfile(
            PreparedStatement ps,
            StudentProfile profile,
            boolean update
    ) throws SQLException {

        int i = 1;

        if (!update) {
            ps.setInt(i++, profile.getUserId());
        }

        ps.setString(i++, profile.getSkills());
        ps.setString(i++, profile.getEducation());
        ps.setString(i++, profile.getResumePath());

        ps.setString(i++, profile.getPhone());
        ps.setString(i++, profile.getLocation());
        ps.setString(i++, profile.getBio());

        ps.setString(i++, profile.getGithubLink());
        ps.setString(i++, profile.getLinkedinLink());

        ps.setString(i++, profile.getDepartment());

        if (profile.getCgpa() == null) {
            ps.setNull(i++, Types.DECIMAL);
        } else {
            ps.setBigDecimal(i++, profile.getCgpa());
        }

        if (profile.getGraduationYear() == null) {
            ps.setNull(i++, Types.INTEGER);
        } else {
            ps.setInt(i++, profile.getGraduationYear());
        }

        ps.setString(i++, profile.getAchievements());

        if (update) {
            ps.setInt(i, profile.getUserId());
        }
    }
}