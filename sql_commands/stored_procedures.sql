DELIMITER $$

CREATE PROCEDURE GetEmployeeSummary(IN p_emp_id INT)
BEGIN

    -- 1. TOTAL PROJECTS HANDLED BY EMPLOYEE
    SELECT 
        e.emp_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        COUNT(pa.project_id) AS total_projects_handled
    FROM Employee e
    LEFT JOIN ProjectAssignment pa ON e.emp_id = pa.emp_id
    WHERE e.emp_id = p_emp_id
    GROUP BY e.emp_id, e.first_name, e.last_name;



    -- 2. TOTAL SKILLS OF EMPLOYEE
    SELECT 
        e.emp_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        COUNT(es.skill_id) AS total_skills
    FROM Employee e
    LEFT JOIN EmployeeSkill es ON e.emp_id = es.emp_id
    WHERE e.emp_id = p_emp_id
    GROUP BY e.emp_id, e.first_name, e.last_name;



    -- 3. EMPLOYEE YEARS OF EXPERIENCE
    SELECT 
        e.emp_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.experience AS listed_experience_years,
        TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) AS years_at_company,
        (e.experience + TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE())) AS total_years_of_experience
    FROM Employee e
    WHERE e.emp_id = p_emp_id;



    -- 4. PROJECT DURATION (ALL PROJECTS OF EMPLOYEE)
    SELECT 
        p.project_id,
        p.project_name,
        p.start_date,
        COALESCE(p.end_date, CURDATE()) AS end_date,
        TIMESTAMPDIFF(DAY,  p.start_date, COALESCE(p.end_date, CURDATE())) AS duration_days,
        TIMESTAMPDIFF(MONTH, p.start_date, COALESCE(p.end_date, CURDATE())) AS duration_months,
        TIMESTAMPDIFF(YEAR,  p.start_date, COALESCE(p.end_date, CURDATE())) AS duration_years,
        pa.role,
        pa.hours_allocated
    FROM ProjectAssignment pa
    JOIN Project p ON pa.project_id = p.project_id
    WHERE pa.emp_id = p_emp_id
    ORDER BY p.start_date;



    -- 5. NET SALARY
    SELECT 
        e.emp_id,
        CONCAT(e.first_name, ' ', e.last_name)     AS employee_name,
        j.job_title,
        s.amount                                    AS gross_salary,

        -- Tax brackets (progressive)
        CASE
            WHEN s.amount <= 30000  THEN 0.00
            WHEN s.amount <= 60000  THEN ROUND(s.amount * 0.10, 2)
            WHEN s.amount <= 100000 THEN ROUND(s.amount * 0.20, 2)
            WHEN s.amount <= 150000 THEN ROUND(s.amount * 0.25, 2)
            ELSE                         ROUND(s.amount * 0.30, 2)
        END AS estimated_tax_deduction,

        -- Benefits / other standard deductions (5% of gross)
        ROUND(s.amount * 0.05, 2) AS benefits_deduction,

        -- Net salary
        CASE
            WHEN s.amount <= 30000  THEN ROUND(s.amount - (s.amount * 0.05), 2)
            WHEN s.amount <= 60000  THEN ROUND(s.amount - (s.amount * 0.10) - (s.amount * 0.05), 2)
            WHEN s.amount <= 100000 THEN ROUND(s.amount - (s.amount * 0.20) - (s.amount * 0.05), 2)
            WHEN s.amount <= 150000 THEN ROUND(s.amount - (s.amount * 0.25) - (s.amount * 0.05), 2)
            ELSE                         ROUND(s.amount - (s.amount * 0.30) - (s.amount * 0.05), 2)
        END AS net_salary

    FROM Employee e
    JOIN Job j      ON e.job_id    = j.job_id
    JOIN Salary s   ON e.emp_id    = s.emp_id
    WHERE e.emp_id  = p_emp_id
      AND s.end_date IS NULL;   -- current salary record only

END$$

DELIMITER ;

CALL GetEmployeeSummary(3001);
