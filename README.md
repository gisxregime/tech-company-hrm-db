# Human Resource Management (HRM) Database System

> A relational database system designed and implemented for a technology company — built to demonstrate core concepts in database design, normalization, SQL, and data integrity.

---

## Overview

This project presents the design and implementation of a **Human Resource Management (HRM) database system** for a technology company. It demonstrates how relational database principles can be applied to manage employee-related information such as departments, job roles, skills, salary records, and project assignments.

The primary purpose of this project is **educational**. It was developed to apply and demonstrate concepts learned in *Fundamentals of Database Systems*, including relational database design, normalization, SQL queries, and data integrity constraints.

The project includes database documentation, entity relationship diagrams, SQL scripts, and sample datasets that simulate a realistic workforce environment within a technology company.

---

## Project Objectives

The system aims to demonstrate the following database concepts:

- Designing a normalized relational database schema
- Implementing primary keys and foreign key relationships
- Maintaining data integrity and reducing redundancy
- Managing employee information and organizational structure
- Writing and executing basic and advanced SQL queries
- Generating meaningful reports using SQL

---

## System Features

The database system models several core HR functions including:

- **Employee Information Management** — Store and manage complete employee profiles
- **Department and Job Role Organization** — Structure the organization into departments with defined roles and salary bands
- **Employee Skill Tracking** — Record skills with proficiency levels (Beginner, Intermediate, Advanced, Expert)
- **Salary History and Employment Status** — Maintain full historical records of salary changes and employment status transitions
- **Project Assignments** — Link employees to projects with defined roles and tracked hours
- **Workforce Reporting** — Generate insights through SQL queries and stored procedures

---

## Database Components

### Entity Relationship Diagram (ERD)
The ERD illustrates the structure of the database and the relationships between the following entities:

| Entity | Description |
|---|---|
| `Employee` | Core employee records |
| `Department` | Organizational departments |
| `Job` | Job titles with salary bands |
| `Skill` | Master list of technical and soft skills |
| `EmployeeSkill` | Employee–skill junction with proficiency levels |
| `Salary` | Salary history with effective and end dates |
| `EmployeeStatus` | Employment status history |
| `Project` | Project records with manager references |
| `ProjectAssignment` | Employee–project assignments with roles and hours |

### Documentation
Explains the background of the study, objectives, and database design decisions. Provides context for why the system was created and how the database supports employee management in a technology company.

### SQL Scripts
The SQL scripts contain the full database implementation, including:
- Table creation statements with `AUTO_INCREMENT` primary keys
- Primary key, foreign key, and unique constraints
- Sample SQL queries for common HR operations
- Advanced SQL queries for reporting and analysis
- Stored procedures for on-demand employee summaries

### Sample Dataset
A generated dataset that populates the database with realistic sample data:
- **200 employees** across 20 departments and 40 job titles
- **40 skills** spanning Programming, Cloud, DevOps, AI/ML, Security, Design, and more
- **Salary history** records with effective and end dates
- **50 projects** with statuses: Active, Completed, On Hold, Planning, Cancelled
- **300+ project assignments** with defined roles and allocated hours

---

## Technologies Used

- **MySQL / SQL** — Database implementation and queries
- **Relational Database Design** — Schema modeling and normalization
- **ERD Modeling Tools** — For database structure visualization

---

## Learning Outcomes

Through this project, the following database concepts were applied:

- [x] Relational database schema design
- [x] Entity relationships and normalization (1NF, 2NF, 3NF)
- [x] SQL data definition (`CREATE`, `ALTER`, `DROP`)
- [x] SQL data manipulation (`INSERT`, `UPDATE`, `DELETE`)
- [x] Basic SQL queries (`SELECT`, `JOIN`, `GROUP BY`, `ORDER BY`)
- [x] Advanced SQL queries (aggregations, subqueries, stored procedures)
- [x] Data integrity through constraints (PK, FK, `UNIQUE`, `NOT NULL`)
- [x] Role-based access control (`GRANT`, `REVOKE`)

---

## Project Structure

```
tech-company-hrm-db/
│
├── data/
│   └── sample_dataset.sql
│
├── docs/
│   └── IT6_documentation.pdf
│
├── erd/
│   └── erd_hrm.jpg
│
├── sql/
│   ├── hrm_database_schema.sql
│   └── ready_made_hrm_DB.sql
│
└── sql_commands/
    ├── events.sql
    ├── sec_grant_revoke.sql
    ├── stored_functions.sql
    ├── stored_procedures.sql
    └── triggers.sql
```

---

## Getting Started

### Prerequisites
- MySQL 8.0 or higher

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/hrm-database-system.git
   cd hrm-database-system
   ```

2. **Create the database**
   ```sql
   CREATE DATABASE hrm_db;
   USE hrm_db;
   ```

3. **Run the schema**
   ```bash
   mysql -u root -p hrm_db < sql/hrm_database_schema.sql
   ```

4. **Load the sample data**
   ```bash
   mysql -u root -p hrm_db < data/sample_dataset.sql
   ```

5. **Start exploring**
   ```sql
   SELECT * FROM Employee LIMIT 10;
   CALL GetEmployeeSummary(3001);
   ```

---

## Educational Purpose

This project was created for **educational purposes** to demonstrate the application of database concepts learned in a *Fundamentals of Database Systems* course. It is intended for learning, experimentation, and academic reference.

---

## Author

**Diana Grace Cinco** <br>
**Reaj Dabi** <br>
**Sebastian Lastimoso** 
