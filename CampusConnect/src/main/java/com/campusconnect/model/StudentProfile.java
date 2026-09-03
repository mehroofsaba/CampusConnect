package com.campusconnect.model;

public class StudentProfile {

    private int profileId;
    private int userId;

    private String skills;
    private String education;
    private String resumePath;

    private String phone;
    private String location;
    private String bio;

    private String githubLink;
    private String linkedinLink;


    public StudentProfile() {
    }


    public StudentProfile(int profileId,
                          int userId,
                          String skills,
                          String education,
                          String resumePath,
                          String phone,
                          String location,
                          String bio,
                          String githubLink,
                          String linkedinLink) {

        this.profileId = profileId;
        this.userId = userId;

        this.skills = skills;
        this.education = education;
        this.resumePath = resumePath;

        this.phone = phone;
        this.location = location;
        this.bio = bio;

        this.githubLink = githubLink;
        this.linkedinLink = linkedinLink;
    }


    public int getProfileId() {
        return profileId;
    }

    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }


    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }


    public String getResumePath() {
        return resumePath;
    }

    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }


    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }


    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }


    public String getGithubLink() {
        return githubLink;
    }

    public void setGithubLink(String githubLink) {
        this.githubLink = githubLink;
    }


    public String getLinkedinLink() {
        return linkedinLink;
    }

    public void setLinkedinLink(String linkedinLink) {
        this.linkedinLink = linkedinLink;
    }
}