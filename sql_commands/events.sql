-- EVENTS --

-- For event_scheduler --
SET GLOBAL event_scheduler = ON;

-- Automatically checks deadline --
CREATE EVENT check_project_deadlines
ON SCHEDULE EVERY 1 DAY
DO
UPDATE projects
SET status = 'Completed'
WHERE end_date <= CURDATE()
AND status <> 'Completed';

-- Monthly salary process --
CREATE EVENT monthly_salary_processing
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
INSERT INTO salary_payments(employee_id, payment_date, amount)
SELECT employee_id, CURDATE(), salary_amount
FROM salaries;

-- Archives complete projest --
CREATE EVENT archive_completed_projects
ON SCHEDULE EVERY 1 MONTH
DO
INSERT INTO archived_projects
SELECT *
FROM projects
WHERE status = 'Completed';

-- Detect inactive employees --
CREATE EVENT detect_inactive_employees
ON SCHEDULE EVERY 1 WEEK
DO
UPDATE employee_status
SET status = 'Inactive'
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM project_assignments
);

-- Annual salary increment --
CREATE EVENT annual_salary_increment
ON SCHEDULE EVERY 1 YEAR
DO
UPDATE salaries
SET salary_amount = salary_amount * 1.05;
