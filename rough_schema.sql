
Table departments {
  department_id int [pk, increment]
  dept_code varchar(10) [unique, not null]
  dept_name varchar(100) [not null]
  
  Note: 'Master reference table for college departments'
}

Table users {
  user_id int [pk, increment]
  full_name varchar(100) [not null]
  email varchar(120) [unique, not null]
  password_hash varchar(255) [not null]
  role enum('STUDENT', 'FACULTY', 'ADMIN') [not null]
  department_id int [not null, ref: > departments.department_id]
  roll_or_emp_id varchar(50) [unique]
  is_active boolean [default: true, note: 'Soft deletion flag for account status']
  last_login_at timestamp [null, note: 'Updated by backend on successful login']
  created_at timestamp [default: `CURRENT_TIMESTAMP`]

  Note: 'Stores credentials, roles, and status for all user accounts'
}

Table projects {
  project_id int [pk, increment]
  title varchar(255) [not null]
  abstract text [not null]
  academic_year int [not null]
  department_id int [not null, ref: > departments.department_id]
  lead_student_id int [not null, ref: > users.user_id]
  guide_id int [not null, ref: > users.user_id]
  status enum('PENDING', 'NEEDS_REVISION', 'APPROVED', 'REJECTED') [default: 'PENDING']
  views_count int [default: 0]
  downloads_count int [default: 0]
  created_at timestamp [default: `CURRENT_TIMESTAMP`]
  updated_at timestamp [default: `CURRENT_TIMESTAMP`]
  deleted_at timestamp [null, note: 'Null means active; timestamp indicates soft deletion time']

  Indexes {
    status [name: 'idx_projects_status']
    title [name: 'idx_projects_title']
    (title, abstract) [type: fulltext, name: 'idx_projects_fulltext']
  }

  Note: 'Core project submission entries'
}

Table project_authors {
  project_id int [ref: > projects.project_id]
  student_id int [ref: > users.user_id]

  Indexes {
    (project_id, student_id) [pk]
  }
  Note: 'Junction table for multi-student team members'
}

Table project_attachments {
  attachment_id int [pk, increment]
  project_id int [not null, ref: > projects.project_id]
  file_type enum('REPORT_PDF', 'SOURCE_ZIP', 'DIAGRAM') [not null]
  original_name varchar(255) [not null]
  stored_file_path varchar(255) [not null]
  file_size_bytes bigint [not null]
  file_hash varchar(64) [null, note: 'SHA-256 hash for integrity & deduplication']
  uploaded_at timestamp [default: `CURRENT_TIMESTAMP`]

  Note: 'Uploaded project reports, assets, and source code files'
}

Table tags {
  tag_id int [pk, increment]
  tag_name varchar(50) [unique, not null]

  Note: 'Master catalog of technology stacks'
}

Table project_tags {
  project_id int [ref: > projects.project_id]
  tag_id int [ref: > tags.tag_id]

  Indexes {
    (project_id, tag_id) [pk]
  }
  Note: 'Junction table linking projects to technology tags'
}

Table faculty_reviews {
  review_id int [pk, increment]
  project_id int [not null, ref: > projects.project_id]
  faculty_id int [not null, ref: > users.user_id]
  decision enum('APPROVED', 'REJECTED', 'REVISION_REQUESTED') [not null]
  comments text
  reviewed_at timestamp [default: `CURRENT_TIMESTAMP`]

  Note: 'Audit log of faculty evaluations and feedback history'
}