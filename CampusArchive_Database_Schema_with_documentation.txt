-- ===================================================
-- Campus Project Repository - MySQL Database DDL
-- Engine: InnoDB | Character Set: utf8mb4
-- ===================================================

CREATE DATABASE IF NOT EXISTS campus_repository 
/*IF NOT EXISTS: Only create the database if it doesn't already exist.*/

  CHARACTER SET utf8mb4
  /*CHARACTER SET utf8mb4: This tells MySQL how text should be stored.*/
  /*utf8mb4 is a Unicode character set that supports a very wide range of characters*/
  
  COLLATE utf8mb4_unicode_ci;
  /*COLLATE: A collation determines how text is compared and sorted.*/
  /*_ci: case insensitive*/

USE campus_repository;

-- ---------------------------------------------------
-- 1. Departments Table
-- ---------------------------------------------------
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_code VARCHAR(10) NOT NULL UNIQUE,
    dept_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*ENGINE=InnoDB: This tells MySQL to use the InnoDB storage engine.*/
/*DEFAULT CHARSET=utf8mb4: By default, text in this table should use utf8mb4.*/

/*InnoDB is the storage engine used by MySQL to store and manage the data inside your tables.
MySQL is the database management system, while InnoDB is the engine that actually manages how 
table data is stored, updated, deleted, locked, and related*/

-- ---------------------------------------------------
-- 2. Users Table
-- ---------------------------------------------------
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'FACULTY', 'ADMIN') NOT NULL,
    /*ENUM means the value must come from a predefined set*/

    department_id INT NOT NULL,
    roll_or_emp_id VARCHAR(50) UNIQUE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    last_login_at TIMESTAMP NULL DEFAULT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_department 
    /*"fk_users_department" is the name of the constraint*/

        FOREIGN KEY (department_id) REFERENCES departments(department_id)
        /*'department_id' column fron this table refrences 'department_id' column from departments table*/

        ON DELETE RESTRICT ON UPDATE CASCADE
        /*ON DELETE RESTRICT: if a DELETE query is tried, MySQL will reject it because other tables/data 
        still depends on the data that was being deleted*/
        /*if the data in the column is updated/changed, same will be applied to the related foreign keys*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------
-- 3. Projects Table
-- ---------------------------------------------------
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    abstract TEXT NOT NULL,
    academic_year INT NOT NULL,
    department_id INT NOT NULL,
    lead_student_id INT NOT NULL,
    guide_id INT NOT NULL,
    status ENUM('PENDING', 'NEEDS_REVISION', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    views_count INT NOT NULL DEFAULT 0,
    downloads_count INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    /*Soft delete field. Instead of actually deleting a project it just marks it as 
    deleted and the data stays in the db*/

    
    -- Foreign Key Constraints
    CONSTRAINT fk_projects_department 
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_projects_lead_student 
        FOREIGN KEY (lead_student_id) REFERENCES users(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_projects_guide 
        FOREIGN KEY (guide_id) REFERENCES users(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
        
    -- Performance Indexes
    INDEX idx_projects_status (status),
    /*INDEX: This creates an index on the column 'status'*/

    INDEX idx_projects_title (title),
    FULLTEXT INDEX idx_projects_fulltext (title, abstract)
    /*FULLTEXT INDEX: used for text searching*/

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------
-- 4. Project Authors Table (Junction: Projects <-> Users)
-- ---------------------------------------------------
CREATE TABLE project_authors (
    project_id INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (project_id, student_id),
    CONSTRAINT fk_authors_project 
        FOREIGN KEY (project_id) REFERENCES projects(project_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
        /*ON DELETE CASCADE: when a data is deleted from a table, all the 
        other data referencing it will also be deleted*/

    CONSTRAINT fk_authors_student 
        FOREIGN KEY (student_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------
-- 5. Project Attachments Table
-- ---------------------------------------------------
CREATE TABLE project_attachments (
    attachment_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    file_type ENUM('REPORT_PDF', 'SOURCE_ZIP', 'DIAGRAM') NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    stored_file_path VARCHAR(255) NOT NULL,
    file_size_bytes BIGINT NOT NULL,
    file_hash VARCHAR(64) NULL DEFAULT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_attachments_project 
        FOREIGN KEY (project_id) REFERENCES projects(project_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------
-- 6. Tags Table
-- ---------------------------------------------------
CREATE TABLE tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------
-- 7. Project Tags Table (Junction: Projects <-> Tags)
-- ---------------------------------------------------
CREATE TABLE project_tags (
    project_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (project_id, tag_id),
    CONSTRAINT fk_tags_project 
        FOREIGN KEY (project_id) REFERENCES projects(project_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tags_tag 
        FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------
-- 8. Faculty Reviews Table
-- ---------------------------------------------------
CREATE TABLE faculty_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    faculty_id INT NOT NULL,
    decision ENUM('APPROVED', 'REJECTED', 'REVISION_REQUESTED') NOT NULL,
    comments TEXT NULL,
    reviewed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reviews_project 
        FOREIGN KEY (project_id) REFERENCES projects(project_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reviews_faculty 
        FOREIGN KEY (faculty_id) REFERENCES users(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*ON DELETE CASCADE = delete dependent rows automatically.
ON DELETE RESTRICT = prevent deletion when dependent rows exist.*/
