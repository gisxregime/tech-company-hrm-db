-- Calculate total projects handled by an employee
    DELIMITER //
CREATE FUNCTION GetTotalProjects(emp_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE project_count INT;
    SELECT COUNT(*) INTO project_count 
    FROM ProjectAssignment AS P
    WHERE P.emp_id = emp_id;
    RETURN project_count;
END //
DELIMITER ;

-- Pag Use sa Function GetTotalProjects
SELECT 
    first_name, 
    last_name, 
    GetTotalProjects(emp_id) AS active_projects
FROM Employee;



-- Count total skills of an employee
DELIMITER //
CREATE FUNCTION GetSkillCount(emp_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE skill_count INT;
    SELECT COUNT(*) INTO skill_count 
    FROM EmployeeSkill AS ES
    WHERE ES.emp_id = emp_id;
    RETURN skill_count;
END //
DELIMITER ;
-- Skill Count na Function
SELECT first_name, last_name
FROM Employee
WHERE GetSkillCount(emp_id) > 5;

-- Calculate employee years of experience
DELIMITER //
CREATE FUNCTION GetYearsExperience(emp_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE yrs INT;
    SELECT FLOOR(DATEDIFF(CURDATE(), hire_date) / 365) INTO yrs 
    FROM Employee AS Emp
    WHERE Emp.emp_id = emp_id;
    RETURN yrs;
END //
DELIMITER ;

SELECT 
    first_name, 
    last_name, 
    GetYearsExperience(emp_id) AS tenure
FROM Employee;


-- Calculate project duration
DELIMITER //
CREATE FUNCTION GetProjectDuration(proj_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE duration INT;
    SELECT DATEDIFF(end_date, start_date) INTO duration 
    FROM Project 
    WHERE project_id = proj_id;
    RETURN duration;
END //
DELIMITER ;

-- Update project_id 7001 duration_days
ALTER TABLE Project
ADD COLUMN duration_days INT
DEFAULT 0; 
UPDATE Project
SET duration_days = GetProjectDuration(project_id)
WHERE project_id = 7001;
SELECT * FROM Project;




-- Calculate net salary

DELIMITER //
CREATE FUNCTION CalculateNetSalary(emp_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE gross_salary DECIMAL(10,2);
    DECLARE net_salary DECIMAL(10,2);
    
    SELECT Salary INTO gross_salary FROM Employee AS Emp WHERE Emp.emp_id = emp_id;
    -- Minus sa Tax (15%)
    SET net_salary = gross_salary * 0.85;
    
    RETURN net_salary;
END //
DELIMITER ;

-- Get the net salary for employee ID ??
SELECT CalculateNetSalary(/*Insert og emp_id*/) AS TakeHomePay;
