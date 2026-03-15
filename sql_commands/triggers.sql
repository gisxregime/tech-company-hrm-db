-- Triggers -- 

-- Automatically create employee --
use db;
DELIMITER $$

CREATE TRIGGER trg_after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_status(employee_id, status, created_at)
    VALUES (NEW.employee_id, 'Active', NOW());
END$$

DELIMITER ;

-- salary updates --
DELIMITER $$

CREATE TRIGGER trg_salary_update_log
AFTER UPDATE ON salaries
FOR EACH ROW
BEGIN
    IF OLD.salary_amount <> NEW.salary_amount THEN
        INSERT INTO salary_log(employee_id, old_salary, new_salary, change_date)
        VALUES (NEW.employee_id, OLD.salary_amount, NEW.salary_amount, NOW());
    END IF;
END$$

DELIMITER ;

-- Prevent duplicate --
DELIMITER $$

CREATE TRIGGER trg_prevent_duplicate_skill
BEFORE INSERT ON employee_skills
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM employee_skills
        WHERE employee_id = NEW.employee_id
        AND skill_id = NEW.skill_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate skill assignment not allowed';
    END IF;
END$$

DELIMITER ;

-- Update project status --
DELIMITER $$

CREATE TRIGGER trg_update_project_status
BEFORE UPDATE ON projects
FOR EACH ROW
BEGIN
    IF NEW.end_date <= CURDATE() THEN
        SET NEW.status = 'Completed';
    END IF;
END$$

DELIMITER ;

-- Validate project --
DELIMITER $$

CREATE TRIGGER trg_validate_project_assignment
BEFORE INSERT ON project_assignments
FOR EACH ROW
BEGIN
    DECLARE emp_status VARCHAR(20);

    SELECT status INTO emp_status
    FROM employee_status
    WHERE employee_id = NEW.employee_id;

    IF emp_status <> 'Active' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee is not active';
    END IF;
END$$

DELIMITER ;

