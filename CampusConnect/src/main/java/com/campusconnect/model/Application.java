package com.campusconnect.model;

import java.sql.Date;

public class Application {
    private int appId;
    private int studentId;
    private int oppId;
    private String status; // PENDING, ACCEPTED, REJECTED
    private Date appliedDate;
    private String studentName;


    public Application() {}

    public Application(int appId, int studentId, int oppId, String status, Date appliedDate) {
        this.appId = appId;
        this.studentId = studentId;
        this.oppId = oppId;
        this.status = status;
        this.appliedDate = appliedDate;
    }

    public int getAppId() { return appId; }
    public void setAppId(int appId) { this.appId = appId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getOppId() { return oppId; }
    public void setOppId(int oppId) { this.oppId = oppId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getAppliedDate() { return appliedDate; }
    public void setAppliedDate(Date appliedDate) { this.appliedDate = appliedDate; }
    
    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) 
    {
        this.studentName = studentName;
    }
}