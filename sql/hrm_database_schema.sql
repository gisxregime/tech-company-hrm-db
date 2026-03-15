CREATE DATABASE hrm;
USE hrm;
Select * from Job;
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE Job (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    min_salary DECIMAL(10,2) NOT NULL,
    max_salary DECIMAL(10,2) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1),
    job_id INT,
    experience INT,
    FOREIGN KEY (job_id) REFERENCES Job(job_id)
);

CREATE TABLE Skill (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE EmployeeSkill (
    emp_id INT,
    skill_id INT,
    acquired_date DATE NOT NULL,
    proficiency VARCHAR(20) NOT NULL,

    PRIMARY KEY (emp_id, skill_id),

    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (skill_id) REFERENCES Skill(skill_id)
);

CREATE TABLE Salary (
    salary_id INT PRIMARY KEY,
    emp_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    effective_date DATE NOT NULL,
    end_date DATE,

    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

CREATE TABLE EmployeeStatus (
    status_id INT PRIMARY KEY,
    emp_id INT NOT NULL,
    status_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,

    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(150) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(50) NOT NULL,
    manager_id INT,

    FOREIGN KEY (manager_id) REFERENCES Employee(emp_id)
);

CREATE TABLE ProjectAssignment (
    assignment_id INT PRIMARY KEY,
    emp_id INT NOT NULL,
    project_id INT NOT NULL,
    assigned_date DATE,
    role VARCHAR(100),
    hours_allocated INT,

    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

        ALTER TABLE Department AUTO_INCREMENT = 1001;
	ALTER TABLE Job AUTO_INCREMENT = 2001;
	ALTER TABLE Employee AUTO_INCREMENT = 3001;
	ALTER TABLE Skill AUTO_INCREMENT = 4001;
	ALTER TABLE Salary AUTO_INCREMENT = 5001;
	ALTER TABLE EmployeeStatus AUTO_INCREMENT = 6001;
	ALTER TABLE Project AUTO_INCREMENT = 7001;
	ALTER TABLE ProjectAssignment AUTO_INCREMENT = 8001;


