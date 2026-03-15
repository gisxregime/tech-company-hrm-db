-- ================================================
-- CREATE USER ACCOUNTS
-- ================================================

-- HR Manager
CREATE USER 'hr_manager'@'localhost' IDENTIFIED BY 'HRManager@2024!';

-- HR Staff
CREATE USER 'hr_staff'@'localhost' IDENTIFIED BY 'HRStaff@2024!';

-- Finance Manager
CREATE USER 'finance_manager'@'localhost' IDENTIFIED BY 'FinanceManager@2024!';

-- Finance Staff
CREATE USER 'finance_staff'@'localhost' IDENTIFIED BY 'FinanceStaff@2024!';

-- Project Manager
CREATE USER 'project_manager'@'localhost' IDENTIFIED BY 'ProjectManager@2024!';

-- Developer
CREATE USER 'developer'@'localhost' IDENTIFIED BY 'Developer@2024!';

-- Read Only Auditor
CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'Auditor@2024!';

-- Database Administrator
CREATE USER 'db_admin'@'localhost' IDENTIFIED BY 'DBAdmin@2024!';


-- ================================================
-- CREATE ROLES
-- ================================================

CREATE ROLE 'role_hr_manager';
CREATE ROLE 'role_hr_staff';
CREATE ROLE 'role_finance_manager';
CREATE ROLE 'role_finance_staff';
CREATE ROLE 'role_project_manager';
CREATE ROLE 'role_developer';
CREATE ROLE 'role_auditor';
CREATE ROLE 'role_db_admin';


-- ================================================
-- GRANT PRIVILEGES TO ROLES
-- ================================================

-- -------------------------------------------------
-- HR MANAGER ROLE
-- Full access to employee-related tables
-- Can manage employee records, statuses, and skills
-- -------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE 
    ON Employee         TO 'role_hr_manager';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON EmployeeStatus   TO 'role_hr_manager';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON EmployeeSkill    TO 'role_hr_manager';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON Skill            TO 'role_hr_manager';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON Department       TO 'role_hr_manager';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON Job              TO 'role_hr_manager';

-- HR Manager can view but not modify salary
GRANT SELECT 
    ON Salary           TO 'role_hr_manager';

-- HR Manager can view projects and assignments
GRANT SELECT 
    ON Project          TO 'role_hr_manager';

GRANT SELECT 
    ON ProjectAssignment TO 'role_hr_manager';

-- HR Manager can execute the summary procedure
GRANT EXECUTE 
    ON PROCEDURE GetEmployeeSummary TO 'role_hr_manager';


-- -------------------------------------------------
-- HR STAFF ROLE
-- Limited access — can view and update basic info
-- Cannot delete or access salary data
-- -------------------------------------------------
GRANT SELECT, UPDATE 
    ON Employee         TO 'role_hr_staff';

GRANT SELECT, INSERT, UPDATE 
    ON EmployeeStatus   TO 'role_hr_staff';

GRANT SELECT 
    ON EmployeeSkill    TO 'role_hr_staff';

GRANT SELECT 
    ON Skill            TO 'role_hr_staff';

GRANT SELECT 
    ON Department       TO 'role_hr_staff';

GRANT SELECT 
    ON Job              TO 'role_hr_staff';


-- -------------------------------------------------
-- FINANCE MANAGER ROLE
-- Full access to salary data
-- Read-only on employee info for context
-- -------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE 
    ON Salary           TO 'role_finance_manager';

GRANT SELECT 
    ON Employee         TO 'role_finance_manager';

GRANT SELECT 
    ON Job              TO 'role_finance_manager';

GRANT SELECT 
    ON Department       TO 'role_finance_manager';

GRANT SELECT 
    ON EmployeeStatus   TO 'role_finance_manager';

-- Finance Manager can execute the summary procedure
GRANT EXECUTE 
    ON PROCEDURE GetEmployeeSummary TO 'role_finance_manager';


-- -------------------------------------------------
-- FINANCE STAFF ROLE
-- Can only view salary records — no modifications
-- -------------------------------------------------
GRANT SELECT 
    ON Salary           TO 'role_finance_staff';

GRANT SELECT 
    ON Employee         TO 'role_finance_staff';

GRANT SELECT 
    ON Job              TO 'role_finance_staff';

GRANT SELECT 
    ON Department       TO 'role_finance_staff';


-- -------------------------------------------------
-- PROJECT MANAGER ROLE
-- Full access to project-related tables
-- Read-only on employee info
-- -------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE 
    ON Project          TO 'role_project_manager';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON ProjectAssignment TO 'role_project_manager';

GRANT SELECT 
    ON Employee         TO 'role_project_manager';

GRANT SELECT 
    ON Department       TO 'role_project_manager';

GRANT SELECT 
    ON Job              TO 'role_project_manager';

GRANT SELECT 
    ON EmployeeSkill    TO 'role_project_manager';

GRANT SELECT 
    ON Skill            TO 'role_project_manager';

-- Project Manager can execute the summary procedure
GRANT EXECUTE 
    ON PROCEDURE GetEmployeeSummary TO 'role_project_manager';


-- -------------------------------------------------
-- DEVELOPER ROLE
-- Read-only access to non-sensitive tables
-- No access to salary or personal employee data
-- -------------------------------------------------
GRANT SELECT 
    ON Project          TO 'role_developer';

GRANT SELECT 
    ON ProjectAssignment TO 'role_developer';

GRANT SELECT 
    ON Skill            TO 'role_developer';

GRANT SELECT 
    ON EmployeeSkill    TO 'role_developer';

GRANT SELECT 
    ON Department       TO 'role_developer';

GRANT SELECT 
    ON Job              TO 'role_developer';


-- -------------------------------------------------
-- AUDITOR ROLE
-- Read-only access to ALL tables for auditing
-- Cannot modify any data whatsoever
-- -------------------------------------------------
GRANT SELECT ON Employee          TO 'role_auditor';
GRANT SELECT ON EmployeeStatus    TO 'role_auditor';
GRANT SELECT ON EmployeeSkill     TO 'role_auditor';
GRANT SELECT ON Skill             TO 'role_auditor';
GRANT SELECT ON Department        TO 'role_auditor';
GRANT SELECT ON Job               TO 'role_auditor';
GRANT SELECT ON Salary            TO 'role_auditor';
GRANT SELECT ON Project           TO 'role_auditor';
GRANT SELECT ON ProjectAssignment TO 'role_auditor';

-- Auditor can execute the summary procedure (read only)
GRANT EXECUTE 
    ON PROCEDURE GetEmployeeSummary TO 'role_auditor';


-- -------------------------------------------------
-- DB ADMIN ROLE
-- Full privileges on all tables
-- -------------------------------------------------
GRANT ALL PRIVILEGES 
    ON Employee          TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON EmployeeStatus    TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON EmployeeSkill     TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON Skill             TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON Department        TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON Job               TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON Salary            TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON Project           TO 'role_db_admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES 
    ON ProjectAssignment TO 'role_db_admin' WITH GRANT OPTION;

GRANT EXECUTE 
    ON PROCEDURE GetEmployeeSummary TO 'role_db_admin' WITH GRANT OPTION;


-- ================================================
-- ASSIGN ROLES TO USERS
-- ================================================

GRANT 'role_hr_manager'      TO 'hr_manager'@'localhost';
GRANT 'role_hr_staff'        TO 'hr_staff'@'localhost';
GRANT 'role_finance_manager' TO 'finance_manager'@'localhost';
GRANT 'role_finance_staff'   TO 'finance_staff'@'localhost';
GRANT 'role_project_manager' TO 'project_manager'@'localhost';
GRANT 'role_developer'       TO 'developer'@'localhost';
GRANT 'role_auditor'         TO 'auditor'@'localhost';
GRANT 'role_db_admin'        TO 'db_admin'@'localhost';


-- ================================================
-- ACTIVATE DEFAULT ROLES FOR EACH USER
-- ================================================

SET DEFAULT ROLE 'role_hr_manager'      TO 'hr_manager'@'localhost';
SET DEFAULT ROLE 'role_hr_staff'        TO 'hr_staff'@'localhost';
SET DEFAULT ROLE 'role_finance_manager' TO 'finance_manager'@'localhost';
SET DEFAULT ROLE 'role_finance_staff'   TO 'finance_staff'@'localhost';
SET DEFAULT ROLE 'role_project_manager' TO 'project_manager'@'localhost';
SET DEFAULT ROLE 'role_developer'       TO 'developer'@'localhost';
SET DEFAULT ROLE 'role_auditor'         TO 'auditor'@'localhost';
SET DEFAULT ROLE 'role_db_admin'        TO 'db_admin'@'localhost';


-- ================================================
-- FLUSH PRIVILEGES
-- ================================================

FLUSH PRIVILEGES;


-- ================================================
-- REVOKE EXAMPLES
-- ================================================

-- Revoke DELETE from HR Staff on EmployeeStatus (they shouldn't be able to delete statuses)
REVOKE DELETE 
    ON EmployeeStatus FROM 'role_hr_staff';

-- Revoke INSERT and UPDATE from Finance Staff (view-only enforcement)
REVOKE INSERT, UPDATE 
    ON Salary FROM 'role_finance_staff';

-- Revoke Developer access to EmployeeSkill if sensitive project ends
REVOKE SELECT 
    ON EmployeeSkill FROM 'role_developer';

-- Revoke Auditor access to Salary for a specific compliance period
REVOKE SELECT 
    ON Salary FROM 'role_auditor';

-- Revoke a role entirely from a user (e.g. temporary contractor done)
REVOKE 'role_project_manager' FROM 'project_manager'@'localhost';

-- Revoke all privileges from a user (e.g. employee terminated)
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hr_staff'@'localhost';


-- ================================================
-- VERIFY GRANTS (for checking purposes)
-- ================================================

SHOW GRANTS FOR 'hr_manager'@'localhost';
SHOW GRANTS FOR 'hr_staff'@'localhost';
SHOW GRANTS FOR 'finance_manager'@'localhost';
SHOW GRANTS FOR 'finance_staff'@'localhost';
SHOW GRANTS FOR 'project_manager'@'localhost';
SHOW GRANTS FOR 'developer'@'localhost';
SHOW GRANTS FOR 'auditor'@'localhost';
SHOW GRANTS FOR 'db_admin'@'localhost';


-- ================================================
-- DROP USERS (cleanup example if needed)
-- ================================================

-- DROP USER 'hr_staff'@'localhost';
-- DROP USER 'developer'@'localhost';
