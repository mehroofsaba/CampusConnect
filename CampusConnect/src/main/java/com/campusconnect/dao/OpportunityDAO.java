package com.campusconnect.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.campusconnect.model.Opportunity;
import com.campusconnect.util.DBConnection;

public class OpportunityDAO {

    // Add a new opportunity (posted by a company)
	public static boolean addOpportunity(Opportunity opp) {

		String sql = "INSERT INTO opportunity " +
		        "(company_id, title, type, skill_required, location, description, " +
		        "posted_date, min_cgpa, eligible_departments, graduation_year, application_deadline) " +
		        "VALUES (?, ?, ?, ?, ?, ?, CURDATE(), ?, ?, ?, ?)";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, opp.getCompanyId());
	        ps.setString(2, opp.getTitle());
	        ps.setString(3, opp.getType());
	        ps.setString(4, opp.getSkillRequired());
	        ps.setString(5, opp.getLocation());
	        ps.setString(6, opp.getDescription());
	        ps.setDouble(7, opp.getMinCgpa());
	        ps.setString(8, opp.getEligibleDepartments());

	        if (opp.getGraduationYear() != null) {
	            ps.setInt(9, opp.getGraduationYear());
	        } else {
	            ps.setNull(9, java.sql.Types.INTEGER);
	        }
	        if (opp.getApplicationDeadline() != null) {
	            ps.setDate(10, opp.getApplicationDeadline());
	        } else {
	            ps.setNull(10, java.sql.Types.DATE);
	        }
       
	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
 // Update an existing opportunity
	public static boolean updateOpportunity(Opportunity opp) {

		String sql = "UPDATE opportunity SET title=?, type=?, skill_required=?, " +
		        "location=?, description=?, min_cgpa=?, eligible_departments=?, " +
		        "graduation_year=?, application_deadline=? WHERE opp_id=?";
		
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	    	ps.setString(1, opp.getTitle());
	    	ps.setString(2, opp.getType());
	    	ps.setString(3, opp.getSkillRequired());
	    	ps.setString(4, opp.getLocation());
	    	ps.setString(5, opp.getDescription());
	    	ps.setDouble(6, opp.getMinCgpa());
	    	ps.setString(7, opp.getEligibleDepartments());

	    	if (opp.getGraduationYear() != null) {
	    	    ps.setInt(8, opp.getGraduationYear());
	    	} else {
	    	    ps.setNull(8, java.sql.Types.INTEGER);
	    	}

	    	if (opp.getApplicationDeadline() != null) {
	    	    ps.setDate(9, opp.getApplicationDeadline());
	    	} else {
	    	    ps.setNull(9, java.sql.Types.DATE);
	    	}

	    	ps.setInt(10, opp.getOppId());

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
    // Get all opportunities posted by a specific company
    public List<Opportunity> getOpportunitiesByCompany(int companyId) {
        List<Opportunity> list = new ArrayList<>();
        String sql = "SELECT o.*, c.company_name\r\n"
        		+ "FROM opportunity o\r\n"
        		+ "JOIN company c\r\n"
        		+ "ON o.company_id = c.company_id\r\n"
        		+ "WHERE o.company_id = ?\r\n"
        		+ "ORDER BY o.posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, companyId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all opportunities (for student browsing later)
    public List<Opportunity> getAllOpportunities() {
        List<Opportunity> list = new ArrayList<>();
        String sql =
        	    "SELECT o.*, c.company_name " +
        	    "FROM opportunity o " +
        	    "JOIN company c ON o.company_id = c.company_id " +
        	    "ORDER BY o.posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
 // Get a single opportunity by ID
    public Opportunity getOpportunityById(int oppId) {

        String sql = "SELECT o.*, c.company_name " +
                     "FROM opportunity o " +
                     "JOIN company c ON o.company_id = c.company_id " +
                     "WHERE o.opp_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, oppId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapRow(rs);
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    // Helper to map a ResultSet row to an Opportunity object (avoids repeating this in every method)
    private Opportunity mapRow(ResultSet rs) throws SQLException {
        Opportunity opp = new Opportunity();
        opp.setOppId(rs.getInt("opp_id"));
        opp.setCompanyId(rs.getInt("company_id"));
        opp.setTitle(rs.getString("title"));
        opp.setType(rs.getString("type"));
        opp.setSkillRequired(rs.getString("skill_required"));
        opp.setLocation(rs.getString("location"));
        opp.setDescription(rs.getString("description"));
        opp.setPostedDate(rs.getDate("posted_date"));
        opp.setApplicationDeadline(rs.getDate("application_deadline"));
        opp.setCompanyName(
        	    rs.getString("company_name")
        	);
        opp.setMinCgpa(rs.getDouble("min_cgpa"));
        opp.setEligibleDepartments(rs.getString("eligible_departments"));

        int year = rs.getInt("graduation_year");

        if (rs.wasNull()) {
            opp.setGraduationYear(null);
        } else {
            opp.setGraduationYear(year);
        }
        return opp;
        
    }
    public List<Opportunity> searchOpportunities(
            String keyword,
            String type,
            String location,
            String skill) {

        List<Opportunity> opportunities = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT o.*, c.company_name " +
            "FROM opportunity o " +
            "JOIN company c ON o.company_id = c.company_id " +
            "WHERE 1=1 "
        );

        List<String> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (o.title LIKE ? OR c.company_name LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (type != null && !type.trim().isEmpty()) {
            sql.append("AND o.type = ? ");
            params.add(type.trim());
        }

        if (location != null && !location.trim().isEmpty()) {
            sql.append("AND o.location LIKE ? ");
            params.add("%" + location.trim() + "%");
        }

        if (skill != null && !skill.trim().isEmpty()) {
            sql.append("AND o.skill_required LIKE ? ");
            params.add("%" + skill.trim() + "%");
        }

        sql.append("ORDER BY o.posted_date DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                opportunities.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return opportunities;
    }
}
