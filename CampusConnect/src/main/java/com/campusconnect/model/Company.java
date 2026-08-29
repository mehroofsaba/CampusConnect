package com.campusconnect.model;

public class Company {
    private int companyId;
    private int userId;
    private String companyName;
    private String description;

    public Company() {}

    public Company(int companyId, int userId, String companyName, String description) {
        this.companyId = companyId;
        this.userId = userId;
        this.companyName = companyName;
        this.description = description;
    }

    public int getCompanyId() { return companyId; }
    public void setCompanyId(int companyId) { this.companyId = companyId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}