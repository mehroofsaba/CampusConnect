package com.campusconnect.model;

public class StudentProfile {
    private int profileId;
    private int userId;
    private String skills;
    private String education;
    private String resumePath;

    public StudentProfile() {}

    public StudentProfile(int profileId, int userId, String skills, String education, String resumePath) {
        this.profileId = profileId;
        this.userId = userId;
        this.skills = skills;
        this.education = education;
        this.resumePath = resumePath;
    }

    public int getProfileId() { return profileId; }
    public void setProfileId(int profileId) { this.profileId = profileId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getEducation() { return education; }
    public void setEducation(String education) { this.education = education; }

    public String getResumePath() { return resumePath; }
    public void setResumePath(String resumePath) { this.resumePath = resumePath; }
}