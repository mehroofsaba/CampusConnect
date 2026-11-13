-- ============================================================
-- CampusConnect Database Setup
-- MySQL 8.0+
--
-- Run this file in MySQL Workbench to create the database
-- structure for a fresh CampusConnect installation.
--
-- This file is schema-only: it does not contain sample accounts,
-- passwords, resumes, or personal data.
-- Runtime SELECT/INSERT/UPDATE/DELETE statements are handled by
-- the Java DAO classes and do not belong in this setup file.
-- ============================================================

CREATE DATABASE IF NOT EXISTS campusconnect
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE campusconnect;

-- 1. USER
CREATE TABLE IF NOT EXISTS `user` (
    user_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    PRIMARY KEY (user_id),
    UNIQUE KEY uk_user_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2. COMPANY
CREATE TABLE IF NOT EXISTS company (
    company_id INT NOT NULL AUTO_INCREMENT,
    user_id INT DEFAULT NULL,
    company_name VARCHAR(150) NOT NULL,
    description TEXT,
    industry VARCHAR(100) DEFAULT NULL,
    location VARCHAR(150) DEFAULT NULL,
    website VARCHAR(255) DEFAULT NULL,
    company_email VARCHAR(150) DEFAULT NULL,
    contact_number VARCHAR(20) DEFAULT NULL,
    logo_path VARCHAR(255) DEFAULT NULL,
    founded_year INT DEFAULT NULL,
    company_size VARCHAR(50) DEFAULT NULL,
    linkedin_url VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (company_id),
    UNIQUE KEY uk_company_user (user_id),
    CONSTRAINT fk_company_user
        FOREIGN KEY (user_id) REFERENCES `user` (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 3. STUDENT PROFILE
CREATE TABLE IF NOT EXISTS student_profile (
    profile_id INT NOT NULL AUTO_INCREMENT,
    user_id INT DEFAULT NULL,
    skills VARCHAR(255) DEFAULT NULL,
    education VARCHAR(255) DEFAULT NULL,
    resume_path VARCHAR(255) DEFAULT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    location VARCHAR(100) DEFAULT NULL,
    bio TEXT,
    github_link VARCHAR(255) DEFAULT NULL,
    linkedin_link VARCHAR(255) DEFAULT NULL,
    department VARCHAR(150) DEFAULT NULL,
    cgpa DECIMAL(4,2) DEFAULT NULL,
    graduation_year INT DEFAULT NULL,
    achievements TEXT,
    PRIMARY KEY (profile_id),
    UNIQUE KEY uk_student_profile_user (user_id),
    CONSTRAINT fk_student_profile_user
        FOREIGN KEY (user_id) REFERENCES `user` (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 4. OPPORTUNITY
CREATE TABLE IF NOT EXISTS opportunity (
    opp_id INT NOT NULL AUTO_INCREMENT,
    company_id INT DEFAULT NULL,
    title VARCHAR(150) NOT NULL,
    type VARCHAR(20) DEFAULT NULL,
    skill_required VARCHAR(255) DEFAULT NULL,
    location VARCHAR(100) DEFAULT NULL,
    description TEXT,
    posted_date DATE DEFAULT NULL,
    application_deadline DATE DEFAULT NULL,
    min_cgpa DECIMAL(4,2) DEFAULT NULL,
    eligible_departments VARCHAR(500) DEFAULT NULL,
    graduation_year INT DEFAULT NULL,
    PRIMARY KEY (opp_id),
    KEY idx_opportunity_company (company_id),
    CONSTRAINT fk_opportunity_company
        FOREIGN KEY (company_id) REFERENCES company (company_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 5. APPLICATION
CREATE TABLE IF NOT EXISTS application (
    app_id INT NOT NULL AUTO_INCREMENT,
    student_id INT DEFAULT NULL,
    opp_id INT DEFAULT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    applied_date DATE DEFAULT NULL,
    PRIMARY KEY (app_id),
    UNIQUE KEY uk_application_student_opportunity (student_id, opp_id),
    KEY idx_application_opportunity (opp_id),
    CONSTRAINT fk_application_student
        FOREIGN KEY (student_id) REFERENCES `user` (user_id),
    CONSTRAINT fk_application_opportunity
        FOREIGN KEY (opp_id) REFERENCES opportunity (opp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 6. STUDENT PROJECTS
CREATE TABLE IF NOT EXISTS student_projects (
    project_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    project_title VARCHAR(150) NOT NULL,
    description TEXT,
    technologies VARCHAR(500) DEFAULT NULL,
    project_link VARCHAR(500) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id),
    KEY idx_student_projects_user (user_id),
    CONSTRAINT fk_student_projects_user
        FOREIGN KEY (user_id) REFERENCES `user` (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 7. NOTIFICATIONS
CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    message VARCHAR(500) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (notification_id),
    KEY idx_notifications_user_read (user_id, is_read),
    CONSTRAINT fk_notifications_user
        FOREIGN KEY (user_id) REFERENCES `user` (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- CampusConnect database structure created successfully.
